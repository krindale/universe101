import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        animated: true,
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
                  '즐겨찾기',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.stardustGold, AppColors.nebulaPurple],
                    ),
                  ),
                ),
              ),
            ),

            // Empty State
            SliverFillRemaining(
              child: Center(
                child: GlassCardSubtle(
                  margin: const EdgeInsets.all(AppSpacing.marginLG),
                  padding: const EdgeInsets.all(AppSpacing.paddingXL),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_border,
                        size: 80,
                        color: AppColors.stardustGold,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        '즐겨찾기가 없습니다',
                        style: AppTypography.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '관심 있는 행성, 현상, 탐사 미션을\n즐겨찾기에 추가해보세요',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
