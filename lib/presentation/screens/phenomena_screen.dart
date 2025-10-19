import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/datasources/cosmic_phenomena_data.dart';
import '../../domain/entities/cosmic_phenomenon.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/portfolio_card.dart';
import 'phenomenon_detail_screen.dart';

class PhenomenaScreen extends StatelessWidget {
  const PhenomenaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phenomena = CosmicPhenomenaData.getAllPhenomena();

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
                  '우주 현상',
                  style: AppTypography.headlineLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Horizontal PageView
              Expanded(
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.88),
                  itemCount: phenomena.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: _buildPhenomenonCard(context, phenomena[index]),
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

  Widget _buildPhenomenonCard(BuildContext context, CosmicPhenomenon phenomenon) {
    return PortfolioCard(
      tag: _getPhenomenonTypeLabel(phenomenon.type),
      icon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getPhenomenonColor(phenomenon.type).withValues(alpha: 0.15),
        ),
        child: Icon(
          _getPhenomenonIcon(phenomenon.type),
          size: 32,
          color: _getPhenomenonColor(phenomenon.type),
        ),
      ),
      title: phenomenon.name,
      subtitle: phenomenon.location,
      description: phenomenon.description,
      metrics: [
        MetricData(label: '희귀도', value: '${phenomenon.rarity}/10'),
        MetricData(label: '유형', value: _getPhenomenonTypeLabel(phenomenon.type)),
        MetricData(label: '관측지', value: phenomenon.location),
        MetricData(label: '관련천체', value: '${phenomenon.relatedBodies.length}개'),
        MetricData(label: '사실개수', value: '${phenomenon.facts.length}개'),
        MetricData(
          label: '다음발생',
          value: phenomenon.nextOccurrence != null
            ? _formatDate(phenomenon.nextOccurrence!)
            : '미정'
        ),
      ],
      accentColor: _getPhenomenonColor(phenomenon.type),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhenomenonDetailScreen(phenomenon: phenomenon),
          ),
        );
      },
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

  Color _getPhenomenonColor(PhenomenonType type) {
    switch (type) {
      case PhenomenonType.atmospheric:
        return const Color(0xFF64B5F6); // Light blue
      case PhenomenonType.stellar:
        return const Color(0xFFFFD54F); // Yellow
      case PhenomenonType.gravitational:
        return const Color(0xFF9575CD); // Purple
      case PhenomenonType.orbital:
        return const Color(0xFF81C784); // Green
      case PhenomenonType.eclipse:
        return const Color(0xFF90A4AE); // Blue grey
      case PhenomenonType.aurora:
        return const Color(0xFF4DB6AC); // Teal
      case PhenomenonType.supernova:
        return AppColors.accent; // Orange
      case PhenomenonType.meteorShower:
        return const Color(0xFFFFB74D); // Light orange
      case PhenomenonType.comet:
        return const Color(0xFFA1887F); // Brown
      case PhenomenonType.transit:
        return const Color(0xFF7986CB); // Indigo
      case PhenomenonType.conjunction:
        return const Color(0xFFE57373); // Red
      case PhenomenonType.blackHole:
        return const Color(0xFF424242); // Dark grey
      case PhenomenonType.nebula:
        return const Color(0xFFBA68C8); // Pink purple
      case PhenomenonType.other:
        return AppColors.accent;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month}.${date.day}';
  }
}
