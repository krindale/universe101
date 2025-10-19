import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/cosmic_phenomenon.dart';
import '../planet_detail/common/planet_tag.dart';

/// Overview card for phenomenon detail screens
/// Displays phenomenon icon, name, and key metrics with ChainGPT design
class PhenomenonOverviewCard extends StatelessWidget {
  final CosmicPhenomenon phenomenon;
  final Color accentColor;

  const PhenomenonOverviewCard({
    super.key,
    required this.phenomenon,
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
                    children: [
                      PlanetTag(text: _getPhenomenonTypeLabel(phenomenon.type)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Phenomenon icon (임시 - 이미지 없음)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      _getPhenomenonIcon(phenomenon.type),
                      size: 64,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Phenomenon name
                  Text(
                    phenomenon.name,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Phenomenon subtitle
                  Text(
                    phenomenon.location,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),

                  // Metrics grid (2x2)
                  _buildMetricsGrid(),

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
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Column(
        children: [
          // First row
          Row(
            children: [
              _buildMetricCell('희귀도', '${phenomenon.rarity}/10'),
              Container(
                width: 1,
                height: 60,
                color: AppColors.borderPrimary,
              ),
              _buildMetricCell('관측 위치', phenomenon.location),
            ],
          ),
          Container(
            height: 1,
            color: AppColors.borderPrimary,
          ),
          // Second row
          Row(
            children: [
              _buildMetricCell('관련 천체', '${phenomenon.relatedBodies.length}개'),
              Container(
                width: 1,
                height: 60,
                color: AppColors.borderPrimary,
              ),
              _buildMetricCell(
                '다음 발생',
                phenomenon.nextOccurrence != null
                    ? _formatDate(phenomenon.nextOccurrence!)
                    : '미정',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCell(String label, String value) {
    return Expanded(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getPhenomenonTypeLabel(PhenomenonType type) {
    switch (type) {
      case PhenomenonType.atmospheric:
        return '대기 현상';
      case PhenomenonType.stellar:
        return '항성 현상';
      case PhenomenonType.gravitational:
        return '중력 현상';
      case PhenomenonType.orbital:
        return '궤도 현상';
      case PhenomenonType.eclipse:
        return '식 현상';
      case PhenomenonType.aurora:
        return '오로라';
      case PhenomenonType.supernova:
        return '초신성';
      case PhenomenonType.meteorShower:
        return '유성우';
      case PhenomenonType.comet:
        return '혜성';
      case PhenomenonType.transit:
        return '통과 현상';
      case PhenomenonType.conjunction:
        return '행성 정렬';
      case PhenomenonType.blackHole:
        return '블랙홀';
      case PhenomenonType.nebula:
        return '성운';
      case PhenomenonType.other:
        return '기타 현상';
    }
  }

  IconData _getPhenomenonIcon(PhenomenonType type) {
    switch (type) {
      case PhenomenonType.atmospheric:
        return Icons.cloud;
      case PhenomenonType.stellar:
        return Icons.star;
      case PhenomenonType.gravitational:
        return Icons.sync;
      case PhenomenonType.orbital:
        return Icons.track_changes;
      case PhenomenonType.eclipse:
        return Icons.brightness_3;
      case PhenomenonType.aurora:
        return Icons.waves;
      case PhenomenonType.supernova:
        return Icons.auto_awesome;
      case PhenomenonType.meteorShower:
        return Icons.scatter_plot;
      case PhenomenonType.comet:
        return Icons.blur_on;
      case PhenomenonType.transit:
        return Icons.timeline;
      case PhenomenonType.conjunction:
        return Icons.adjust;
      case PhenomenonType.blackHole:
        return Icons.radio_button_checked;
      case PhenomenonType.nebula:
        return Icons.filter_drama;
      case PhenomenonType.other:
        return Icons.bubble_chart;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month}.${date.day}';
  }
}
