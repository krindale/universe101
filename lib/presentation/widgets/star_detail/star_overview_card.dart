import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/celestial_body.dart';
import '../planet_detail/common/planet_tag.dart';
import 'star_metrics_grid.dart';

/// Overview card for star detail screens
/// Displays star icon, name, and metrics grid with ChainGPT design
class StarOverviewCard extends StatelessWidget {
  final Star star;
  final Color accentColor;

  const StarOverviewCard({
    super.key,
    required this.star,
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [PlanetTag(text: 'G-Type Star')],
                  ),
                  const SizedBox(height: 32),

                  // Star image
                  SizedBox(
                    height: 120,
                    child: Image.asset(
                      star.imageUrl,
                      height: 120,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.wb_sunny,
                            size: 64,
                            color: accentColor,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Star name
                  Text(
                    star.name,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Star subtitle
                  Text(
                    '태양계의 중심이자 생명의 근원,\n우리 시스템의 유일한 항성',
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),

                  // Metrics grid (2x3)
                  StarMetricsGrid(star: star),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right) - Reference style
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
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
