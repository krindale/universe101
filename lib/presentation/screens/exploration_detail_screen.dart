import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_colors_extended.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/space_exploration.dart';
import '../widgets/exploration_detail/exploration_overview_card.dart';
import '../widgets/exploration_detail/exploration_details_card.dart';
import '../widgets/exploration_detail/exploration_achievement_card.dart';
import '../widgets/exploration_detail/exploration_significance_card.dart';

/// Generic exploration detail screen with horizontal paging
/// Reusable for all space exploration missions
class ExplorationDetailScreen extends StatefulWidget {
  final SpaceExploration exploration;

  const ExplorationDetailScreen({super.key, required this.exploration});

  @override
  State<ExplorationDetailScreen> createState() => _ExplorationDetailScreenState();
}

class _ExplorationDetailScreenState extends State<ExplorationDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// Get exploration-specific accent color based on type
  Color get explorationColor {
    switch (widget.exploration.type) {
      case ExplorationType.satellite:
        return const Color(0xFF42A5F5); // Blue
      case ExplorationType.probe:
        return const Color(0xFF66BB6A); // Green
      case ExplorationType.rover:
        return const Color(0xFFEF5350); // Red
      case ExplorationType.telescope:
        return const Color(0xFF9575CD); // Purple
      case ExplorationType.mannedMission:
        return AppColors.accent; // Orange
      case ExplorationType.unmannedMission:
        return const Color(0xFF26A69A); // Teal
      case ExplorationType.satelliteLaunch:
        return const Color(0xFF5C6BC0); // Indigo
      case ExplorationType.spaceStation:
        return const Color(0xFF78909C); // Blue grey
      case ExplorationType.lunarMission:
        return const Color(0xFFBDBDBD); // Grey
      case ExplorationType.marsMission:
        return const Color(0xFFFF7043); // Deep orange
      case ExplorationType.deepSpace:
        return const Color(0xFF7E57C2); // Deep purple
      case ExplorationType.other:
        return AppColors.accent;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Total pages: 2 (overview + details) + facts + episodes
    final totalPages = 2 + widget.exploration.facts.length + widget.exploration.episodes.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main paging content
            PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              itemBuilder: (context, index) {
                return _buildPage(index);
              },
            ),

            // Top overlay with back button and page indicator
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          border: Border.all(
                            color: AppColors.borderPrimary,
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                          size: 18,
                        ),
                      ),
                    ),

                    // Page indicator with section label
                    _buildPageIndicator(totalPages),

                    // Spacer to balance back button
                    const SizedBox(width: 36),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int totalPages) {
    final factsCount = widget.exploration.facts.length;
    final episodesCount = widget.exploration.episodes.length;

    // Determine current section and pages in that section
    String sectionLabel;
    int sectionStart;
    int sectionEnd;

    if (_currentPage == 0) {
      // Overview page
      sectionLabel = 'Overview';
      sectionStart = 0;
      sectionEnd = 1;
    } else if (_currentPage == 1) {
      // Details page
      sectionLabel = 'Details';
      sectionStart = 1;
      sectionEnd = 2;
    } else if (_currentPage < 2 + factsCount) {
      // Facts section (dynamic based on facts count)
      sectionLabel = 'Facts';
      sectionStart = 2;
      sectionEnd = 2 + factsCount;
    } else {
      // Episodes section (dynamic based on episodes count)
      sectionLabel = 'Episodes';
      sectionStart = 2 + factsCount;
      sectionEnd = totalPages;
    }

    final sectionPages = sectionEnd - sectionStart;
    final currentInSection = _currentPage - sectionStart;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section label
        Text(
          sectionLabel,
          style: AppTypography.labelSmall.copyWith(
            color: AppColorsExtended.neutralGray,
            fontSize: 9,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Section progress dots
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(sectionPages, (index) {
            final isActive = currentInSection == index;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: isActive ? 16 : 4,
              height: 4,
              decoration: BoxDecoration(
                color: isActive
                    ? explorationColor
                    : AppColorsExtended.neutralGray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPage(int index) {
    final factsCount = widget.exploration.facts.length;

    // Page 0: Overview
    if (index == 0) {
      return ExplorationOverviewCard(
        exploration: widget.exploration,
        accentColor: explorationColor,
      );
    }
    // Page 1: Details
    else if (index == 1) {
      return ExplorationDetailsCard(
        exploration: widget.exploration,
        accentColor: explorationColor,
      );
    }
    // Facts pages (dynamic count)
    else if (index < 2 + factsCount) {
      final factIndex = index - 2;
      final factEntry = widget.exploration.facts.entries.elementAt(factIndex);
      return ExplorationAchievementCard(
        achievement: factEntry,
        achievementIndex: factIndex,
        accentColor: explorationColor,
      );
    }
    // Episodes pages (dynamic count)
    else {
      final episodeIndex = index - 2 - factsCount;
      return ExplorationSignificanceCard(
        episodes: widget.exploration.episodes,
        episodeIndex: episodeIndex,
        accentColor: explorationColor,
      );
    }
  }
}
