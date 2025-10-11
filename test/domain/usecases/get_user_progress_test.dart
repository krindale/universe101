import 'package:flutter_test/flutter_test.dart';
import 'package:universe101/domain/entities/user_progress.dart';
import 'package:universe101/domain/repositories/user_progress_repository.dart';
import 'package:universe101/domain/usecases/get_user_progress.dart';

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
  Future<UserProgress> createUserProgress(UserProgress progress) async {
    mockProgress = progress;
    return progress;
  }

  @override
  Future<UserProgress> updateUserProgress(UserProgress progress) async {
    mockProgress = progress;
    return progress;
  }

  @override
  Future<UserProgress> markCardAsCompleted(String userId, String cardId) async {
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
  late GetUserProgress useCase;
  late MockUserProgressRepository mockRepository;

  setUp(() {
    mockRepository = MockUserProgressRepository();
    useCase = GetUserProgress(mockRepository);
  });

  group('GetUserProgress', () {
    const testUserId = 'test_user_123';

    test('should return existing user progress when it exists', () async {
      // Arrange
      final existingProgress = UserProgress(
        id: '1',
        userId: testUserId,
        favoriteCelestialBodies: ['mars', 'jupiter'],
        favoritePhenomena: [],
        favoriteExplorations: [],
        completedLearningCards: {'card1': true, 'card2': true},
        totalCardsViewed: 10,
        totalTimeSpentMinutes: 45,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
      );
      mockRepository.mockProgress = existingProgress;

      // Act
      final result = await useCase(testUserId);

      // Assert
      expect(result, equals(existingProgress));
      expect(result.userId, equals(testUserId));
      expect(result.favoriteCelestialBodies.length, equals(2));
      expect(result.completedLearningCards.length, equals(2));
    });

    test('should create new user progress when it does not exist', () async {
      // Arrange
      mockRepository.mockProgress = null;

      // Act
      final result = await useCase(testUserId);

      // Assert
      expect(result.userId, equals(testUserId));
      expect(result.favoriteCelestialBodies, isEmpty);
      expect(result.favoritePhenomena, isEmpty);
      expect(result.favoriteExplorations, isEmpty);
      expect(result.completedLearningCards, isEmpty);
      expect(result.totalCardsViewed, equals(0));
      expect(result.totalTimeSpentMinutes, equals(0));
      expect(result.createdAt, isNotNull);
      expect(result.updatedAt, isNotNull);
      expect(result.lastActiveAt, isNotNull);
    });

    test('should throw ArgumentError when userId is empty', () async {
      // Act & Assert
      expect(
        () => useCase(''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw Exception when repository fails', () async {
      // Arrange
      mockRepository.shouldThrowError = true;

      // Act & Assert
      expect(
        () => useCase(testUserId),
        throwsA(isA<Exception>()),
      );
    });

    test('should create progress with correct initial values', () async {
      // Arrange
      mockRepository.mockProgress = null;

      // Act
      final result = await useCase(testUserId);

      // Assert
      expect(result.userId, equals(testUserId));
      expect(result.totalCardsViewed, equals(0));
      expect(result.totalTimeSpentMinutes, equals(0));
      expect(result.completedLearningCards, isEmpty);
      expect(result.completionPercentage, equals(0.0));
    });
  });
}
