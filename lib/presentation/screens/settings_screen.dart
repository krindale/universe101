import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/providers/theme_provider.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        animated: false,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 150,
              floating: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  '설정',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.nebulaPurple, AppColors.cosmicBlue],
                    ),
                  ),
                ),
              ),
            ),

            // Settings List
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Theme Settings Section
                  _buildSectionHeader('화면 테마'),
                  _buildThemeToggle(context),
                  const SizedBox(height: AppSpacing.lg),

                  // About Section
                  _buildSectionHeader('앱 정보'),
                  _buildAboutCard(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.sm,
        bottom: AppSpacing.sm,
        top: AppSpacing.md,
      ),
      child: Text(
        title,
        style: AppTypography.titleMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GlassCard(
          child: Row(
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.nebulaPurple, AppColors.cosmicBlue],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                ),
                child: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '다크 모드',
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      themeProvider.isDarkMode ? '활성화됨' : '비활성화됨',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Switch
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
                activeTrackColor: AppColors.nebulaPurple,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.cosmicBlue,
                size: AppSpacing.iconLG,
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'Universe101',
                style: AppTypography.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '우주와 천문학을 탐험하는 교육용 앱입니다.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Version 1.0.0',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
