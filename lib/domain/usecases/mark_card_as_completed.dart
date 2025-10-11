import '../entities/user_progress.dart';
import '../repositories/user_progress_repository.dart';

/// Use case for marking a learning card as completed
class MarkCardAsCompleted {
  final UserProgressRepository repository;

  MarkCardAsCompleted(this.repository);

  /// Execute the use case
  /// Returns the updated user progress with the card marked as completed
  Future<UserProgress> call(String userId, String cardId) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    if (cardId.isEmpty) {
      throw ArgumentError('Card ID cannot be empty');
    }

    try {
      // Get current progress
      final progress = await repository.getUserProgress(userId);

      if (progress == null) {
        throw Exception('User progress not found for userId: $userId');
      }

      // Check if card is already completed
      if (progress.completedLearningCards[cardId] == true) {
        return progress; // Already completed, return as is
      }

      // Mark card as completed using repository method
      return await repository.markCardAsCompleted(userId, cardId);
    } catch (e) {
      throw Exception('Failed to mark card as completed: $e');
    }
  }

  /// Mark multiple cards as completed at once
  Future<UserProgress> callBatch(String userId, List<String> cardIds) async {
    if (userId.isEmpty) {
      throw ArgumentError('User ID cannot be empty');
    }

    if (cardIds.isEmpty) {
      throw ArgumentError('Card IDs list cannot be empty');
    }

    try {
      UserProgress progress = await repository.getUserProgress(userId) ??
          (throw Exception('User progress not found for userId: $userId'));

      // Mark each card as completed
      for (final cardId in cardIds) {
        if (progress.completedLearningCards[cardId] != true) {
          progress = await repository.markCardAsCompleted(userId, cardId);
        }
      }

      return progress;
    } catch (e) {
      throw Exception('Failed to mark cards as completed: $e');
    }
  }
}
