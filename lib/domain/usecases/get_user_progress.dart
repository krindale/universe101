import '../entities/user_progress.dart';
import '../repositories/user_progress_repository.dart';

/// Use case for getting user progress
class GetUserProgress {
  final UserProgressRepository repository;

  GetUserProgress(this.repository);

  /// Execute the use case
  /// Returns user progress or creates a new one if it doesn't exist
  Future<UserProgress> call(String userId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    try {
      final progress = await repository.getUserProgress(userId);

      if (progress != null) {
        return progress;
      }

      // Create new progress if it doesn't exist
      final newProgress = UserProgress(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {},
        totalCardsViewed: 0,
        totalTimeSpentMinutes: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
      );

      return await repository.createUserProgress(newProgress);
    } catch (e) {
      throw Exception('Failed to get user progress: $e');
    }
  }
}
