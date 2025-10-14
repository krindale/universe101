import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_colors_extended.dart';
import '../../../core/theme/app_typography.dart';
import 'common/planet_tag.dart';

/// Episode card for planet detail screens
/// Displays historical episodes about planets with episode numbers
class PlanetEpisodeCard extends StatelessWidget {
  final String episode;
  final int index;

  const PlanetEpisodeCard({
    super.key,
    required this.episode,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Parse episode string format: "제목: 내용"
    final parts = episode.split(':');
    final title = parts.isNotEmpty ? parts[0].trim() : '에피소드';
    final content = parts.length > 1
        ? parts.sublist(1).join(':').trim()
        : episode;

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
                  PlanetTag(text: 'Historical Episode'),
                  const SizedBox(height: 32),

                  // Episode number badge
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColorsExtended.chainGPTOrange.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsExtended.chainGPTOrange,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTypography.headlineMedium.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColorsExtended.chainGPTOrange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Episode title
                  Text(
                    title,
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Episode content
                  Text(
                    content,
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
                  color: AppColorsExtended.chainGPTOrange,
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
