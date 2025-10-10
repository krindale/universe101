import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'home_screen.dart';
import 'solar_system_screen.dart';
import 'phenomena_screen.dart';
import 'exploration_screen.dart';
import 'favorites_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SolarSystemScreen(),
    PhenomenaScreen(),
    ExplorationScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.deepSpace.withValues(alpha: 0.9),
              AppColors.deepSpace,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.nebulaPurple.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home,
                  label: '홈',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.public,
                  label: '태양계',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.auto_awesome,
                  label: '현상',
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.rocket_launch,
                  label: '탐사',
                ),
                _buildNavItem(
                  index: 4,
                  icon: Icons.star,
                  label: '즐겨찾기',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            AppColors.nebulaPurple.withValues(alpha: 0.3),
                            AppColors.cosmicBlue.withValues(alpha: 0.3),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.nebulaPurple.withValues(alpha: 0.5),
                          width: 1,
                        )
                      : null,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? AppColors.stardustGold
                      : AppColors.textSecondary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected
                      ? AppColors.stardustGold
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
