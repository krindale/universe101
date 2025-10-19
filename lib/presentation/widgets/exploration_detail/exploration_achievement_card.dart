import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../planet_detail/common/planet_tag.dart';

/// Achievement card for exploration detail screens
/// Displays individual mission achievements
class ExplorationAchievementCard extends StatelessWidget {
  final MapEntry<String, String> achievement;
  final int achievementIndex;
  final Color accentColor;

  const ExplorationAchievementCard({
    super.key,
    required this.achievement,
    required this.achievementIndex,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 56, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  PlanetTag(text: 'Achievement #${achievementIndex + 1}'),
                  const SizedBox(height: 32),

                  // Achievement icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.emoji_events,
                      size: 36,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Achievement title
                  Text(
                    achievement.key,
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Achievement content
                  Text(
                    achievement.value,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right)
            Positioned(
              right: 24,
              bottom: 24,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accentColor,
                  border: Border(
                    left: BorderSide(color: AppColors.borderPrimary, width: 1),
                    top: BorderSide(color: AppColors.borderPrimary, width: 1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
