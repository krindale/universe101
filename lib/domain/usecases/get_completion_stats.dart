import '../repositories/user_progress_repository.dart';

/// Use case for getting completion statistics
class GetCompletionStats {
  final UserProgressRepository repository;

  GetCompletionStats(this.repository);

  /// Execute the use case
  /// Returns a map with various completion statistics
  Future<CompletionStats> call(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    try {
      final stats = await repository.getCompletionStats(userId);
      return CompletionStats.fromMap(stats);
    } catch (e) {
      throw Exception('Failed to get completion stats: $e');
    }
  }
}

/// Model class for completion statistics
class CompletionStats {
  final int totalCards;
  final int completedCards;
  final double completionPercentage;
  final int totalCardsViewed;
  final int totalTimeSpentMinutes;
  final int cardsCompletedToday;
  final int cardsCompletedThisWeek;
  final int cardsCompletedThisMonth;
  final Map<String, int> completionByCategory;
  final DateTime? lastActiveAt;

  CompletionStats({
    required this.totalCards,
    required this.completedCards,
    required this.completionPercentage,
    required this.totalCardsViewed,
    required this.totalTimeSpentMinutes,
    required this.cardsCompletedToday,
    required this.cardsCompletedThisWeek,
    required this.cardsCompletedThisMonth,
    required this.completionByCategory,
    this.lastActiveAt,
  });

  factory CompletionStats.fromMap(Map<String, dynamic> map) {
    return CompletionStats(
      totalCards: map['totalCards'] as int? ?? 0,
      completedCards: map['completedCards'] as int? ?? 0,
      completionPercentage: map['completionPercentage'] as double? ?? 0.0,
      totalCardsViewed: map['totalCardsViewed'] as int? ?? 0,
      totalTimeSpentMinutes: map['totalTimeSpentMinutes'] as int? ?? 0,
      cardsCompletedToday: map['cardsCompletedToday'] as int? ?? 0,
      cardsCompletedThisWeek: map['cardsCompletedThisWeek'] as int? ?? 0,
      cardsCompletedThisMonth: map['cardsCompletedThisMonth'] as int? ?? 0,
      completionByCategory: Map<String, int>.from(
          map['completionByCategory'] as Map? ?? {}),
      lastActiveAt: map['lastActiveAt'] != null
          ? DateTime.parse(map['lastActiveAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCards': totalCards,
      'completedCards': completedCards,
      'completionPercentage': completionPercentage,
      'totalCardsViewed': totalCardsViewed,
      'totalTimeSpentMinutes': totalTimeSpentMinutes,
      'cardsCompletedToday': cardsCompletedToday,
      'cardsCompletedThisWeek': cardsCompletedThisWeek,
      'cardsCompletedThisMonth': cardsCompletedThisMonth,
      'completionByCategory': completionByCategory,
      'lastActiveAt': lastActiveAt?.toIso8601String(),
    };
  }

  /// Check if user has completed any milestone
  bool hasAchievedMilestone(int milestone) {
    return completedCards >= milestone;
  }

  /// Get next milestone to achieve
  int? getNextMilestone() {
    const milestones = [10, 25, 50, 100, 250, 500, 1000];
    for (final milestone in milestones) {
      if (completedCards < milestone) {
        return milestone;
      }
    }
    return null;
  }

  /// Get progress towards next milestone (0.0 to 1.0)
  double getProgressToNextMilestone() {
    final nextMilestone = getNextMilestone();
    if (nextMilestone == null) return 1.0;

    const milestones = [0, 10, 25, 50, 100, 250, 500, 1000];
    final previousMilestone = milestones.lastWhere(
      (m) => m < nextMilestone,
      orElse: () => 0,
    );

    final range = nextMilestone - previousMilestone;
    final progress = completedCards - previousMilestone;

    return progress / range;
  }

  /// Get average time spent per card (in minutes)
  double get averageTimePerCard {
    if (totalCardsViewed == 0) return 0.0;
    return totalTimeSpentMinutes / totalCardsViewed;
  }

  /// Get average cards completed per day (rough estimate based on total time)
  double get averageCardsPerDay {
    if (lastActiveAt == null || completedCards == 0) return 0.0;
    final daysSinceCreation = DateTime.now().difference(lastActiveAt!).inDays;
    if (daysSinceCreation == 0) return completedCards.toDouble();
    return completedCards / daysSinceCreation;
  }
}
