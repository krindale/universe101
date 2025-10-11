import '../entities/user_progress.dart';

/// Repository interface for managing user progress data
abstract class UserProgressRepository {
  /// Get user progress by userId
  /// Returns null if no progress found for the user
  Future<UserProgress?> getUserProgress(String userId);

  /// Create new user progress
  /// Returns the created user progress
  Future<UserProgress> createUserProgress(UserProgress progress);

  /// Update existing user progress
  /// Returns the updated user progress
  Future<UserProgress> updateUserProgress(UserProgress progress);

  /// Mark a learning card as completed
  /// Returns the updated user progress
  Future<UserProgress> markCardAsCompleted(String userId, String cardId);

  /// Get completion statistics for a user
  /// Returns a map with various statistics
  Future<Map<String, dynamic>> getCompletionStats(String userId);

  /// Add a favorite celestial body
  Future<UserProgress> addFavoriteCelestialBody(
      String userId, String bodyId);

  /// Remove a favorite celestial body
  Future<UserProgress> removeFavoriteCelestialBody(
      String userId, String bodyId);

  /// Add a favorite phenomenon
  Future<UserProgress> addFavoritePhenomenon(String userId, String phenomenonId);

  /// Remove a favorite phenomenon
  Future<UserProgress> removeFavoritePhenomenon(
      String userId, String phenomenonId);

  /// Add a favorite exploration
  Future<UserProgress> addFavoriteExploration(
      String userId, String explorationId);

  /// Remove a favorite exploration
  Future<UserProgress> removeFavoriteExploration(
      String userId, String explorationId);

  /// Update time spent learning
  Future<UserProgress> updateTimeSpent(String userId, int minutesToAdd);

  /// Mark a card for review later
  Future<UserProgress> markForReviewLater(String userId, String cardId);

  /// Unmark a card from review later
  Future<UserProgress> unmarkForReviewLater(String userId, String cardId);

  /// Hide a card (archive it)
  Future<UserProgress> hideCard(String userId, String cardId);

  /// Unhide a card (restore from archive)
  Future<UserProgress> unhideCard(String userId, String cardId);

  /// Reset progress for a specific card
  Future<UserProgress> resetCardProgress(String userId, String cardId);

  /// Export user learning data as JSON
  Future<Map<String, dynamic>> exportLearningData(String userId);

  /// Check if user progress exists
  Future<bool> exists(String userId);

  /// Delete user progress
  Future<void> deleteUserProgress(String userId);
}
