import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/learning_card.dart';
import '../../domain/entities/learning_card_filter.dart';
import '../../domain/entities/user_progress.dart';
import '../../domain/services/share_service.dart';
import '../../domain/services/filter_persistence_service.dart';
import '../../domain/repositories/user_progress_repository.dart';
import '../../data/repositories/user_progress_repository_impl.dart';
import '../../data/datasources/database_helper.dart';
import '../../data/datasources/learning_cards_data.dart';
import '../widgets/swipeable_card.dart';

/// Main screen for displaying swipeable learning cards with progress tracking
class LearningCardsScreen extends StatefulWidget {
  const LearningCardsScreen({super.key});

  @override
  State<LearningCardsScreen> createState() => _LearningCardsScreenState();
}

class _LearningCardsScreenState extends State<LearningCardsScreen> {
  static const String _defaultUserId = 'default_user';

  List<LearningCard> _allCards = [];
  List<LearningCard> _filteredCards = [];
  int _currentIndex = 0;
  final ShareService _shareService = ShareService();
  final FilterPersistenceService _filterService = FilterPersistenceService();
  LearningCardFilter _currentFilter = LearningCardFilter.empty();
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  // Progress tracking
  late final UserProgressRepository _progressRepository;
  UserProgress? _userProgress;
  Map<String, dynamic> _stats = {};
  bool _isLoadingProgress = true;

  @override
  void initState() {
    super.initState();
    _progressRepository = UserProgressRepositoryImpl(DatabaseHelper());
    _loadCards();
    _loadSavedFilter();
    _initializeUserProgress();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _initializeUserProgress() async {
    try {
      // Check if user progress exists
      final exists = await _progressRepository.exists(_defaultUserId);

      if (!exists) {
        // Create initial user progress
        final initialProgress = UserProgress(
          id: _defaultUserId,
          userId: _defaultUserId,
          favoriteCelestialBodies: [],
          favoritePhenomena: [],
          favoriteExplorations: [],
          completedLearningCards: {},
          totalCardsViewed: 0,
          totalTimeSpentMinutes: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _progressRepository.createUserProgress(initialProgress);
      }

      // Load user progress
      await _loadUserProgress();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('진행 상황을 불러오는 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoadingProgress = false;
      });
    }
  }

  Future<void> _loadUserProgress() async {
    try {
      final progress = await _progressRepository.getUserProgress(_defaultUserId);
      final stats = await _progressRepository.getCompletionStats(_defaultUserId);

      setState(() {
        _userProgress = progress;
        _stats = stats;
        _applyFilters();
      });
    } catch (e) {
      debugPrint('Error loading user progress: $e');
    }
  }

  Set<String> get _completedCardIds {
    if (_userProgress == null) return {};
    return _userProgress!.completedLearningCards.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toSet();
  }

  Future<void> _loadSavedFilter() async {
    final savedFilter = await _filterService.loadFilter();
    setState(() {
      _currentFilter = savedFilter;
      _searchController.text = savedFilter.searchQuery;
      _applyFilters();
    });
  }

  void _loadCards() {
    setState(() {
      _allCards = LearningCardsData.getSampleCards();
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredCards = _currentFilter.apply(_allCards, _completedCardIds);
      _currentIndex = 0;
    });
  }

  Future<void> _updateFilter(LearningCardFilter newFilter) async {
    setState(() {
      _currentFilter = newFilter;
      _applyFilters();
    });
    await _filterService.saveFilter(newFilter);
  }

  Future<void> _onCardSwiped(String cardId, bool learned) async {
    if (learned) {
      try {
        // Save to database
        await _progressRepository.markCardAsCompleted(_defaultUserId, cardId);
        // Reload user progress
        await _loadUserProgress();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('진행 상황 저장 중 오류가 발생했습니다: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    setState(() {
      _currentIndex++;
    });
  }

  void _resetCards() {
    setState(() {
      _currentIndex = 0;
    });
  }

  Future<void> _clearAllFilters() async {
    setState(() {
      _currentFilter = LearningCardFilter.empty();
      _searchController.clear();
      _applyFilters();
    });
    await _filterService.clearFilter();
  }

  Future<void> _shareCard(LearningCard card) async {
    try {
      await _shareService.shareLearningCard(card);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('공유 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Get all unique tags from all cards
  List<String> _getAllTags() {
    final tags = <String>{};
    for (final card in _allCards) {
      tags.addAll(card.tags);
    }
    return tags.toList()..sort();
  }

  // Get completion stats for a category
  int _getCompletedCountForCategory(String category) {
    if (_userProgress == null) return 0;

    final categoryCards = _allCards.where((card) =>
      card.category == category
    );

    return categoryCards.where((card) =>
      _completedCardIds.contains(card.id)
    ).length;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingProgress) {
      return const Scaffold(
        backgroundColor: AppColors.deepSpace,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.cosmicBlue),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.deepSpace,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '학습 카드',
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          // Statistics button
          IconButton(
            icon: const Icon(Icons.bar_chart, color: AppColors.stardustGold),
            onPressed: _showStatistics,
          ),
          // Filter toggle button
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  _showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                  color: _currentFilter.hasActiveFilters
                      ? AppColors.stardustGold
                      : AppColors.textSecondary,
                ),
                if (_currentFilter.activeFilterCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.solarOrange,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${_currentFilter.activeFilterCount}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
          // Progress indicator
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.paddingMD),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMD,
                  vertical: AppSpacing.paddingSM,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.stardustGold, AppColors.solarOrange],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.school,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${_completedCardIds.length}/${_allCards.length}',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),

          // Filter panel (collapsible)
          if (_showFilters) _buildFilterPanel(),

          const SizedBox(height: AppSpacing.md),

          // Active filters chips
          if (_currentFilter.hasActiveFilters) _buildActiveFiltersChips(),

          // Card Stack
          Expanded(
            child: _buildCardStack(),
          ),

          // Action Buttons
          _buildActionButtons(),

          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  void _showStatistics() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cosmicBlue.withValues(alpha: 0.95),
              AppColors.nebulaPurple.withValues(alpha: 0.95),
            ],
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXL),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                '학습 통계',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Statistics
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildStatItem(
                        '총 완료 카드',
                        '${_stats['completedCards'] ?? 0}',
                        Icons.check_circle,
                        AppColors.stardustGold,
                      ),
                      _buildStatItem(
                        '완료율',
                        '${(_stats['completionPercentage'] ?? 0).toStringAsFixed(1)}%',
                        Icons.trending_up,
                        AppColors.cosmicBlue,
                      ),
                      _buildStatItem(
                        '총 학습 시간',
                        '${_stats['totalTimeSpentMinutes'] ?? 0}분',
                        Icons.access_time,
                        AppColors.nebulaPurple,
                      ),
                      _buildStatItem(
                        '조회한 카드',
                        '${_stats['totalCardsViewed'] ?? 0}',
                        Icons.visibility,
                        AppColors.solarOrange,
                      ),

                      const SizedBox(height: AppSpacing.xl),

                      // Achievement badges
                      _buildAchievementBadges(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.stardustGold,
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.paddingLG,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                  ),
                  child: const Text('닫기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.paddingMD),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: AppTypography.headlineSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadges() {
    final completedCount = _completedCardIds.length;
    final achievements = [
      {'milestone': 10, 'icon': Icons.star, 'title': '입문자', 'color': AppColors.solarOrange},
      {'milestone': 25, 'icon': Icons.emoji_events, 'title': '탐험가', 'color': AppColors.stardustGold},
      {'milestone': 50, 'icon': Icons.workspace_premium, 'title': '전문가', 'color': AppColors.cosmicBlue},
      {'milestone': 100, 'icon': Icons.diamond, 'title': '마스터', 'color': AppColors.nebulaPurple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '업적 배지',
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: achievements.map((achievement) {
            final milestone = achievement['milestone'] as int;
            final isUnlocked = completedCount >= milestone;
            final icon = achievement['icon'] as IconData;
            final title = achievement['title'] as String;
            final color = achievement['color'] as Color;

            return Container(
              width: 80,
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              decoration: BoxDecoration(
                color: isUnlocked
                    ? color.withValues(alpha: 0.2)
                    : AppColors.cardSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                border: Border.all(
                  color: isUnlocked
                      ? color
                      : AppColors.textSecondary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: isUnlocked ? color : AppColors.textSecondary.withValues(alpha: 0.5),
                    size: 32,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    title,
                    style: AppTypography.labelSmall.copyWith(
                      color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
                      fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '$milestone',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMD,
        vertical: AppSpacing.paddingSM,
      ),
      child: TextField(
        controller: _searchController,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: '제목, 내용, 태그로 검색...',
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary.withValues(alpha: 0.6),
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.cosmicBlue),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _updateFilter(_currentFilter.copyWith(searchQuery: ''));
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.cardSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingLG,
            vertical: AppSpacing.paddingMD,
          ),
        ),
        onChanged: (value) {
          _updateFilter(_currentFilter.copyWith(searchQuery: value));
        },
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingMD),
      padding: const EdgeInsets.all(AppSpacing.paddingMD),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
        border: Border.all(
          color: AppColors.cosmicBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category filter
          _buildFilterSection(
            '카테고리',
            _buildCategoryFilter(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Difficulty filter
          _buildFilterSection(
            '난이도',
            _buildDifficultyFilter(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Completion status filter
          _buildFilterSection(
            '완료 상태',
            _buildCompletionStatusFilter(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Tag filter
          _buildFilterSection(
            '태그',
            _buildTagFilter(),
          ),
          const SizedBox(height: AppSpacing.md),

          // Clear filters button
          if (_currentFilter.hasActiveFilters)
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: _clearAllFilters,
                icon: const Icon(Icons.clear_all),
                label: const Text('모든 필터 지우기'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.solarOrange,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        content,
      ],
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'label': '전체', 'icon': Icons.apps},
      {'id': 'planet', 'label': '행성', 'icon': Icons.public},
      {'id': 'phenomenon', 'label': '현상', 'icon': Icons.auto_awesome},
      {'id': 'exploration', 'label': '탐사', 'icon': Icons.rocket_launch},
      {'id': 'general', 'label': '일반', 'icon': Icons.star},
    ];

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: categories.map((category) {
        final isSelected = _currentFilter.category == category['id'] ||
            (_currentFilter.category == null && category['id'] == 'all');
        final categoryId = category['id'] as String;

        // Get completion count for this category
        final completedCount = categoryId != 'all'
            ? _getCompletedCountForCategory(categoryId)
            : _completedCardIds.length;
        final totalCount = categoryId != 'all'
            ? _allCards.where((c) => c.category == categoryId).length
            : _allCards.length;

        return FilterChip(
          selected: isSelected,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category['icon'] as IconData,
                size: 16,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(category['label'] as String),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '($completedCount/$totalCount)',
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? AppColors.stardustGold : AppColors.textSecondary,
                ),
              ),
            ],
          ),
          onSelected: (selected) {
            final newCategory = category['id'] as String;
            _updateFilter(
              _currentFilter.copyWith(
                category: newCategory == 'all' ? null : newCategory,
                clearCategory: newCategory == 'all',
              ),
            );
          },
          selectedColor: AppColors.cosmicBlue.withValues(alpha: 0.3),
          checkmarkColor: AppColors.textPrimary,
          backgroundColor: AppColors.cardSurface,
          side: BorderSide(
            color: isSelected
                ? AppColors.cosmicBlue
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDifficultyFilter() {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: LearningCardDifficulty.values.map((difficulty) {
        final isSelected = _currentFilter.difficulty == difficulty;

        return FilterChip(
          selected: isSelected,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(difficulty.emoji),
              const SizedBox(width: AppSpacing.xs),
              Text(difficulty.displayName),
            ],
          ),
          onSelected: (selected) {
            _updateFilter(
              _currentFilter.copyWith(
                difficulty: selected ? difficulty : null,
                clearDifficulty: !selected,
              ),
            );
          },
          selectedColor: AppColors.nebulaPurple.withValues(alpha: 0.3),
          checkmarkColor: AppColors.textPrimary,
          backgroundColor: AppColors.cardSurface,
          side: BorderSide(
            color: isSelected
                ? AppColors.nebulaPurple
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompletionStatusFilter() {
    final options = [
      {'value': null, 'label': '전체', 'icon': Icons.list},
      {'value': true, 'label': '완료', 'icon': Icons.check_circle},
      {'value': false, 'label': '미완료', 'icon': Icons.radio_button_unchecked},
    ];

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: options.map((option) {
        final isSelected = _currentFilter.isCompleted == option['value'];

        return FilterChip(
          selected: isSelected,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                option['icon'] as IconData,
                size: 16,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(option['label'] as String),
            ],
          ),
          onSelected: (selected) {
            _updateFilter(
              _currentFilter.copyWith(
                isCompleted: option['value'] as bool?,
                clearIsCompleted: option['value'] == null,
              ),
            );
          },
          selectedColor: AppColors.stardustGold.withValues(alpha: 0.3),
          checkmarkColor: AppColors.textPrimary,
          backgroundColor: AppColors.cardSurface,
          side: BorderSide(
            color: isSelected
                ? AppColors.stardustGold
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTagFilter() {
    final allTags = _getAllTags();

    if (allTags.isEmpty) {
      return Text(
        '태그가 없습니다',
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: allTags.map((tag) {
        final isSelected = _currentFilter.selectedTags.contains(tag);

        return FilterChip(
          selected: isSelected,
          label: Text('#$tag'),
          onSelected: (selected) {
            final newTags = List<String>.from(_currentFilter.selectedTags);
            if (selected) {
              newTags.add(tag);
            } else {
              newTags.remove(tag);
            }
            _updateFilter(_currentFilter.copyWith(selectedTags: newTags));
          },
          selectedColor: AppColors.solarOrange.withValues(alpha: 0.3),
          checkmarkColor: AppColors.textPrimary,
          backgroundColor: AppColors.cardSurface,
          side: BorderSide(
            color: isSelected
                ? AppColors.solarOrange
                : AppColors.textSecondary.withValues(alpha: 0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActiveFiltersChips() {
    final chips = <Widget>[];

    // Category chip
    if (_currentFilter.category != null && _currentFilter.category != 'all') {
      chips.add(_buildFilterChip(
        '카테고리: ${_getCategoryLabel(_currentFilter.category!)}',
        () => _updateFilter(_currentFilter.copyWith(clearCategory: true)),
      ));
    }

    // Difficulty chip
    if (_currentFilter.difficulty != null) {
      chips.add(_buildFilterChip(
        '난이도: ${_currentFilter.difficulty!.displayName}',
        () => _updateFilter(_currentFilter.copyWith(clearDifficulty: true)),
      ));
    }

    // Completion status chip
    if (_currentFilter.isCompleted != null) {
      chips.add(_buildFilterChip(
        _currentFilter.isCompleted! ? '완료만' : '미완료만',
        () => _updateFilter(_currentFilter.copyWith(clearIsCompleted: true)),
      ));
    }

    // Tag chips
    for (final tag in _currentFilter.selectedTags) {
      chips.add(_buildFilterChip(
        '#$tag',
        () {
          final newTags = List<String>.from(_currentFilter.selectedTags)..remove(tag);
          _updateFilter(_currentFilter.copyWith(selectedTags: newTags));
        },
      ));
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMD,
        vertical: AppSpacing.paddingSM,
      ),
      child: Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        children: chips,
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 16),
      onDeleted: onRemove,
      backgroundColor: AppColors.cosmicBlue.withValues(alpha: 0.3),
      deleteIconColor: AppColors.textPrimary,
      labelStyle: AppTypography.labelSmall.copyWith(
        color: AppColors.textPrimary,
      ),
      side: BorderSide(
        color: AppColors.cosmicBlue.withValues(alpha: 0.5),
      ),
    );
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'planet':
        return '행성';
      case 'phenomenon':
        return '현상';
      case 'exploration':
        return '탐사';
      case 'general':
        return '일반';
      default:
        return category;
    }
  }

  Widget _buildCardStack() {
    if (_filteredCards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _currentFilter.hasActiveFilters
                  ? '필터와 일치하는 카드가 없습니다'
                  : '이 카테고리에는 카드가 없습니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (_currentFilter.hasActiveFilters) ...[
              const SizedBox(height: AppSpacing.md),
              ElevatedButton.icon(
                onPressed: _clearAllFilters,
                icon: const Icon(Icons.clear_all),
                label: const Text('필터 지우기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cosmicBlue,
                  foregroundColor: AppColors.textPrimary,
                ),
              ),
            ],
          ],
        ),
      );
    }

    if (_currentIndex >= _filteredCards.length) {
      return _buildCompletionView();
    }

    return Stack(
      children: [
        // Show next 2 cards in background
        for (int i = _currentIndex + 2; i >= _currentIndex && i < _filteredCards.length; i--)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: (i - _currentIndex) * 10.0,
                left: (i - _currentIndex) * 5.0,
                right: (i - _currentIndex) * 5.0,
              ),
              child: SwipeableCard(
                key: ValueKey(_filteredCards[i].id),
                card: _filteredCards[i],
                isTop: i == _currentIndex,
                onSwipeLeft: () => _onCardSwiped(_filteredCards[i].id, false),
                onSwipeRight: () => _onCardSwiped(_filteredCards[i].id, true),
                onTap: () => _showCardDetails(_filteredCards[i]),
                onShare: () => _shareCard(_filteredCards[i]),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCompletionView() {
    final percentage = (_completedCardIds.length / _allCards.length * 100).round();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.stardustGold, AppColors.solarOrange],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.stardustGold.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 64,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              '모든 카드 완료!',
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '$percentage%의 카드를 학습했습니다',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton.icon(
              onPressed: _resetCards,
              icon: const Icon(Icons.replay),
              label: const Text('다시 학습하기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cosmicBlue,
                foregroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingXL,
                  vertical: AppSpacing.paddingLG,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_currentIndex >= _filteredCards.length) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingXL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Skip button
          _buildActionButton(
            icon: Icons.close,
            color: Colors.red,
            label: '건너뛰기',
            onPressed: () {
              if (_currentIndex < _filteredCards.length) {
                _onCardSwiped(_filteredCards[_currentIndex].id, false);
              }
            },
          ),

          // Info button
          _buildActionButton(
            icon: Icons.info_outline,
            color: AppColors.cosmicBlue,
            label: '자세히',
            onPressed: () {
              if (_currentIndex < _filteredCards.length) {
                _showCardDetails(_filteredCards[_currentIndex]);
              }
            },
          ),

          // Learn button
          _buildActionButton(
            icon: Icons.favorite,
            color: Colors.green,
            label: '학습완료',
            onPressed: () {
              if (_currentIndex < _filteredCards.length) {
                _onCardSwiped(_filteredCards[_currentIndex].id, true);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color, width: 2),
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: 32),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showCardDetails(LearningCard card) {
    final isCompleted = _completedCardIds.contains(card.id);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.cosmicBlue.withValues(alpha: 0.95),
              AppColors.nebulaPurple.withValues(alpha: 0.95),
            ],
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusXL),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title and completion status
              Row(
                children: [
                  Expanded(
                    child: Text(
                      card.title,
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.paddingSM,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check, color: Colors.green, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '완료',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Metadata
              Row(
                children: [
                  Text(
                    card.difficulty.emoji,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    card.difficulty.displayName,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    _getCategoryLabel(card.category),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.stardustGold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),

              // Content
              Text(
                card.content,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Tags
              if (card.tags.isNotEmpty)
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: card.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.paddingMD,
                        vertical: AppSpacing.paddingSM,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.nebulaPurple.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                        border: Border.all(
                          color: AppColors.nebulaPurple.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        '#$tag',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.stardustGold,
                        ),
                      ),
                    );
                  }).toList(),
                ),

              const SizedBox(height: AppSpacing.xl),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.stardustGold,
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.paddingLG,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                  ),
                  child: const Text('닫기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
