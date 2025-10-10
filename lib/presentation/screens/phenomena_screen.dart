import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/datasources/database_helper.dart';
import '../../domain/entities/cosmic_phenomenon.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';

class PhenomenaScreen extends StatelessWidget {
  const PhenomenaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();

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
                  '우주 현상',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.auroraGradient,
                  ),
                ),
              ),
            ),

            // Phenomena List
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              sliver: FutureBuilder<List<CosmicPhenomenon>>(
                future: databaseHelper.getAllPhenomena(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }

                  final phenomena = snapshot.data ?? [];

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final phenomenon = phenomena[index];
                        return _buildPhenomenonCard(context, phenomenon);
                      },
                      childCount: phenomena.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhenomenonCard(BuildContext context, CosmicPhenomenon phenomenon) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.marginMD),
      onTap: () {
        // TODO: Navigate to phenomenon detail
      },
      child: Row(
        children: [
          // Phenomenon Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.nebulaPurple, AppColors.cosmicBlue],
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: AppSpacing.iconXL,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Phenomenon Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phenomenon.name,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  phenomenon.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _buildRarityBadge(phenomenon.rarity),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      phenomenon.location,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Arrow
          const Icon(
            Icons.arrow_forward_ios,
            size: AppSpacing.iconSM,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildRarityBadge(int rarity) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.stardustGold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 12,
            color: AppColors.stardustGold,
          ),
          const SizedBox(width: 4),
          Text(
            '$rarity/10',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.stardustGold,
            ),
          ),
        ],
      ),
    );
  }
}
