import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        animated: true,
        child: CustomScrollView(
          slivers: [
            // App Bar with Glassmorphism
            SliverAppBar(
              expandedHeight: 200,
              floating: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Universe101',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.nebulaGradient,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.rocket_launch,
                      size: AppSpacing.iconXXL,
                      color: AppColors.textPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Welcome Section
                  GlassCard(
                    margin: const EdgeInsets.only(bottom: AppSpacing.marginLG),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '우주를 탐험하세요',
                          style: AppTypography.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          '태양계, 우주 현상, 우주 탐사의 모든 것',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Category Cards
                  _buildCategoryCard(
                    context,
                    title: '태양계',
                    subtitle: '8개 행성과 태양 탐험',
                    icon: Icons.public,
                    gradient: AppColors.nebulaGradient,
                  ),
                  _buildCategoryCard(
                    context,
                    title: '우주 현상',
                    subtitle: '일식, 오로라, 초신성',
                    icon: Icons.auto_awesome,
                    gradient: AppColors.auroraGradient,
                  ),
                  _buildCategoryCard(
                    context,
                    title: '우주 탐사',
                    subtitle: '인류의 우주 도전 역사',
                    icon: Icons.rocket_launch,
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.solarOrange,
                        AppColors.stardustGold,
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Stats Section
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.star,
                          value: '8',
                          label: '행성',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.science,
                          value: '50+',
                          label: '현상',
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.rocket,
                          value: '100+',
                          label: '미션',
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
  }) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.marginMD),
      onTap: () {
        // TODO: Navigate to category screen
      },
      child: Row(
        children: [
          // Icon with gradient background
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            ),
            child: Icon(
              icon,
              size: AppSpacing.iconLG,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Arrow icon
          const Icon(
            Icons.arrow_forward_ios,
            size: AppSpacing.iconSM,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return GlassCardSubtle(
      padding: const EdgeInsets.all(AppSpacing.paddingMD),
      child: Column(
        children: [
          Icon(
            icon,
            size: AppSpacing.iconLG,
            color: AppColors.nebulaPurple,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.stardustGold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall,
          ),
        ],
      ),
    );
  }
}
