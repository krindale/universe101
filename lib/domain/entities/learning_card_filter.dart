import 'learning_card.dart';

/// Filter settings for learning cards
class LearningCardFilter {
  final String? category;
  final LearningCardDifficulty? difficulty;
  final List<String> selectedTags;
  final bool? isCompleted; // null = all, true = completed, false = not completed
  final String searchQuery;
  final DateTime? dateAddedAfter;
  final DateTime? dateAddedBefore;

  const LearningCardFilter({
    this.category,
    this.difficulty,
    this.selectedTags = const [],
    this.isCompleted,
    this.searchQuery = '',
    this.dateAddedAfter,
    this.dateAddedBefore,
  });

  /// Check if any filters are active
  bool get hasActiveFilters {
    return category != null ||
        difficulty != null ||
        selectedTags.isNotEmpty ||
        isCompleted != null ||
        searchQuery.isNotEmpty ||
        dateAddedAfter != null ||
        dateAddedBefore != null;
  }

  /// Get count of active filters
  int get activeFilterCount {
    int count = 0;
    if (category != null && category != 'all') count++;
    if (difficulty != null) count++;
    if (selectedTags.isNotEmpty) count += selectedTags.length;
    if (isCompleted != null) count++;
    if (searchQuery.isNotEmpty) count++;
    if (dateAddedAfter != null) count++;
    if (dateAddedBefore != null) count++;
    return count;
  }

  /// Create a copy with updated fields
  LearningCardFilter copyWith({
    String? category,
    LearningCardDifficulty? difficulty,
    List<String>? selectedTags,
    bool? isCompleted,
    String? searchQuery,
    DateTime? dateAddedAfter,
    DateTime? dateAddedBefore,
    bool clearCategory = false,
    bool clearDifficulty = false,
    bool clearIsCompleted = false,
    bool clearDateAddedAfter = false,
    bool clearDateAddedBefore = false,
  }) {
    return LearningCardFilter(
      category: clearCategory ? null : (category ?? this.category),
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      selectedTags: selectedTags ?? this.selectedTags,
      isCompleted: clearIsCompleted ? null : (isCompleted ?? this.isCompleted),
      searchQuery: searchQuery ?? this.searchQuery,
      dateAddedAfter: clearDateAddedAfter ? null : (dateAddedAfter ?? this.dateAddedAfter),
      dateAddedBefore: clearDateAddedBefore ? null : (dateAddedBefore ?? this.dateAddedBefore),
    );
  }

  /// Create empty filter (no filters applied)
  factory LearningCardFilter.empty() {
    return const LearningCardFilter();
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'difficulty': difficulty?.toString(),
      'selectedTags': selectedTags,
      'isCompleted': isCompleted,
      'searchQuery': searchQuery,
      'dateAddedAfter': dateAddedAfter?.toIso8601String(),
      'dateAddedBefore': dateAddedBefore?.toIso8601String(),
    };
  }

  /// Create from JSON
  factory LearningCardFilter.fromJson(Map<String, dynamic> json) {
    return LearningCardFilter(
      category: json['category'] as String?,
      difficulty: json['difficulty'] != null
          ? LearningCardDifficulty.values.firstWhere(
              (e) => e.toString() == json['difficulty'],
              orElse: () => LearningCardDifficulty.medium,
            )
          : null,
      selectedTags: json['selectedTags'] != null
          ? List<String>.from(json['selectedTags'] as List)
          : const [],
      isCompleted: json['isCompleted'] as bool?,
      searchQuery: json['searchQuery'] as String? ?? '',
      dateAddedAfter: json['dateAddedAfter'] != null
          ? DateTime.parse(json['dateAddedAfter'] as String)
          : null,
      dateAddedBefore: json['dateAddedBefore'] != null
          ? DateTime.parse(json['dateAddedBefore'] as String)
          : null,
    );
  }

  /// Apply filter to a list of cards
  List<LearningCard> apply(List<LearningCard> cards, Set<String> completedCardIds) {
    List<LearningCard> filtered = cards;

    // Category filter
    if (category != null && category != 'all') {
      filtered = filtered.where((card) => card.category == category).toList();
    }

    // Difficulty filter
    if (difficulty != null) {
      filtered = filtered.where((card) => card.difficulty == difficulty).toList();
    }

    // Tags filter (card must have at least one of the selected tags)
    if (selectedTags.isNotEmpty) {
      filtered = filtered.where((card) {
        return selectedTags.any((tag) => card.tags.contains(tag));
      }).toList();
    }

    // Completion status filter
    if (isCompleted != null) {
      filtered = filtered.where((card) {
        final isCardCompleted = completedCardIds.contains(card.id);
        return isCompleted == isCardCompleted;
      }).toList();
    }

    // Search query filter (search in title and content)
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((card) {
        return card.title.toLowerCase().contains(query) ||
            card.content.toLowerCase().contains(query) ||
            card.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    }

    // Date added filter
    if (dateAddedAfter != null && dateAddedBefore != null) {
      filtered = filtered.where((card) {
        if (card.createdAt == null) return false;
        return card.createdAt!.isAfter(dateAddedAfter!) &&
            card.createdAt!.isBefore(dateAddedBefore!);
      }).toList();
    } else if (dateAddedAfter != null) {
      filtered = filtered.where((card) {
        if (card.createdAt == null) return false;
        return card.createdAt!.isAfter(dateAddedAfter!);
      }).toList();
    } else if (dateAddedBefore != null) {
      filtered = filtered.where((card) {
        if (card.createdAt == null) return false;
        return card.createdAt!.isBefore(dateAddedBefore!);
      }).toList();
    }

    return filtered;
  }

  @override
  String toString() {
    return 'LearningCardFilter(category: $category, difficulty: $difficulty, '
        'tags: $selectedTags, isCompleted: $isCompleted, searchQuery: $searchQuery, '
        'dateAddedAfter: $dateAddedAfter, dateAddedBefore: $dateAddedBefore)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LearningCardFilter &&
        other.category == category &&
        other.difficulty == difficulty &&
        other.selectedTags.toString() == selectedTags.toString() &&
        other.isCompleted == isCompleted &&
        other.searchQuery == searchQuery &&
        other.dateAddedAfter == dateAddedAfter &&
        other.dateAddedBefore == dateAddedBefore;
  }

  @override
  int get hashCode {
    return Object.hash(
      category,
      difficulty,
      selectedTags,
      isCompleted,
      searchQuery,
      dateAddedAfter,
      dateAddedBefore,
    );
  }
}
