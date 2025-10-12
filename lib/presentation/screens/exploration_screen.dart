import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/datasources/database_helper.dart';
import '../../domain/entities/space_exploration.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/portfolio_card.dart';

class ExplorationScreen extends StatelessWidget {
  const ExplorationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CosmicBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Small header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Text(
                  '우주 탐사',
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Horizontal PageView
              Expanded(
                child: FutureBuilder<List<SpaceExploration>>(
                  future: databaseHelper.getAllExplorations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    final explorations = snapshot.data ?? [];

                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.88),
                      itemCount: explorations.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: _buildExplorationCard(context, explorations[index]),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplorationCard(BuildContext context, SpaceExploration exploration) {
    return PortfolioCard(
      tag: _getExplorationTypeLabel(exploration.type),
      icon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getExplorationColor(exploration.type).withValues(alpha: 0.15),
        ),
        child: Icon(
          _getExplorationIcon(exploration.type),
          size: 32,
          color: _getExplorationColor(exploration.type),
        ),
      ),
      title: exploration.name,
      subtitle: exploration.agency,
      description: exploration.description,
      metrics: [
        MetricData(label: '발사일', value: _formatDate(exploration.launchDate)),
        MetricData(label: '상태', value: _getStatusLabel(exploration.status)),
        MetricData(label: '목적지', value: exploration.destination ?? '미지정'),
        MetricData(label: '우주선', value: exploration.spacecraftName ?? '미지정'),
        MetricData(label: '승무원', value: '${exploration.crewMembers.length}명'),
        MetricData(label: '성과', value: '${exploration.achievements.length}개'),
      ],
      accentColor: _getExplorationColor(exploration.type),
      onTap: () {
        // TODO: Navigate to exploration detail
      },
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

  Color _getExplorationColor(ExplorationType type) {
    switch (type) {
      case ExplorationType.satellite:
        return const Color(0xFF42A5F5); // Blue
      case ExplorationType.probe:
        return const Color(0xFF66BB6A); // Green
      case ExplorationType.rover:
        return const Color(0xFFEF5350); // Red
      case ExplorationType.telescope:
        return const Color(0xFF9575CD); // Purple
      case ExplorationType.mannedMission:
        return AppColors.accent; // Orange
      case ExplorationType.unmannedMission:
        return const Color(0xFF26A69A); // Teal
      case ExplorationType.satelliteLaunch:
        return const Color(0xFF5C6BC0); // Indigo
      case ExplorationType.spaceStation:
        return const Color(0xFF78909C); // Blue grey
      case ExplorationType.lunarMission:
        return const Color(0xFFBDBDBD); // Grey
      case ExplorationType.marsMission:
        return const Color(0xFFFF7043); // Deep orange
      case ExplorationType.deepSpace:
        return const Color(0xFF7E57C2); // Deep purple
      case ExplorationType.other:
        return AppColors.accent;
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
