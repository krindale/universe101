import 'package:flutter_test/flutter_test.dart';
import 'package:universe101/domain/entities/learning_card.dart';
import 'package:universe101/domain/entities/learning_card_filter.dart';

void main() {
  group('LearningCardFilter', () {
    late List<LearningCard> sampleCards;
    late Set<String> completedCardIds;

    setUp(() {
      sampleCards = [
        LearningCard(
          id: 'card_1',
          title: '목성은 큰 행성',
          content: '목성은 태양계에서 가장 큰 행성입니다',
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
          tags: ['목성', '태양계'],
          createdAt: DateTime(2024, 1, 1),
        ),
        LearningCard(
          id: 'card_2',
          title: '화성의 색깔',
          content: '화성은 붉은 색입니다',
          category: 'planet',
          difficulty: LearningCardDifficulty.medium,
          tags: ['화성', '색깔'],
          createdAt: DateTime(2024, 1, 2),
        ),
        LearningCard(
          id: 'card_3',
          title: '일식 현상',
          content: '일식은 달이 태양을 가립니다',
          category: 'phenomenon',
          difficulty: LearningCardDifficulty.easy,
          tags: ['일식', '달'],
          createdAt: DateTime(2024, 1, 3),
        ),
        LearningCard(
          id: 'card_4',
          title: '블랙홀',
          content: '블랙홀은 빛도 탈출할 수 없습니다',
          category: 'phenomenon',
          difficulty: LearningCardDifficulty.hard,
          tags: ['블랙홀', '중력'],
          createdAt: DateTime(2024, 1, 4),
        ),
        LearningCard(
          id: 'card_5',
          title: '아폴로 11호',
          content: '인류 최초의 달 착륙',
          category: 'exploration',
          difficulty: LearningCardDifficulty.medium,
          tags: ['아폴로', '달'],
          createdAt: DateTime(2024, 1, 5),
        ),
      ];

      completedCardIds = {'card_1', 'card_3'};
    });

    test('empty filter returns all cards', () {
      final filter = LearningCardFilter.empty();
      final result = filter.apply(sampleCards, completedCardIds);

      expect(result.length, equals(5));
      expect(filter.hasActiveFilters, isFalse);
      expect(filter.activeFilterCount, equals(0));
    });

    group('Category filter', () {
      test('filters by planet category', () {
        final filter = const LearningCardFilter(category: 'planet');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.every((card) => card.category == 'planet'), isTrue);
      });

      test('filters by phenomenon category', () {
        final filter = const LearningCardFilter(category: 'phenomenon');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.every((card) => card.category == 'phenomenon'), isTrue);
      });

      test('all category shows all cards', () {
        final filter = const LearningCardFilter(category: 'all');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(5));
      });
    });

    group('Difficulty filter', () {
      test('filters by easy difficulty', () {
        final filter = const LearningCardFilter(
          difficulty: LearningCardDifficulty.easy,
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(
          result.every((card) => card.difficulty == LearningCardDifficulty.easy),
          isTrue,
        );
      });

      test('filters by hard difficulty', () {
        final filter = const LearningCardFilter(
          difficulty: LearningCardDifficulty.hard,
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_4'));
      });

      test('filters by medium difficulty', () {
        final filter = const LearningCardFilter(
          difficulty: LearningCardDifficulty.medium,
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
      });
    });

    group('Completion status filter', () {
      test('filters completed cards', () {
        final filter = const LearningCardFilter(isCompleted: true);
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.map((c) => c.id).toList(), containsAll(['card_1', 'card_3']));
      });

      test('filters uncompleted cards', () {
        final filter = const LearningCardFilter(isCompleted: false);
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(3));
        expect(result.map((c) => c.id).toList(), containsAll(['card_2', 'card_4', 'card_5']));
      });

      test('null completion status returns all cards', () {
        final filter = const LearningCardFilter(isCompleted: null);
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(5));
      });
    });

    group('Tag filter', () {
      test('filters by single tag', () {
        final filter = const LearningCardFilter(selectedTags: ['달']);
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.map((c) => c.id).toList(), containsAll(['card_3', 'card_5']));
      });

      test('filters by multiple tags (OR logic)', () {
        final filter = const LearningCardFilter(
          selectedTags: ['목성', '화성'],
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.map((c) => c.id).toList(), containsAll(['card_1', 'card_2']));
      });

      test('empty tag list returns all cards', () {
        final filter = const LearningCardFilter(selectedTags: []);
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(5));
      });
    });

    group('Search query filter', () {
      test('filters by title search', () {
        final filter = const LearningCardFilter(searchQuery: '목성');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_1'));
      });

      test('filters by content search', () {
        final filter = const LearningCardFilter(searchQuery: '붉은');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_2'));
      });

      test('filters by tag search', () {
        final filter = const LearningCardFilter(searchQuery: '중력');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_4'));
      });

      test('search is case insensitive', () {
        final filter = const LearningCardFilter(searchQuery: '목성');
        final resultLower = filter.apply(sampleCards, completedCardIds);

        final filterUpper = const LearningCardFilter(searchQuery: '목성');
        final resultUpper = filterUpper.apply(sampleCards, completedCardIds);

        expect(resultLower.length, equals(resultUpper.length));
      });

      test('empty search query returns all cards', () {
        final filter = const LearningCardFilter(searchQuery: '');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(5));
      });

      test('no match returns empty list', () {
        final filter = const LearningCardFilter(searchQuery: 'xyz123');
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.isEmpty, isTrue);
      });
    });

    group('Date filter', () {
      test('filters by date after', () {
        final filter = LearningCardFilter(
          dateAddedAfter: DateTime(2024, 1, 2),
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(3));
        expect(
          result.every((card) => card.createdAt!.isAfter(DateTime(2024, 1, 2))),
          isTrue,
        );
      });

      test('filters by date before', () {
        final filter = LearningCardFilter(
          dateAddedBefore: DateTime(2024, 1, 3),
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(
          result.every((card) => card.createdAt!.isBefore(DateTime(2024, 1, 3))),
          isTrue,
        );
      });

      test('filters by date range', () {
        final filter = LearningCardFilter(
          dateAddedAfter: DateTime(2024, 1, 2),
          dateAddedBefore: DateTime(2024, 1, 5),
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(2));
        expect(result.map((c) => c.id).toList(), containsAll(['card_3', 'card_4']));
      });
    });

    group('Combined filters', () {
      test('category and difficulty filter', () {
        final filter = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_1'));
      });

      test('category, difficulty, and completion status', () {
        final filter = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
          isCompleted: true,
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_1'));
      });

      test('search and tag filter', () {
        final filter = const LearningCardFilter(
          searchQuery: '달',
          selectedTags: ['아폴로'],
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_5'));
      });

      test('all filters combined', () {
        final filter = LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
          isCompleted: true,
          selectedTags: ['목성'],
          searchQuery: '태양계',
          dateAddedAfter: DateTime(2023, 12, 31),
        );
        final result = filter.apply(sampleCards, completedCardIds);

        expect(result.length, equals(1));
        expect(result.first.id, equals('card_1'));
      });
    });

    group('Filter state management', () {
      test('hasActiveFilters returns true when filters are set', () {
        final filter = const LearningCardFilter(category: 'planet');
        expect(filter.hasActiveFilters, isTrue);
      });

      test('hasActiveFilters returns false for empty filter', () {
        final filter = LearningCardFilter.empty();
        expect(filter.hasActiveFilters, isFalse);
      });

      test('activeFilterCount counts all active filters', () {
        final filter = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
          selectedTags: ['목성', '태양계'],
          isCompleted: true,
          searchQuery: 'test',
        );
        expect(filter.activeFilterCount, equals(6)); // category + difficulty + 2 tags + completed + search
      });

      test('copyWith creates new filter with updated values', () {
        final originalFilter = const LearningCardFilter(category: 'planet');
        final newFilter = originalFilter.copyWith(
          difficulty: LearningCardDifficulty.easy,
        );

        expect(newFilter.category, equals('planet'));
        expect(newFilter.difficulty, equals(LearningCardDifficulty.easy));
      });

      test('copyWith can clear individual filters', () {
        final originalFilter = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
        );
        final newFilter = originalFilter.copyWith(clearDifficulty: true);

        expect(newFilter.category, equals('planet'));
        expect(newFilter.difficulty, isNull);
      });
    });

    group('JSON serialization', () {
      test('toJson and fromJson round trip', () {
        final originalFilter = LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.medium,
          selectedTags: const ['목성', '태양계'],
          isCompleted: true,
          searchQuery: 'test query',
          dateAddedAfter: DateTime(2024, 1, 1),
          dateAddedBefore: DateTime(2024, 12, 31),
        );

        final json = originalFilter.toJson();
        final restoredFilter = LearningCardFilter.fromJson(json);

        expect(restoredFilter.category, equals(originalFilter.category));
        expect(restoredFilter.difficulty, equals(originalFilter.difficulty));
        expect(restoredFilter.selectedTags, equals(originalFilter.selectedTags));
        expect(restoredFilter.isCompleted, equals(originalFilter.isCompleted));
        expect(restoredFilter.searchQuery, equals(originalFilter.searchQuery));
        expect(
          restoredFilter.dateAddedAfter?.toIso8601String(),
          equals(originalFilter.dateAddedAfter?.toIso8601String()),
        );
        expect(
          restoredFilter.dateAddedBefore?.toIso8601String(),
          equals(originalFilter.dateAddedBefore?.toIso8601String()),
        );
      });

      test('fromJson handles null values', () {
        final json = {
          'category': null,
          'difficulty': null,
          'selectedTags': null,
          'isCompleted': null,
          'searchQuery': null,
          'dateAddedAfter': null,
          'dateAddedBefore': null,
        };

        final filter = LearningCardFilter.fromJson(json);

        expect(filter.category, isNull);
        expect(filter.difficulty, isNull);
        expect(filter.selectedTags, isEmpty);
        expect(filter.isCompleted, isNull);
        expect(filter.searchQuery, isEmpty);
        expect(filter.dateAddedAfter, isNull);
        expect(filter.dateAddedBefore, isNull);
      });
    });

    group('Equality and hashCode', () {
      test('equal filters have same hashCode', () {
        final filter1 = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
        );
        final filter2 = const LearningCardFilter(
          category: 'planet',
          difficulty: LearningCardDifficulty.easy,
        );

        expect(filter1, equals(filter2));
        expect(filter1.hashCode, equals(filter2.hashCode));
      });

      test('different filters are not equal', () {
        final filter1 = const LearningCardFilter(category: 'planet');
        final filter2 = const LearningCardFilter(category: 'phenomenon');

        expect(filter1, isNot(equals(filter2)));
      });
    });
  });
}
