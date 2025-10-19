import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_colors_extended.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/cosmic_phenomenon.dart';
import '../widgets/phenomenon_detail/phenomenon_overview_card.dart';
import '../widgets/phenomenon_detail/phenomenon_description_card.dart';
import '../widgets/phenomenon_detail/phenomenon_fact_card.dart';
import '../widgets/phenomenon_detail/phenomenon_historical_card.dart';

/// Generic phenomenon detail screen with horizontal paging
/// Reusable for all cosmic phenomena - follows SOLID principles
/// Matches ChainGPT Labs design system
class PhenomenonDetailScreen extends StatefulWidget {
  final CosmicPhenomenon phenomenon;

  const PhenomenonDetailScreen({super.key, required this.phenomenon});

  @override
  State<PhenomenonDetailScreen> createState() => _PhenomenonDetailScreenState();
}

class _PhenomenonDetailScreenState extends State<PhenomenonDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// Get phenomenon-specific accent color based on type
  Color get phenomenonColor {
    switch (widget.phenomenon.type) {
      case PhenomenonType.atmospheric:
        return const Color(0xFF64B5F6); // Light blue
      case PhenomenonType.stellar:
        return const Color(0xFFFFD54F); // Yellow
      case PhenomenonType.gravitational:
        return const Color(0xFF9575CD); // Purple
      case PhenomenonType.orbital:
        return const Color(0xFF81C784); // Green
      case PhenomenonType.eclipse:
        return const Color(0xFF90A4AE); // Blue grey
      case PhenomenonType.aurora:
        return const Color(0xFF4DB6AC); // Teal
      case PhenomenonType.supernova:
        return AppColors.accent; // Orange
      case PhenomenonType.meteorShower:
        return const Color(0xFFFFB74D); // Light orange
      case PhenomenonType.comet:
        return const Color(0xFFA1887F); // Brown
      case PhenomenonType.transit:
        return const Color(0xFF7986CB); // Indigo
      case PhenomenonType.conjunction:
        return const Color(0xFFE57373); // Red
      case PhenomenonType.blackHole:
        return const Color(0xFF424242); // Dark grey
      case PhenomenonType.nebula:
        return const Color(0xFFBA68C8); // Pink purple
      case PhenomenonType.other:
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
    // Total pages: 2 (overview + description) + facts + episodes
    final totalPages = 2 + widget.phenomenon.facts.length + widget.phenomenon.episodes.length;

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
    final factsCount = widget.phenomenon.facts.length;
    final episodesCount = widget.phenomenon.episodes.length;

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
                    ? phenomenonColor
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
    final factsCount = widget.phenomenon.facts.length;

    // Page 0: Overview
    if (index == 0) {
      return PhenomenonOverviewCard(
        phenomenon: widget.phenomenon,
        accentColor: phenomenonColor,
      );
    }
    // Page 1: Description
    else if (index == 1) {
      return PhenomenonDescriptionCard(
        phenomenon: widget.phenomenon,
        accentColor: phenomenonColor,
      );
    }
    // Facts pages (dynamic count)
    else if (index < 2 + factsCount) {
      final factIndex = index - 2;
      final factEntry = widget.phenomenon.facts.entries.elementAt(factIndex);
      return PhenomenonFactCard(
        fact: factEntry,
        factIndex: factIndex,
        accentColor: phenomenonColor,
      );
    }
    // Episodes pages (dynamic count)
    else {
      final episodeIndex = index - 2 - factsCount;
      return PhenomenonHistoricalCard(
        episodes: widget.phenomenon.episodes,
        episodeIndex: episodeIndex,
        accentColor: phenomenonColor,
      );
    }
  }
}
