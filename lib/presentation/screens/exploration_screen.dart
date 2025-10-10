import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/datasources/database_helper.dart';
import '../../domain/entities/space_exploration.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';

class ExplorationScreen extends StatelessWidget {
  const ExplorationScreen({super.key});

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
                  '우주 탐사',
                  style: AppTypography.headlineMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.solarOrange, AppColors.cosmicBlue],
                    ),
                  ),
                ),
              ),
            ),

            // Exploration List
            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.paddingMD),
              sliver: FutureBuilder<List<SpaceExploration>>(
                future: databaseHelper.getAllExplorations(),
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

                  final explorations = snapshot.data ?? [];

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final exploration = explorations[index];
                        return _buildExplorationCard(context, exploration);
                      },
                      childCount: explorations.length,
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

  Widget _buildExplorationCard(BuildContext context, SpaceExploration exploration) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.marginMD),
      onTap: () {
        // TODO: Navigate to exploration detail
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Mission Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.solarOrange, AppColors.stardustGold],
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
                ),
                child: const Icon(
                  Icons.rocket_launch,
                  size: AppSpacing.iconLG,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Mission Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exploration.name,
                      style: AppTypography.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      exploration.agency,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Badge
              _buildStatusBadge(exploration.status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            exploration.description,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${exploration.launchDate.year}.${exploration.launchDate.month.toString().padLeft(2, '0')}.${exploration.launchDate.day.toString().padLeft(2, '0')}',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (exploration.destination != null) ...[
                const SizedBox(width: AppSpacing.md),
                const Icon(
                  Icons.place,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    exploration.destination!,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ExplorationStatus status) {
    Color badgeColor;
    String statusText;

    switch (status) {
      case ExplorationStatus.active:
        badgeColor = AppColors.cosmicBlue;
        statusText = '진행중';
        break;
      case ExplorationStatus.completed:
        badgeColor = AppColors.cosmicBlue;
        statusText = '완료';
        break;
      case ExplorationStatus.planned:
        badgeColor = AppColors.stardustGold;
        statusText = '계획';
        break;
      case ExplorationStatus.failed:
        badgeColor = AppColors.solarOrange;
        statusText = '실패';
        break;
      case ExplorationStatus.ongoing:
        badgeColor = AppColors.nebulaPurple;
        statusText = '진행';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        statusText,
        style: AppTypography.labelSmall.copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
