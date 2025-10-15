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
                  SizedBox(
                    height: 120,
                    child: Image.asset(
                      planet.imageUrl,
                      height: 120,
                      fit: BoxFit.fitHeight,
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
                  const SizedBox(height: 24),

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
        return '태양에 가장 가까운 작은 행성,\n극심한 온도 변화와 수많은 크레이터';
      case '금성 (Venus)':
        return '태양계에서 가장 뜨거운 지옥 같은 행성,\n두꺼운 이산화탄소 대기';
      case '지구 (Earth)':
        return '생명이 살아 숨 쉬는 우주의 푸른 오아시스,\n물과 산소가 풍부한 행성';
      case '화성 (Mars)':
        return '붉은 사막의 행성,\n인류의 다음 목적지이자 과거에 물이 흘렀던 세계';
      case '목성 (Jupiter)':
        return '태양계의 거대한 왕,\n강력한 폭풍과 95개 이상의 위성을 가진 가스 행성';
      case '토성 (Saturn)':
        return '아름다운 고리를 가진 태양계의 보석,\n물보다 가벼운 신비로운 행성';
      case '천왕성 (Uranus)':
        return '옆으로 누워 도는 신비로운 얼음 거인,\n청록색 메탄 대기의 행성';
      case '해왕성 (Neptune)':
        return '태양계 가장 먼 곳의 푸른 얼음 행성,\n강력한 바람이 부는 신비의 세계';
      default:
        return '';
    }
  }
}
