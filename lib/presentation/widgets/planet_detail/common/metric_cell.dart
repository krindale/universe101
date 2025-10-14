import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Individual metric cell for planet metrics grid
/// Displays a value-label pair with configurable borders
class MetricCell extends StatelessWidget {
  final String value;
  final String label;
  final bool borderRight;
  final bool borderBottom;

  const MetricCell({
    super.key,
    required this.value,
    required this.label,
    required this.borderRight,
    required this.borderBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        border: Border(
          right: borderRight
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
          bottom: borderBottom
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
