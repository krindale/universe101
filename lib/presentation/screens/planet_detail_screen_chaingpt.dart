import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_colors_extended.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/celestial_body.dart';
import '../widgets/planet_detail/planet_overview_card.dart';
import '../widgets/planet_detail/planet_description_card.dart';
import '../widgets/planet_detail/planet_fact_card.dart';
import '../widgets/planet_detail/planet_episode_card.dart';

/// Generic planet detail screen with horizontal paging
/// Reusable for all planets - follows SOLID principles
/// Matches ChainGPT Labs design system
class PlanetDetailScreenChainGPT extends StatefulWidget {
  final Planet planet;

  const PlanetDetailScreenChainGPT({
    super.key,
    required this.planet,
  });

  @override
  State<PlanetDetailScreenChainGPT> createState() => _PlanetDetailScreenChainGPTState();
}

class _PlanetDetailScreenChainGPTState extends State<PlanetDetailScreenChainGPT> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
    final totalPages = 2 + widget.planet.facts.length + widget.planet.episodes.length;

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
    final factsCount = widget.planet.facts.length;

    // Determine current section and pages in that section
    String sectionLabel;
    int sectionStart;
    int sectionEnd;

    if (_currentPage < 2) {
      // Overview section (pages 0-1)
      sectionLabel = 'Overview';
      sectionStart = 0;
      sectionEnd = 2;
    } else if (_currentPage < 2 + factsCount) {
      // Facts section (dynamic based on facts count)
      sectionLabel = 'Facts';
      sectionStart = 2;
      sectionEnd = 2 + factsCount;
    } else {
      // Episodes section (remaining pages)
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
        // Section progress dots (show all dots, no limit)
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
                    ? AppColorsExtended.chainGPTOrange
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
    // Page 0: Overview
    if (index == 0) {
      return PlanetOverviewCard(planet: widget.planet);
    }
    // Page 1: Description
    else if (index == 1) {
      return PlanetDescriptionCard(planet: widget.planet);
    }
    // Facts pages (dynamic count)
    else if (index < 2 + widget.planet.facts.length) {
      final factIndex = index - 2;
      final factEntry = widget.planet.facts.entries.elementAt(factIndex);
      return PlanetFactCard(
        title: factEntry.key,
        content: factEntry.value,
      );
    }
    // Episodes pages (remaining)
    else {
      final episodeIndex = index - 2 - widget.planet.facts.length;
      return PlanetEpisodeCard(
        episode: widget.planet.episodes[episodeIndex],
        index: episodeIndex,
      );
    }
  }
}
