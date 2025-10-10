import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/celestial_body.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/planet_3d_viewer.dart';

class PlanetDetailScreen extends StatefulWidget {
  final Planet planet;

  const PlanetDetailScreen({
    super.key,
    required this.planet,
  });

  @override
  State<PlanetDetailScreen> createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CosmicBackground(
        animated: true,
        child: CustomScrollView(
          slivers: [
            // App Bar with 3D Model
            _buildAppBar(context),

            // Tab Bar
            _buildTabBar(),

            // Tab Content
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: AppColors.deepSpace,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.planet.name,
          style: AppTypography.headlineMedium.copyWith(
            color: AppColors.textPrimary,
            shadows: [
              Shadow(
                color: AppColors.deepSpace.withValues(alpha: 0.8),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.cosmicBlue,
                    AppColors.deepSpace,
                  ],
                ),
              ),
            ),

            // 3D Model Viewer
            if (widget.planet.modelUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Planet3DViewer(
                  modelUrl: widget.planet.modelUrl!,
                  planetName: widget.planet.name,
                  height: 340,
                  backgroundColor: Colors.transparent,
                ),
              )
            else
              // Fallback icon if no 3D model
              Center(
                child: Icon(
                  Icons.public,
                  size: 120,
                  color: AppColors.textPrimary.withValues(alpha: 0.3),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          controller: _tabController,
          indicatorColor: AppColors.stardustGold,
          labelColor: AppColors.stardustGold,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTypography.titleSmall,
          tabs: const [
            Tab(text: '정보'),
            Tab(text: '사실'),
            Tab(text: '에피소드'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildInfoTab(),
          _buildFactsTab(),
          _buildEpisodesTab(),
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('설명', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.planet.description,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Physical Characteristics
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('물리적 특성', style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.md),
                _buildInfoRow('지름', '${_formatNumber(widget.planet.diameter)} km'),
                _buildInfoRow('태양으로부터의 거리', '${widget.planet.distanceFromSun} AU'),
                _buildInfoRow('공전 주기', '${_formatNumber(widget.planet.orbitalPeriod)} 일'),
                _buildInfoRow('자전 주기', '${_formatNumber(widget.planet.rotationPeriod)} 시간'),
                _buildInfoRow('질량', '${widget.planet.mass} 지구 질량'),
                _buildInfoRow('중력', '${widget.planet.gravity} m/s²'),
                _buildInfoRow('구성', widget.planet.composition),
                _buildInfoRow('고리 유무', widget.planet.hasRings ? '있음' : '없음'),
                if (widget.planet.moons.isNotEmpty)
                  _buildInfoRow('위성 수', '${widget.planet.moons.length}개'),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Moons
          if (widget.planet.moons.isNotEmpty)
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주요 위성', style: AppTypography.titleMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: widget.planet.moons.map((moon) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMD,
                          vertical: AppSpacing.paddingSM,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.nebulaPurple.withValues(alpha: 0.3),
                              AppColors.cosmicBlue.withValues(alpha: 0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                          border: Border.all(
                            color: AppColors.nebulaPurple.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          moon,
                          style: AppTypography.bodySmall,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFactsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.paddingMD),
      child: Column(
        children: widget.planet.facts.entries.map((entry) {
          return GlassCard(
            margin: const EdgeInsets.only(bottom: AppSpacing.marginMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.stardustGold,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.stardustGold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  entry.value,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEpisodesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.paddingMD),
      child: Column(
        children: widget.planet.episodes.asMap().entries.map((entry) {
          final index = entry.key;
          final episode = entry.value;
          return GlassCard(
            margin: const EdgeInsets.only(bottom: AppSpacing.marginMD),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.nebulaPurple, AppColors.cosmicBlue],
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    episode,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.stardustGold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    }
    return number.toStringAsFixed(2);
  }
}

// Custom SliverPersistentHeaderDelegate for TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.deepSpace,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
