import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Reusable tag widget for planet detail screens
/// Displays a bordered label with consistent ChainGPT design system styling
class PlanetTag extends StatelessWidget {
  final String text;

  const PlanetTag({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
