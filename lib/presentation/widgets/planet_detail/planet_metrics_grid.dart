import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/celestial_body.dart';
import 'common/metric_cell.dart';
import 'common/number_formatter.dart';

/// 2x3 metrics grid for planet detail screens
/// Displays planet metrics: diameter, distance, orbital/rotation periods, mass, gravity
class PlanetMetricsGrid extends StatelessWidget {
  final Planet planet;

  const PlanetMetricsGrid({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: MetricCell(
                  value: '${NumberFormatter.format(planet.diameter)} km',
                  label: '지름',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: '${planet.distanceFromSun} AU',
                  label: '태양 거리',
                  borderRight: false,
                  borderBottom: true,
                ),
              ),
            ],
          ),
          // Row 2
          Row(
            children: [
              Expanded(
                child: MetricCell(
                  value: '${NumberFormatter.format(planet.orbitalPeriod)}일',
                  label: '공전주기',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: '${NumberFormatter.format(planet.rotationPeriod)}h',
                  label: '자전주기',
                  borderRight: false,
                  borderBottom: true,
                ),
              ),
            ],
          ),
          // Row 3
          Row(
            children: [
              Expanded(
                child: MetricCell(
                  value: '${planet.mass}⊕',
                  label: '질량',
                  borderRight: true,
                  borderBottom: false,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: '${planet.gravity}m/s²',
                  label: '중력',
                  borderRight: false,
                  borderBottom: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
