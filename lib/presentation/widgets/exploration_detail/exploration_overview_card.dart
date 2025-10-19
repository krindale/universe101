import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/space_exploration.dart';
import '../planet_detail/common/planet_tag.dart';

/// Overview card for exploration detail screens
/// Displays exploration icon, name, and key metrics
class ExplorationOverviewCard extends StatelessWidget {
  final SpaceExploration exploration;
  final Color accentColor;

  const ExplorationOverviewCard({
    super.key,
    required this.exploration,
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
                      PlanetTag(text: _getExplorationTypeLabel(exploration.type)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Exploration icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      _getExplorationIcon(exploration.type),
                      size: 64,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Exploration name
                  Text(
                    exploration.name,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Agency subtitle
                  Text(
                    exploration.agency,
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
              _buildMetricCell('발사일', _formatDate(exploration.launchDate)),
              Container(
                width: 1,
                height: 60,
                color: AppColors.borderPrimary,
              ),
              _buildMetricCell('상태', _getStatusLabel(exploration.status)),
            ],
          ),
          Container(
            height: 1,
            color: AppColors.borderPrimary,
          ),
          // Second row
          Row(
            children: [
              _buildMetricCell('목적지', exploration.destination ?? '미지정'),
              Container(
                width: 1,
                height: 60,
                color: AppColors.borderPrimary,
              ),
              _buildMetricCell('승무원', '${exploration.crewMembers.length}명'),
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

  String _getExplorationTypeLabel(ExplorationType type) {
    switch (type) {
      case ExplorationType.satellite:
        return '인공위성';
      case ExplorationType.probe:
        return '우주 탐사선';
      case ExplorationType.rover:
        return '행성 탐사 로버';
      case ExplorationType.telescope:
        return '우주 망원경';
      case ExplorationType.mannedMission:
        return '유인 우주선';
      case ExplorationType.unmannedMission:
        return '무인 탐사선';
      case ExplorationType.satelliteLaunch:
        return '위성 발사';
      case ExplorationType.spaceStation:
        return '우주 정거장';
      case ExplorationType.lunarMission:
        return '달 탐사';
      case ExplorationType.marsMission:
        return '화성 탐사';
      case ExplorationType.deepSpace:
        return '심우주 탐사';
      case ExplorationType.other:
        return '기타 탐사';
    }
  }

  IconData _getExplorationIcon(ExplorationType type) {
    switch (type) {
      case ExplorationType.satellite:
        return Icons.satellite_alt;
      case ExplorationType.probe:
        return Icons.explore;
      case ExplorationType.rover:
        return Icons.agriculture;
      case ExplorationType.telescope:
        return Icons.grid_view;
      case ExplorationType.mannedMission:
        return Icons.person;
      case ExplorationType.unmannedMission:
        return Icons.smart_toy;
      case ExplorationType.satelliteLaunch:
        return Icons.upload;
      case ExplorationType.spaceStation:
        return Icons.location_city;
      case ExplorationType.lunarMission:
        return Icons.nights_stay;
      case ExplorationType.marsMission:
        return Icons.circle;
      case ExplorationType.deepSpace:
        return Icons.blur_circular;
      case ExplorationType.other:
        return Icons.rocket_launch;
    }
  }

  String _getStatusLabel(ExplorationStatus status) {
    switch (status) {
      case ExplorationStatus.active:
        return '진행중';
      case ExplorationStatus.completed:
        return '완료';
      case ExplorationStatus.planned:
        return '계획됨';
      case ExplorationStatus.failed:
        return '실패';
      case ExplorationStatus.ongoing:
        return '진행';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month}.${date.day}';
  }
}
