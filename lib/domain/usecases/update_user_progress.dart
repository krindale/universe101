import '../entities/user_progress.dart';
import '../repositories/user_progress_repository.dart';

/// Use case for updating user progress
class UpdateUserProgress {
  final UserProgressRepository repository;

  UpdateUserProgress(this.repository);

  /// Execute the use case
  /// Returns the updated user progress
  Future<UserProgress> call(UserProgress progress) async {
    if (progress.userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    try {
      // Verify user progress exists
      final exists = await repository.exists(progress.userId);
      if (!exists) {
        throw Exception('User progress not found for userId: ${progress.userId}');
      }

      // Update with current timestamp
      final updatedProgress = UserProgress(
        id: progress.id,
        userId: progress.userId,
        favoriteCelestialBodies: progress.favoriteCelestialBodies,
        favoritePhenomena: progress.favoritePhenomena,
        favoriteExplorations: progress.favoriteExplorations,
        completedLearningCards: progress.completedLearningCards,
        totalCardsViewed: progress.totalCardsViewed,
        totalTimeSpentMinutes: progress.totalTimeSpentMinutes,
        lastActiveAt: DateTime.now(),
        createdAt: progress.createdAt,
        updatedAt: DateTime.now(),
      );

      return await repository.updateUserProgress(updatedProgress);
    } catch (e) {
      throw Exception('Failed to update user progress: $e');
    }
  }
}
