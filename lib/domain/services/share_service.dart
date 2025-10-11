import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../entities/learning_card.dart';

/// Service for sharing learning cards
class ShareService {
  /// Share a learning card with formatted text
  Future<ShareResult> shareLearningCard(
    LearningCard card, {
    String? subject,
  }) async {
    final text = _formatCardText(card);
    return await Share.share(
      text,
      subject: subject ?? '우주 탐험 - ${card.title}',
    );
  }

  /// Share a learning card with specific text for social media
  Future<ShareResult> shareForSocialMedia(LearningCard card) async {
    final text = _formatCardForSocialMedia(card);
    return await Share.share(
      text,
      subject: '우주에 대한 흥미로운 사실! 🌌',
    );
  }

  /// Share multiple cards at once
  Future<ShareResult> shareMultipleCards(List<LearningCard> cards) async {
    if (cards.isEmpty) {
      throw ArgumentError('Cards list cannot be empty');
    }

    final text = _formatMultipleCards(cards);
    return await Share.share(
      text,
      subject: '우주 탐험 - ${cards.length}개의 학습 카드',
    );
  }

  /// Share card with position (for iPadOS)
  Future<ShareResult> shareCardWithPosition(
    LearningCard card, {
    required Rect origin,
  }) async {
    final text = _formatCardText(card);
    return await Share.shareXFiles(
      [XFile.fromData(Uint8List.fromList(text.codeUnits), mimeType: 'text/plain')],
      subject: '우주 탐험 - ${card.title}',
      sharePositionOrigin: origin,
    );
  }

  /// Format card as plain text
  String formatAsPlainText(LearningCard card) {
    return _formatCardText(card);
  }

  /// Format card as markdown
  String formatAsMarkdown(LearningCard card) {
    return '''
# ${card.title}

**카테고리**: ${_getCategoryDisplayName(card.category)}
**난이도**: ${card.difficulty.displayName} ${card.difficulty.emoji}

---

${card.content}

${card.tags.isNotEmpty ? '\n**태그**: ${card.tags.join(", ")}' : ''}

---

📱 Universe 101 앱에서 더 많은 우주 지식을 탐험하세요!
''';
  }

  /// Format card for email
  String formatForEmail(LearningCard card) {
    return '''
<html>
<body style="font-family: Arial, sans-serif; padding: 20px; background-color: #f5f5f5;">
  <div style="background-color: white; border-radius: 8px; padding: 20px; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h1 style="color: #1976d2; margin-bottom: 10px;">${card.title}</h1>
    <p style="color: #666; font-size: 14px; margin-bottom: 20px;">
      <strong>카테고리:</strong> ${_getCategoryDisplayName(card.category)} |
      <strong>난이도:</strong> ${card.difficulty.displayName} ${card.difficulty.emoji}
    </p>
    <hr style="border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;">
    <p style="color: #333; line-height: 1.6; font-size: 16px;">${card.content}</p>
    ${card.tags.isNotEmpty ? '<p style="color: #666; font-size: 14px; margin-top: 20px;"><strong>태그:</strong> ${card.tags.join(", ")}</p>' : ''}
    <hr style="border: none; border-top: 1px solid #e0e0e0; margin: 20px 0;">
    <p style="color: #999; font-size: 12px; text-align: center;">
      📱 Universe 101 앱에서 더 많은 우주 지식을 탐험하세요!
    </p>
  </div>
</body>
</html>
''';
  }

  /// Private method to format card text
  String _formatCardText(LearningCard card) {
    final buffer = StringBuffer();

    // Title and metadata
    buffer.writeln('🌌 ${card.title}');
    buffer.writeln();
    buffer.writeln(
        '📚 카테고리: ${_getCategoryDisplayName(card.category)} | 난이도: ${card.difficulty.displayName} ${card.difficulty.emoji}');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();

    // Content
    buffer.writeln(card.content);
    buffer.writeln();

    // Tags
    if (card.tags.isNotEmpty) {
      buffer.writeln('🏷️ 태그: ${card.tags.join(", ")}');
      buffer.writeln();
    }

    // Footer
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📱 Universe 101 앱에서 더 많은 우주 지식을 탐험하세요!');

    // Deep link (if card has ID)
    if (card.id.isNotEmpty) {
      buffer.writeln('🔗 universe101://card/${card.id}');
    }

    return buffer.toString();
  }

  /// Format card for social media with shorter text
  String _formatCardForSocialMedia(LearningCard card) {
    final buffer = StringBuffer();

    // Emoji based on category
    final emoji = _getCategoryEmoji(card.category);

    buffer.writeln('$emoji ${card.title}');
    buffer.writeln();

    // Truncate content if too long (280 characters for Twitter-like platforms)
    final content = card.content.length > 200
        ? '${card.content.substring(0, 197)}...'
        : card.content;
    buffer.writeln(content);
    buffer.writeln();

    // Hashtags
    final hashtags = ['우주탐험', '우주지식', 'Universe101'];
    if (card.tags.isNotEmpty) {
      hashtags.addAll(card.tags.take(2));
    }
    buffer.write(hashtags.map((tag) => '#$tag').join(' '));

    return buffer.toString();
  }

  /// Format multiple cards
  String _formatMultipleCards(List<LearningCard> cards) {
    final buffer = StringBuffer();

    buffer.writeln('🌌 Universe 101 - 학습 카드 모음');
    buffer.writeln('총 ${cards.length}개의 우주 지식');
    buffer.writeln();
    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln();

    for (var i = 0; i < cards.length; i++) {
      final card = cards[i];
      buffer.writeln('${i + 1}. ${card.title}');
      buffer.writeln('   ${_getCategoryDisplayName(card.category)} | ${card.difficulty.displayName}');
      buffer.writeln();

      // Show first 100 characters of content
      final preview = card.content.length > 100
          ? '${card.content.substring(0, 97)}...'
          : card.content;
      buffer.writeln('   $preview');
      buffer.writeln();
    }

    buffer.writeln('━━━━━━━━━━━━━━━━━━━━');
    buffer.writeln('📱 Universe 101 앱에서 더 많은 우주 지식을 탐험하세요!');

    return buffer.toString();
  }

  /// Get category display name
  String _getCategoryDisplayName(String category) {
    switch (category.toLowerCase()) {
      case 'planet':
        return '행성';
      case 'phenomenon':
        return '우주 현상';
      case 'exploration':
        return '우주 탐사';
      case 'general':
        return '일반';
      default:
        return category;
    }
  }

  /// Get category emoji
  String _getCategoryEmoji(String category) {
    switch (category.toLowerCase()) {
      case 'planet':
        return '🪐';
      case 'phenomenon':
        return '✨';
      case 'exploration':
        return '🚀';
      case 'general':
        return '🌌';
      default:
        return '📚';
    }
  }
}

