import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/user_progress_repository.dart';
import '../datasources/database_helper.dart';

/// Implementation of UserProgressRepository using SQLite
class UserProgressRepositoryImpl implements UserProgressRepository {
  final DatabaseHelper _databaseHelper;

  UserProgressRepositoryImpl(this._databaseHelper);

  @override
  Future<UserProgress?> getUserProgress(String userId) async {
    try {
      return await _databaseHelper.getUserProgress(userId);
    } catch (e) {
      throw Exception('Failed to get user progress: $e');
    }
  }

  @override
  Future<UserProgress> createUserProgress(UserProgress progress) async {
    try {
      await _databaseHelper.insertUserProgress(progress);
      return progress;
    } catch (e) {
      throw Exception('Failed to create user progress: $e');
    }
  }

  @override
  Future<UserProgress> updateUserProgress(UserProgress progress) async {
    try {
      final result = await _databaseHelper.updateUserProgress(progress);
      if (result == 0) {
        throw Exception('User progress not found');
      }
      return progress;
    } catch (e) {
      throw Exception('Failed to update user progress: $e');
    }
  }

  @override
  Future<UserProgress> markCardAsCompleted(String userId, String cardId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = progress.completeCard(cardId);
      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to mark card as completed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getCompletionStats(String userId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        return _getEmptyStats();
      }

      // Calculate statistics
      final completedCards =
          progress.completedLearningCards.values.where((v) => v == true).length;
      final totalCards = progress.completedLearningCards.length;
      final completionPercentage = totalCards > 0
          ? (completedCards / totalCards) * 100
          : 0.0;

      // Calculate cards completed today, this week, this month
      // TODO: Implement time-based statistics when we add completion timestamps
      // This requires storing completion timestamps in the database
      final cardsCompletedToday = 0;
      final cardsCompletedThisWeek = 0;
      final cardsCompletedThisMonth = 0;

      // Calculate completion by category
      // TODO: Implement category-based statistics when we have card data accessible
      final completionByCategory = <String, int>{};

      return {
        'totalCards': totalCards,
        'completedCards': completedCards,
        'completionPercentage': completionPercentage,
        'totalCardsViewed': progress.totalCardsViewed,
        'totalTimeSpentMinutes': progress.totalTimeSpentMinutes,
        'cardsCompletedToday': cardsCompletedToday,
        'cardsCompletedThisWeek': cardsCompletedThisWeek,
        'cardsCompletedThisMonth': cardsCompletedThisMonth,
        'completionByCategory': completionByCategory,
        'lastActiveAt': progress.lastActiveAt?.toIso8601String(),
      };
    } catch (e) {
      throw Exception('Failed to get completion stats: $e');
    }
  }

  Map<String, dynamic> _getEmptyStats() {
    return {
      'totalCards': 0,
      'completedCards': 0,
      'completionPercentage': 0.0,
      'totalCardsViewed': 0,
      'totalTimeSpentMinutes': 0,
      'cardsCompletedToday': 0,
      'cardsCompletedThisWeek': 0,
      'cardsCompletedThisMonth': 0,
      'completionByCategory': <String, int>{},
      'lastActiveAt': null,
    };
  }

  @override
  Future<UserProgress> addFavoriteCelestialBody(
      String userId, String bodyId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = progress.addFavoriteCelestialBody(bodyId);
      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to add favorite celestial body: $e');
    }
  }

  @override
  Future<UserProgress> removeFavoriteCelestialBody(
      String userId, String bodyId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = progress.removeFavoriteCelestialBody(bodyId);
      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to remove favorite celestial body: $e');
    }
  }

  @override
  Future<UserProgress> addFavoritePhenomenon(
      String userId, String phenomenonId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: [...progress.favoritePhenomena, phenomenonId],
        favoriteExplorations: progress.favoriteExplorations,
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to add favorite phenomenon: $e');
    }
  }

  @override
  Future<UserProgress> removeFavoritePhenomenon(
      String userId, String phenomenonId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: progress.favoritePhenomena
            .where((id) => id != phenomenonId)
            .toList(),
        favoriteExplorations: progress.favoriteExplorations,
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to remove favorite phenomenon: $e');
    }
  }

  @override
  Future<UserProgress> addFavoriteExploration(
      String userId, String explorationId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: progress.favoritePhenomena,
        favoriteExplorations: [...progress.favoriteExplorations, explorationId],
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to add favorite exploration: $e');
    }
  }

  @override
  Future<UserProgress> removeFavoriteExploration(
      String userId, String explorationId) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: progress.favoritePhenomena,
        favoriteExplorations: progress.favoriteExplorations
            .where((id) => id != explorationId)
            .toList(),
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to remove favorite exploration: $e');
    }
  }

  @override
  Future<UserProgress> updateTimeSpent(String userId, int minutesToAdd) async {
    try {
      final progress = await getUserProgress(userId);
      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: progress.favoritePhenomena,
        favoriteExplorations: progress.favoriteExplorations,
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes + minutesToAdd,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      await updateUserProgress(updatedProgress);
      return updatedProgress;
    } catch (e) {
      throw Exception('Failed to update time spent: $e');
    }
  }

  @override
  Future<bool> exists(String userId) async {
    try {
      final progress = await getUserProgress(userId);
      return progress != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteUserProgress(String userId) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(
        'user_progress',
        where: 'userId = ?',
        whereArgs: [userId],
      );
    } catch (e) {
      throw Exception('Failed to delete user progress: $e');
    }
  }
}
