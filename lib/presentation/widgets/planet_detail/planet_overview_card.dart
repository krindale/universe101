import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_colors_extended.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/celestial_body.dart';
import 'common/planet_tag.dart';
import 'planet_metrics_grid.dart';

/// Overview card for planet detail screens
/// Displays planet icon, name, and metrics grid with ChainGPT design
class PlanetOverviewCard extends StatelessWidget {
  final Planet planet;

  const PlanetOverviewCard({
    super.key,
    required this.planet,
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
                    children: [
                      PlanetTag(text: 'Rocky Planet'),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Planet icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsExtended.chainGPTOrange,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.public,
                        size: 64,
                        color: AppColorsExtended.chainGPTOrange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Planet name
                  Text(
                    planet.name,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),

                  // Metrics grid (2x3)
                  PlanetMetricsGrid(planet: planet),

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
                  color: AppColorsExtended.chainGPTOrange,
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
