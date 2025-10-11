/// Represents an educational learning card with quick facts
class LearningCard {
  final String id;
  final String title;
  final String content;
  final String category; // planet, phenomenon, exploration, general
  final String? relatedId; // ID of related planet/phenomenon/exploration
  final String? imageUrl;
  final LearningCardDifficulty difficulty;
  final List<String> tags;
  final DateTime? createdAt;

  LearningCard({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.relatedId,
    this.imageUrl,
    this.difficulty = LearningCardDifficulty.medium,
    this.tags = const [],
    this.createdAt,
  });

  /// Convert to JSON for database storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'relatedId': relatedId,
      'imageUrl': imageUrl,
      'difficulty': difficulty.toString(),
      'tags': tags,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// Create from JSON from database
  factory LearningCard.fromJson(Map<String, dynamic> json) {
    return LearningCard(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      relatedId: json['relatedId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      difficulty: LearningCardDifficulty.values.firstWhere(
        (e) => e.toString() == json['difficulty'],
        orElse: () => LearningCardDifficulty.medium,
      ),
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  /// Create a copy with updated fields
  LearningCard copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? relatedId,
    String? imageUrl,
    LearningCardDifficulty? difficulty,
    List<String>? tags,
    DateTime? createdAt,
  }) {
    return LearningCard(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      relatedId: relatedId ?? this.relatedId,
      imageUrl: imageUrl ?? this.imageUrl,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Difficulty levels for learning cards
enum LearningCardDifficulty {
  easy,
  medium,
  hard,
}

/// Extension for difficulty display
extension LearningCardDifficultyExtension on LearningCardDifficulty {
  String get displayName {
    switch (this) {
      case LearningCardDifficulty.easy:
        return '쉬움';
      case LearningCardDifficulty.medium:
        return '보통';
      case LearningCardDifficulty.hard:
        return '어려움';
    }
  }

  String get emoji {
    switch (this) {
      case LearningCardDifficulty.easy:
        return '🟢';
      case LearningCardDifficulty.medium:
        return '🟡';
      case LearningCardDifficulty.hard:
        return '🔴';
    }
  }
}
