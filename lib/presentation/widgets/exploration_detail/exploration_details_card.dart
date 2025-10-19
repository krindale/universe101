import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/space_exploration.dart';
import '../planet_detail/common/planet_tag.dart';
import '../planet_detail/common/planet_info_row.dart';

/// Details card for exploration detail screens
/// Displays exploration description and key information
class ExplorationDetailsCard extends StatelessWidget {
  final SpaceExploration exploration;
  final Color accentColor;

  const ExplorationDetailsCard({
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
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  PlanetTag(text: 'Mission Details'),
                  const SizedBox(height: 32),

                  // Exploration icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getExplorationIcon(exploration.type),
                        size: 36,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    '탐사 정보',
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    exploration.description,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Info rows
                  PlanetInfoRow(
                    label: '우주선',
                    value: exploration.spacecraftName ?? '미지정',
                  ),
                  const SizedBox(height: 16),
                  PlanetInfoRow(
                    label: '소속 기관',
                    value: exploration.agency,
                  ),
                  const SizedBox(height: 16),
                  PlanetInfoRow(
                    label: '발사일',
                    value: _formatDate(exploration.launchDate),
                  ),
                  if (exploration.endDate != null) ...[
                    const SizedBox(height: 16),
                    PlanetInfoRow(
                      label: '종료일',
                      value: _formatDate(exploration.endDate!),
                    ),
                  ],
                  const SizedBox(height: 16),
                  PlanetInfoRow(
                    label: '목적지',
                    value: exploration.destination ?? '미지정',
                  ),
                  const SizedBox(height: 16),
                  PlanetInfoRow(
                    label: '상태',
                    value: _getStatusLabel(exploration.status),
                  ),
                  const SizedBox(height: 16),
                  PlanetInfoRow(
                    label: '승무원',
                    value: exploration.crewMembers.isEmpty
                        ? '무인 탐사'
                        : '${exploration.crewMembers.length}명',
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
