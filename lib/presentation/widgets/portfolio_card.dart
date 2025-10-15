import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Portfolio-style card widget inspired by ChainGPT Labs design
/// Horizontal scrollable cards with rich content
class PortfolioCard extends StatelessWidget {
  final String tag;
  final Widget icon;
  final String title;
  final String subtitle;
  final String description;
  final List<MetricData> metrics;
  final VoidCallback? onTap;
  final Color? accentColor;

  const PortfolioCard({
    super.key,
    required this.tag,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.metrics,
    this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.88;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          border: Border.all(color: AppColors.borderPrimary, width: 1),
          boxShadow: AppColors.getMinimalShadow(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tag at top
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderPrimary, width: 1),
                ),
                child: Text(
                  tag,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            // Centered Icon and Title section
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with background
                    SizedBox(height: 100, child: icon),
                    const SizedBox(height: 20),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        title,
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        subtitle,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        description,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Metrics Grid at bottom
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.borderPrimary, width: 1),
                ),
              ),
              child: Row(
                children: [
                  // Metrics Grid (2x3)
                  Expanded(
                    child: Column(
                      children: [
                        // Row 1
                        Row(
                          children: [
                            Expanded(
                              child: _MetricCell(
                                label: metrics[0].label,
                                value: metrics[0].value,
                                borderRight: true,
                                borderBottom: true,
                              ),
                            ),
                            Expanded(
                              child: _MetricCell(
                                label: metrics[1].label,
                                value: metrics[1].value,
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
                              child: _MetricCell(
                                label: metrics[2].label,
                                value: metrics[2].value,
                                borderRight: true,
                                borderBottom: true,
                              ),
                            ),
                            Expanded(
                              child: _MetricCell(
                                label: metrics[3].label,
                                value: metrics[3].value,
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
                              child: _MetricCell(
                                label: metrics[4].label,
                                value: metrics[4].value,
                                borderRight: true,
                                borderBottom: false,
                              ),
                            ),
                            Expanded(
                              child: _MetricCell(
                                label: metrics[5].label,
                                value: metrics[5].value,
                                borderRight: false,
                                borderBottom: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Arrow button (2/3 width = 47px)
                  Container(
                    width: 47,
                    height: 210,
                    decoration: BoxDecoration(
                      color: accentColor ?? AppColors.accent,
                      border: Border(
                        left: BorderSide(
                          color: AppColors.borderPrimary,
                          width: 1,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MetricData {
  final String label;
  final String value;

  const MetricData({required this.label, required this.value});
}

class _MetricCell extends StatelessWidget {
  final String label;
  final String value;
  final bool borderRight;
  final bool borderBottom;

  const _MetricCell({
    required this.label,
    required this.value,
    required this.borderRight,
    required this.borderBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          right: borderRight
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
          bottom: borderBottom
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
