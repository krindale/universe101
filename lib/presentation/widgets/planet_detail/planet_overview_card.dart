import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/celestial_body.dart';
import 'common/planet_tag.dart';
import 'planet_metrics_grid.dart';

/// Overview card for planet detail screens
/// Displays planet icon, name, and metrics grid with ChainGPT design
class PlanetOverviewCard extends StatelessWidget {
  final Planet planet;
  final Color accentColor;

  const PlanetOverviewCard({
    super.key,
    required this.planet,
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
                    children: [PlanetTag(text: 'Rocky Planet')],
                  ),
                  const SizedBox(height: 32),

                  // Planet image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        planet.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.public,
                              size: 64,
                              color: accentColor,
                            ),
                          );
                        },
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
                  const SizedBox(height: 8),

                  // Planet subtitle
                  Text(
                    _getPlanetSubtitle(planet.name),
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.textSecondary,
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

  String _getPlanetSubtitle(String name) {
    switch (name) {
      case '수성 (Mercury)':
        return '태양에 가장 가까운 행성';
      case '금성 (Venus)':
        return '가장 뜨거운 행성';
      case '지구 (Earth)':
        return '우리의 고향';
      case '화성 (Mars)':
        return '붉은 행성';
      case '목성 (Jupiter)':
        return '가장 큰 행성';
      case '토성 (Saturn)':
        return '아름다운 고리';
      case '천왕성 (Uranus)':
        return '옆으로 누운 행성';
      case '해왕성 (Neptune)':
        return '가장 먼 행성';
      default:
        return '';
    }
  }
}
