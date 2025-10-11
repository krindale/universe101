import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/learning_card.dart';

/// Swipeable learning card widget with Tinder-like interaction
class SwipeableCard extends StatefulWidget {
  final LearningCard card;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final bool isTop;

  const SwipeableCard({
    super.key,
    required this.card,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onTap,
    this.onShare,
    this.isTop = false,
  });

  @override
  State<SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<SwipeableCard>
    with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final milliseconds = _isDragging ? 0 : 400;

    return AnimatedContainer(
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()
        ..setTranslationRaw(_position.dx, _position.dy, 0.0)
        ..rotateZ(_angle),
      child: GestureDetector(
        onTap: widget.onTap,
        onPanStart: (details) {
          if (!widget.isTop) return;
          setState(() => _isDragging = true);
        },
        onPanUpdate: (details) {
          if (!widget.isTop) return;
          setState(() {
            _position += details.delta;
            _angle = 0.45 * _position.dx / screenSize.width;
          });
        },
        onPanEnd: (details) {
          if (!widget.isTop) return;
          setState(() => _isDragging = false);

          final threshold = screenSize.width * 0.3;

          if (_position.dx.abs() > threshold) {
            // Swipe completed
            final direction = _position.dx > 0 ? 1 : -1;
            _swipeCard(direction);
          } else {
            // Return to center
            setState(() {
              _position = Offset.zero;
              _angle = 0;
            });
          }
        },
        child: _buildCard(context),
      ),
    );
  }

  void _swipeCard(int direction) {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      _position = Offset(direction * screenSize.width * 1.5, 0);
      _angle = direction * 0.5;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (direction > 0 && widget.onSwipeRight != null) {
        widget.onSwipeRight!();
      } else if (direction < 0 && widget.onSwipeLeft != null) {
        widget.onSwipeLeft!();
      }
    });
  }

  Widget _buildCard(BuildContext context) {

    return Stack(
      children: [
        // Main Card
        Container(
          height: 500,
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.paddingLG,
            vertical: AppSpacing.paddingMD,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cosmicBlue.withValues(alpha: 0.3),
                AppColors.nebulaPurple.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            border: Border.all(
              color: AppColors.nebulaPurple.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.nebulaPurple.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
            child: Stack(
              children: [
                // Background Pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: StarfieldPainter(),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.paddingXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Badge and Share Button
                      Row(
                        children: [
                          _buildCategoryBadge(),
                          const Spacer(),
                          if (widget.onShare != null)
                            IconButton(
                              icon: const Icon(Icons.share),
                              color: AppColors.stardustGold,
                              onPressed: widget.onShare,
                              tooltip: '공유하기',
                            ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // Title
                      Text(
                        widget.card.title,
                        style: AppTypography.headlineSmall.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.card.content,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.md),

                      // Footer with Tags and Difficulty
                      _buildFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Swipe Indicators
        if (widget.isTop && _isDragging) ...[
          _buildSwipeIndicator(
            isRight: true,
            opacity: math.max(0.0, _position.dx / 100).clamp(0.0, 1.0),
          ),
          _buildSwipeIndicator(
            isRight: false,
            opacity: math.max(0.0, -_position.dx / 100).clamp(0.0, 1.0),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryBadge() {
    IconData icon;
    String label;

    switch (widget.card.category) {
      case 'planet':
        icon = Icons.public;
        label = '행성';
        break;
      case 'phenomenon':
        icon = Icons.auto_awesome;
        label = '현상';
        break;
      case 'exploration':
        icon = Icons.rocket_launch;
        label = '탐사';
        break;
      default:
        icon = Icons.star;
        label = '일반';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMD,
        vertical: AppSpacing.paddingSM,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.stardustGold, AppColors.solarOrange],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        // Difficulty
        Text(
          widget.card.difficulty.emoji,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          widget.card.difficulty.displayName,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        const Spacer(),

        // Tags
        if (widget.card.tags.isNotEmpty)
          Wrap(
            spacing: AppSpacing.xs,
            children: widget.card.tags.take(2).map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingSM,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.nebulaPurple.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                  border: Border.all(
                    color: AppColors.nebulaPurple.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  '#$tag',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.stardustGold,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSwipeIndicator({required bool isRight, required double opacity}) {
    return Positioned(
      top: 100,
      left: isRight ? null : 40,
      right: isRight ? 40 : null,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: isRight ? -0.3 : 0.3,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.paddingLG),
            decoration: BoxDecoration(
              color: isRight
                  ? Colors.green.withValues(alpha: 0.3)
                  : Colors.red.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              border: Border.all(
                color: isRight ? Colors.green : Colors.red,
                width: 3,
              ),
            ),
            child: Icon(
              isRight ? Icons.favorite : Icons.close,
              color: isRight ? Colors.green : Colors.red,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for starfield background
class StarfieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.textPrimary.withValues(alpha: 0.1);
    final random = math.Random(42); // Fixed seed for consistent pattern

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
