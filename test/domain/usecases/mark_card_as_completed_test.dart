import 'package:flutter_test/flutter_test.dart';
import 'package:universe101/domain/entities/user_progress.dart';
import 'package:universe101/domain/repositories/user_progress_repository.dart';
import 'package:universe101/domain/usecases/mark_card_as_completed.dart';

class MockUserProgressRepository implements UserProgressRepository {
  UserProgress? mockProgress;
  bool shouldThrowError = false;

  @override
  Future<UserProgress?> getUserProgress(String userId) async {
    if (shouldThrowError) {
      throw Exception('Database error');
    }
    return mockProgress;
  }

  @override
  Future<UserProgress> markCardAsCompleted(String userId, String cardId) async {
    if (mockProgress == null) {
      throw Exception('User progress not found');
    }
    final updatedProgress = mockProgress!.completeCard(cardId);
    mockProgress = updatedProgress;
    return updatedProgress;
  }

  @override
  Future<UserProgress> createUserProgress(UserProgress progress) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> updateUserProgress(UserProgress progress) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getCompletionStats(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> addFavoriteCelestialBody(
      String userId, String bodyId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> removeFavoriteCelestialBody(
      String userId, String bodyId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> addFavoritePhenomenon(
      String userId, String phenomenonId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> removeFavoritePhenomenon(
      String userId, String phenomenonId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> addFavoriteExploration(
      String userId, String explorationId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> removeFavoriteExploration(
      String userId, String explorationId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserProgress> updateTimeSpent(String userId, int minutesToAdd) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserProgress(String userId) async {
    throw UnimplementedError();
  }
}

void main() {
  late MarkCardAsCompleted useCase;
  late MockUserProgressRepository mockRepository;

  setUp(() {
    mockRepository = MockUserProgressRepository();
    useCase = MarkCardAsCompleted(mockRepository);
  });

  group('MarkCardAsCompleted', () {
    const testUserId = 'test_user_123';
    const testCardId = 'card_001';

    test('should mark card as completed successfully', () async {
      // Arrange
      final initialProgress = UserProgress(
        id: '1',
        userId: testUserId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {},
        totalCardsViewed: 0,
        totalTimeSpentMinutes: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      mockRepository.mockProgress = initialProgress;

      // Act
      final result = await useCase(testUserId, testCardId);

      // Assert
      expect(result.completedLearningCards[testCardId], isTrue);
      expect(result.totalCardsViewed, equals(1));
      expect(result.updatedAt, isNotNull);
    });

    test('should return same progress if card already completed', () async {
      // Arrange
      final alreadyCompletedProgress = UserProgress(
        id: '1',
        userId: testUserId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {testCardId: true},
        totalCardsViewed: 5,
        totalTimeSpentMinutes: 20,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      mockRepository.mockProgress = alreadyCompletedProgress;

      // Act
      final result = await useCase(testUserId, testCardId);

      // Assert
      expect(result.completedLearningCards[testCardId], isTrue);
      expect(result.totalCardsViewed, equals(5)); // Should not increment
    });

    test('should throw ArgumentError when userId is empty', () async {
      // Act & Assert
      expect(
        () => useCase('', testCardId),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when cardId is empty', () async {
      // Act & Assert
      expect(
        () => useCase(testUserId, ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw Exception when user progress not found', () async {
      // Arrange
      mockRepository.mockProgress = null;

      // Act & Assert
      expect(
        () => useCase(testUserId, testCardId),
        throwsA(isA<Exception>()),
      );
    });

    test('should mark multiple cards as completed using callBatch', () async {
      // Arrange
      final initialProgress = UserProgress(
        id: '1',
        userId: testUserId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {},
        totalCardsViewed: 0,
        totalTimeSpentMinutes: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      mockRepository.mockProgress = initialProgress;

      final cardIds = ['card_001', 'card_002', 'card_003'];

      // Act
      final result = await useCase.callBatch(testUserId, cardIds);

      // Assert
      expect(result.completedLearningCards['card_001'], isTrue);
      expect(result.completedLearningCards['card_002'], isTrue);
      expect(result.completedLearningCards['card_003'], isTrue);
      expect(result.totalCardsViewed, equals(3));
    });

    test('should throw ArgumentError when cardIds list is empty in callBatch',
        () async {
      // Act & Assert
      expect(
        () => useCase.callBatch(testUserId, []),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should update lastActiveAt and updatedAt when marking complete',
        () async {
      // Arrange
      final oldDate = DateTime(2024, 1, 1);
      final initialProgress = UserProgress(
        id: '1',
        userId: testUserId,
        favoriteCelestialBodies: [],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {},
        totalCardsViewed: 0,
        totalTimeSpentMinutes: 0,
        createdAt: oldDate,
        updatedAt: oldDate,
        lastActiveAt: oldDate,
      );
      mockRepository.mockProgress = initialProgress;

      // Act
      final result = await useCase(testUserId, testCardId);

      // Assert
      expect(result.lastActiveAt!.isAfter(oldDate), isTrue);
      expect(result.updatedAt!.isAfter(oldDate), isTrue);
    });
  });
}
