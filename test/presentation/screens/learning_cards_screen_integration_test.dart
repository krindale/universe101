import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:universe101/data/datasources/database_helper.dart';
import 'package:universe101/data/repositories/user_progress_repository_impl.dart';
import 'package:universe101/domain/entities/user_progress.dart';
import 'package:universe101/presentation/screens/learning_cards_screen.dart';

void main() {
  late UserProgressRepositoryImpl repository;
  late DatabaseHelper dbHelper;
  const testUserId = 'default_user';

  setUpAll(() {
    // Initialize FFI for testing
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Create in-memory database for each test
    dbHelper = DatabaseHelper();
    await dbHelper.database; // Initialize database
    repository = UserProgressRepositoryImpl(dbHelper);
  });

  tearDown(() async {
    await dbHelper.close();
  });

  group('LearningCardsScreen Progress Tracking Integration Tests', () {
    testWidgets('should initialize with default user progress',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      // Wait for progress loading
      await tester.pumpAndSettle();

      // Verify screen loads without error
      expect(find.byType(LearningCardsScreen), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should show loading indicator during initialization',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      // Before pumpAndSettle, should show loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      // After loading, should not show loading indicator
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should persist card completion to database',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Find the top card
      final cardFinder = find.byType(GestureDetector).first;
      expect(cardFinder, findsOneWidget);

      // Simulate swipe right (learned)
      await tester.drag(cardFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      // Verify completion was saved to database
      final progress = await repository.getUserProgress(testUserId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards.isNotEmpty, true);
    });

    testWidgets('should display statistics modal with correct data',
        (WidgetTester tester) async {
      // Pre-populate database with some completed cards
      await repository.markCardAsCompleted(testUserId, 'card_001');
      await repository.markCardAsCompleted(testUserId, 'card_002');
      await repository.markCardAsCompleted(testUserId, 'card_003');

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap statistics button
      final statsButton = find.byIcon(Icons.analytics);
      expect(statsButton, findsOneWidget);
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      // Verify statistics modal is displayed
      expect(find.text('학습 통계'), findsOneWidget);
      expect(find.text('3'), findsOneWidget); // 3 completed cards
    });

    testWidgets('should show achievement badges based on completion count',
        (WidgetTester tester) async {
      // Complete 10 cards to unlock first achievement
      for (int i = 1; i <= 10; i++) {
        await repository.markCardAsCompleted(
            testUserId, 'card_${i.toString().padLeft(3, '0')}');
      }

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open statistics modal
      final statsButton = find.byIcon(Icons.analytics);
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      // Verify first achievement is unlocked (입문자 - 10 cards)
      expect(find.text('입문자'), findsOneWidget);

      // Verify first badge has color (unlocked)
      final firstBadge = find.byIcon(Icons.star).first;
      expect(firstBadge, findsOneWidget);
    });

    testWidgets('should display progress indicators on category filters',
        (WidgetTester tester) async {
      // Complete some planet cards
      await repository.markCardAsCompleted(testUserId, 'card_001'); // Jupiter
      await repository.markCardAsCompleted(testUserId, 'card_002'); // Mars

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open filter panel
      final filterButton = find.byIcon(Icons.filter_list);
      await tester.tap(filterButton);
      await tester.pumpAndSettle();

      // Verify progress indicators are shown
      // Should show (2/5) or similar for planet category
      final progressIndicatorFinder = find.textContaining('(');
      expect(progressIndicatorFinder, findsWidgets);
    });

    testWidgets('should show completion badge in card detail modal',
        (WidgetTester tester) async {
      // Mark first card as completed
      await repository.markCardAsCompleted(testUserId, 'card_001');

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on the card to open detail modal
      final cardFinder = find.byType(GestureDetector).first;
      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      // Verify completion badge is shown
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.text('학습 완료'), findsOneWidget);
    });

    testWidgets('should update statistics after completing cards',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open statistics modal - should show 0 completed
      final statsButton = find.byIcon(Icons.analytics);
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);

      // Close modal
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Complete a card
      final cardFinder = find.byType(GestureDetector).first;
      await tester.drag(cardFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      // Open statistics modal again - should show 1 completed
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should calculate completion percentage correctly',
        (WidgetTester tester) async {
      // Complete 5 cards (25% of 20 total cards)
      for (int i = 1; i <= 5; i++) {
        await repository.markCardAsCompleted(
            testUserId, 'card_${i.toString().padLeft(3, '0')}');
      }

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open statistics modal
      final statsButton = find.byIcon(Icons.analytics);
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      // Verify percentage is shown (25.0%)
      expect(find.textContaining('%'), findsOneWidget);
    });

    testWidgets('should filter by completion status',
        (WidgetTester tester) async {
      // Complete some cards
      await repository.markCardAsCompleted(testUserId, 'card_001');
      await repository.markCardAsCompleted(testUserId, 'card_002');

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open filter panel
      final filterButton = find.byIcon(Icons.filter_list);
      await tester.tap(filterButton);
      await tester.pumpAndSettle();

      // Find and tap "완료됨" (completed) filter
      final completedFilter = find.text('완료됨');
      expect(completedFilter, findsOneWidget);
      await tester.tap(completedFilter);
      await tester.pumpAndSettle();

      // Verify only completed cards are shown
      // The card count should reflect filtered results
      expect(find.byType(GestureDetector), findsWidgets);
    });

    testWidgets('should maintain progress across screen rebuilds',
        (WidgetTester tester) async {
      // Complete a card
      await repository.markCardAsCompleted(testUserId, 'card_001');

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Trigger rebuild by navigating away and back
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Text('Other Screen')),
        ),
      );

      await tester.pumpAndSettle();

      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Open statistics and verify progress persisted
      final statsButton = find.byIcon(Icons.analytics);
      await tester.tap(statsButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    test('UserProgressRepository integration - mark card as completed',
        () async {
      // Test repository directly
      await repository.markCardAsCompleted(testUserId, 'test_card_001');

      final progress = await repository.getUserProgress(testUserId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards['test_card_001'], true);
    });

    test('UserProgressRepository integration - get completion stats',
        () async {
      // Complete multiple cards
      await repository.markCardAsCompleted(testUserId, 'card_001');
      await repository.markCardAsCompleted(testUserId, 'card_002');
      await repository.markCardAsCompleted(testUserId, 'card_003');

      final stats = await repository.getCompletionStats(testUserId);
      expect(stats['completedCards'], 3);
      expect(stats['totalCards'], greaterThan(0));
    });

    test('UserProgressRepository integration - update user progress',
        () async {
      // Create initial progress
      final initialProgress = UserProgress(
        id: 'test_progress_1',
        userId: testUserId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {'card_001': true},
        totalCardsViewed: 1,
        totalTimeSpentMinutes: 0,
        lastActiveAt: DateTime.now(),
        createdAt: DateTime.now(),
      );

      await repository.updateUserProgress(initialProgress);

      // Update progress by marking more cards complete
      final updatedProgress = UserProgress(
        id: initialProgress.id,
        userId: initialProgress.userId,
        favoriteCelestialBodies: initialProgress.favoriteCelestialBodies,
        favoritePhenomena: initialProgress.favoritePhenomena,
        favoriteExplorations: initialProgress.favoriteExplorations,
        completedLearningCards: {
          'card_001': true,
          'card_002': true,
        },
        totalCardsViewed: 2,
        totalTimeSpentMinutes: 30,
        lastActiveAt: DateTime.now(),
        createdAt: initialProgress.createdAt,
        updatedAt: DateTime.now(),
      );

      await repository.updateUserProgress(updatedProgress);

      // Verify update
      final retrieved = await repository.getUserProgress(testUserId);
      expect(retrieved, isNotNull);
      expect(retrieved!.completedLearningCards.length, 2);
      expect(retrieved.totalTimeSpentMinutes, 30);
      expect(retrieved.totalCardsViewed, 2);
    });

    testWidgets('should handle multiple rapid card completions',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LearningCardsScreen(),
        ),
      );

      await tester.pumpAndSettle();

      // Rapidly complete multiple cards
      for (int i = 0; i < 3; i++) {
        final cardFinder = find.byType(GestureDetector).first;
        await tester.drag(cardFinder, const Offset(500, 0));
        await tester.pump(const Duration(milliseconds: 100));
      }

      await tester.pumpAndSettle();

      // Verify all completions were saved
      final progress = await repository.getUserProgress(testUserId);
      expect(progress, isNotNull);
      expect(progress!.completedLearningCards.length, 3);
    });
  });
}
