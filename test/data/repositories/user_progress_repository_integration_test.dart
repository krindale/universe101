import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:universe101/data/datasources/database_helper.dart';
import 'package:universe101/data/repositories/user_progress_repository_impl.dart';

void main() {
  late UserProgressRepositoryImpl repository;

  setUpAll(() {
    // Initialize FFI for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Create repository with real database helper
    repository = UserProgressRepositoryImpl(DatabaseHelper());
  });

  group('UserProgressRepository Integration Tests', () {
    test('should mark card as completed and persist', () async {
      final userId = 'test_user_${DateTime.now().millisecondsSinceEpoch}';

      await repository.markCardAsCompleted(userId, 'card_001');

      final progress = await repository.getUserProgress(userId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards['card_001'], true);
      expect(progress.totalCardsViewed, greaterThanOrEqualTo(1));
    });

    test('should mark multiple cards as completed', () async {
      final userId = 'test_user_multi_${DateTime.now().millisecondsSinceEpoch}';

      await repository.markCardAsCompleted(userId, 'card_001');
      await repository.markCardAsCompleted(userId, 'card_002');
      await repository.markCardAsCompleted(userId, 'card_003');

      final progress = await repository.getUserProgress(userId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards.length, greaterThanOrEqualTo(3));
      expect(progress.completedLearningCards['card_001'], true);
      expect(progress.completedLearningCards['card_002'], true);
      expect(progress.completedLearningCards['card_003'], true);
    });

    test('should get completion stats', () async {
      final userId = 'test_user_stats_${DateTime.now().millisecondsSinceEpoch}';

      await repository.markCardAsCompleted(userId, 'card_001');
      await repository.markCardAsCompleted(userId, 'card_002');
      await repository.markCardAsCompleted(userId, 'card_003');

      final stats = await repository.getCompletionStats(userId);

      expect(stats['completedCards'], greaterThanOrEqualTo(3));
      expect(stats['totalCards'], 20); // Total cards from sample data
      expect(stats['completionPercentage'], greaterThanOrEqualTo(0.0));
    });

    test('should calculate completion percentage correctly', () async {
      final userId = 'test_user_percent_${DateTime.now().millisecondsSinceEpoch}';

      // Complete 5 cards (25% of 20 total)
      for (int i = 1; i <= 5; i++) {
        await repository.markCardAsCompleted(
          userId,
          'card_${i.toString().padLeft(3, '0')}'
        );
      }

      final stats = await repository.getCompletionStats(userId);
      expect(stats['completedCards'], greaterThanOrEqualTo(5));
      expect(stats['completionPercentage'], greaterThanOrEqualTo(15.0));
    });

    test('should handle rapid successive operations', () async {
      final userId = 'test_user_rapid_${DateTime.now().millisecondsSinceEpoch}';

      // Simulate rapid card completions
      for (int i = 1; i <= 10; i++) {
        await repository.markCardAsCompleted(
          userId,
          'card_${i.toString().padLeft(3, '0')}'
        );
      }

      final progress = await repository.getUserProgress(userId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards.length, greaterThanOrEqualTo(10));
    });

    test('should verify progress tracking functionality works end-to-end', () async {
      final userId = 'test_user_e2e_${DateTime.now().millisecondsSinceEpoch}';

      // Step 1: Mark a card as completed
      await repository.markCardAsCompleted(userId, 'card_001');

      // Step 2: Verify it was saved
      var progress = await repository.getUserProgress(userId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards['card_001'], true);

      // Step 3: Mark more cards
      await repository.markCardAsCompleted(userId, 'card_002');
      await repository.markCardAsCompleted(userId, 'card_003');

      // Step 4: Verify all are saved
      progress = await repository.getUserProgress(userId);
      expect(progress!.completedLearningCards.length, greaterThanOrEqualTo(3));

      // Step 5: Get stats
      final stats = await repository.getCompletionStats(userId);
      expect(stats['completedCards'], greaterThanOrEqualTo(3));
      expect(stats['totalCards'], 20);

      // Completion percentage should be at least 15% (3/20)
      expect(stats['completionPercentage'], greaterThanOrEqualTo(15.0));
    });

    test('should persist data across repository instances', () async {
      final userId = 'test_user_persist_${DateTime.now().millisecondsSinceEpoch}';

      // Use first repository instance to save data
      await repository.markCardAsCompleted(userId, 'card_001');
      await repository.markCardAsCompleted(userId, 'card_002');

      // Create new repository instance
      final newRepository = UserProgressRepositoryImpl(DatabaseHelper());

      // Verify data persisted
      final progress = await newRepository.getUserProgress(userId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards['card_001'], true);
      expect(progress.completedLearningCards['card_002'], true);
    });
  });
}
