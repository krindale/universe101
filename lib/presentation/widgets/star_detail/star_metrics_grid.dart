import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/celestial_body.dart';
import '../planet_detail/common/metric_cell.dart';
import '../planet_detail/common/number_formatter.dart';

/// 2x3 metrics grid for star detail screens
/// Displays star metrics: diameter, mass, temperature, luminosity, age, spectral type
class StarMetricsGrid extends StatelessWidget {
  final Star star;

  const StarMetricsGrid({
    super.key,
    required this.star,
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
                  value: '${NumberFormatter.format(star.diameter)} km',
                  label: '지름',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: '${star.mass} M☉',
                  label: '질량',
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
                  value: '${NumberFormatter.format(star.surfaceTemperature)} K',
                  label: '표면 온도',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: '${star.luminosity} L☉',
                  label: '광도',
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
                  value: '${star.age}억년',
                  label: '나이',
                  borderRight: true,
                  borderBottom: false,
                ),
              ),
              Expanded(
                child: MetricCell(
                  value: star.spectralType,
                  label: '분광형',
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
