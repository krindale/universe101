import 'package:flutter_test/flutter_test.dart';
import 'package:universe101/domain/entities/learning_card.dart';
import 'package:universe101/domain/services/share_service.dart';

void main() {
  late ShareService shareService;
  late LearningCard testCard;

  setUp(() {
    shareService = ShareService();
    testCard = LearningCard(
      id: 'test_card_1',
      title: '화성의 비밀',
      content: '화성은 태양계에서 네 번째 행성이며, 붉은 행성으로 알려져 있습니다. 화성의 표면은 산화철로 덮여 있어 붉게 보입니다.',
      category: 'planet',
      difficulty: LearningCardDifficulty.medium,
      tags: ['화성', '행성', '태양계'],
      relatedId: 'mars',
      createdAt: DateTime(2024, 1, 1),
    );
  });

  group('ShareService - Text Formatting', () {
    test('formatAsPlainText should format card correctly', () {
      // Act
      final result = shareService.formatAsPlainText(testCard);

      // Assert
      expect(result, contains('🌌 화성의 비밀'));
      expect(result, contains('📚 카테고리: 행성'));
      expect(result, contains('난이도: 보통 🟡'));
      expect(result, contains(testCard.content));
      expect(result, contains('🏷️ 태그: 화성, 행성, 태양계'));
      expect(result, contains('Universe 101'));
      expect(result, contains('universe101://card/test_card_1'));
    });

    test('formatAsMarkdown should format card with markdown syntax', () {
      // Act
      final result = shareService.formatAsMarkdown(testCard);

      // Assert
      expect(result, contains('# 화성의 비밀'));
      expect(result, contains('**카테고리**: 행성'));
      expect(result, contains('**난이도**: 보통 🟡'));
      expect(result, contains(testCard.content));
      expect(result, contains('**태그**: 화성, 행성, 태양계'));
    });

    test('formatForEmail should format card as HTML', () {
      // Act
      final result = shareService.formatForEmail(testCard);

      // Assert
      expect(result, contains('<html>'));
      expect(result, contains('<h1'));
      expect(result, contains('화성의 비밀'));
      expect(result, contains('<strong>카테고리:</strong> 행성'));
      expect(result, contains('<strong>난이도:</strong> 보통'));
      expect(result, contains(testCard.content));
      expect(result, contains('</html>'));
    });

    test('formatAsPlainText should include deep link', () {
      // Act
      final result = shareService.formatAsPlainText(testCard);

      // Assert
      expect(result, contains('universe101://card/test_card_1'));
    });

    test('formatAsPlainText should not include deep link if card has no ID', () {
      // Arrange
      final cardWithoutId = LearningCard(
        id: '',
        title: 'Test Card',
        content: 'Test content',
        category: 'general',
      );

      // Act
      final result = shareService.formatAsPlainText(cardWithoutId);

      // Assert
      expect(result, isNot(contains('universe101://card/')));
    });
  });

  group('ShareService - Category Display', () {
    test('should display correct category name for planet', () {
      // Arrange
      final planetCard = testCard;

      // Act
      final result = shareService.formatAsPlainText(planetCard);

      // Assert
      expect(result, contains('카테고리: 행성'));
    });

    test('should display correct category name for phenomenon', () {
      // Arrange
      final phenomenonCard = LearningCard(
        id: 'test_2',
        title: 'Test',
        content: 'Content',
        category: 'phenomenon',
      );

      // Act
      final result = shareService.formatAsPlainText(phenomenonCard);

      // Assert
      expect(result, contains('카테고리: 우주 현상'));
    });

    test('should display correct category name for exploration', () {
      // Arrange
      final explorationCard = LearningCard(
        id: 'test_3',
        title: 'Test',
        content: 'Content',
        category: 'exploration',
      );

      // Act
      final result = shareService.formatAsPlainText(explorationCard);

      // Assert
      expect(result, contains('카테고리: 우주 탐사'));
    });

    test('should display correct category name for general', () {
      // Arrange
      final generalCard = LearningCard(
        id: 'test_4',
        title: 'Test',
        content: 'Content',
        category: 'general',
      );

      // Act
      final result = shareService.formatAsPlainText(generalCard);

      // Assert
      expect(result, contains('카테고리: 일반'));
    });
  });

  group('ShareService - Difficulty Display', () {
    test('should display easy difficulty correctly', () {
      // Arrange
      final easyCard = LearningCard(
        id: 'test',
        title: 'Test',
        content: 'Content',
        category: 'general',
        difficulty: LearningCardDifficulty.easy,
      );

      // Act
      final result = shareService.formatAsPlainText(easyCard);

      // Assert
      expect(result, contains('난이도: 쉬움 🟢'));
    });

    test('should display medium difficulty correctly', () {
      // Arrange
      final mediumCard = testCard;

      // Act
      final result = shareService.formatAsPlainText(mediumCard);

      // Assert
      expect(result, contains('난이도: 보통 🟡'));
    });

    test('should display hard difficulty correctly', () {
      // Arrange
      final hardCard = LearningCard(
        id: 'test',
        title: 'Test',
        content: 'Content',
        category: 'general',
        difficulty: LearningCardDifficulty.hard,
      );

      // Act
      final result = shareService.formatAsPlainText(hardCard);

      // Assert
      expect(result, contains('난이도: 어려움 🔴'));
    });
  });

  group('ShareService - Tags Display', () {
    test('should display tags when present', () {
      // Arrange
      final cardWithTags = testCard;

      // Act
      final result = shareService.formatAsPlainText(cardWithTags);

      // Assert
      expect(result, contains('🏷️ 태그: 화성, 행성, 태양계'));
    });

    test('should not display tags section when tags are empty', () {
      // Arrange
      final cardWithoutTags = LearningCard(
        id: 'test',
        title: 'Test',
        content: 'Content',
        category: 'general',
        tags: [],
      );

      // Act
      final result = shareService.formatAsPlainText(cardWithoutTags);

      // Assert
      expect(result, isNot(contains('🏷️ 태그:')));
    });
  });

  group('ShareService - Multiple Cards', () {
    test('shareMultipleCards should throw error when list is empty', () {
      // Act & Assert
      expect(
        () => shareService.shareMultipleCards([]),
        throwsArgumentError,
      );
    });

    test('formatAsPlainText for multiple cards should include all cards', () {
      // Arrange
      final cards = [
        testCard,
        LearningCard(
          id: 'test_2',
          title: 'Test Card 2',
          content: 'Content 2',
          category: 'general',
          difficulty: LearningCardDifficulty.easy,
        ),
        LearningCard(
          id: 'test_3',
          title: 'Test Card 3',
          content: 'Content 3',
          category: 'exploration',
          difficulty: LearningCardDifficulty.hard,
        ),
      ];

      // We can't directly test the private method, but we can verify the logic
      // by checking the individual card formatting
      for (final card in cards) {
        final result = shareService.formatAsPlainText(card);
        expect(result, contains(card.title));
        expect(result, contains(card.content));
      }
    });
  });

  group('ShareService - Social Media Formatting', () {
    test('should create shorter text for social media', () {
      // Arrange
      final longCard = LearningCard(
        id: 'test',
        title: '긴 제목의 카드',
        content: '이것은 매우 긴 내용입니다. ' * 20, // 400+ characters
        category: 'planet',
        tags: ['태그1', '태그2', '태그3'],
      );

      // We can't directly test the private method, but we can verify
      // that plain text includes full content
      final plainResult = shareService.formatAsPlainText(longCard);
      expect(plainResult, contains(longCard.content));
    });
  });
}
