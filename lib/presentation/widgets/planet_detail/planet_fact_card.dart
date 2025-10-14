import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'common/planet_tag.dart';

/// Fact card for planet detail screens
/// Displays individual interesting facts about planets
class PlanetFactCard extends StatelessWidget {
  final String title;
  final String content;
  final Color accentColor;
  final String? planetImageUrl;

  const PlanetFactCard({
    super.key,
    required this.title,
    required this.content,
    required this.accentColor,
    this.planetImageUrl,
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
        child: ClipRect(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background planet image
              if (planetImageUrl != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.2),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          planetImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                  ),
                ),

              // Content
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag
                    PlanetTag(text: 'Interesting Fact'),
                    const SizedBox(height: 32),

                    // Fact icon
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(
                          alpha: 0.1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        size: 36,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Fact title
                    Text(
                      title,
                      style: AppTypography.headlineMedium.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Fact content
                    Text(
                      content,
                      style: AppTypography.bodyMedium.copyWith(
                        fontSize: 15,
                        height: 1.6,
                        color: AppColors.textPrimary,
                      ),
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
      ),
    );
  }
}
