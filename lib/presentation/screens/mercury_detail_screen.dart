import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_colors_extended.dart';
import '../../core/theme/app_typography.dart';
import '../../data/datasources/solar_system_data.dart';
import '../../domain/entities/celestial_body.dart';

/// Mercury detail screen with horizontal paging
/// Matches ChainGPT Labs design system
class MercuryDetailScreen extends StatefulWidget {
  const MercuryDetailScreen({super.key});

  @override
  State<MercuryDetailScreen> createState() => _MercuryDetailScreenState();
}

class _MercuryDetailScreenState extends State<MercuryDetailScreen> {
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
    final mercury = SolarSystemData.getAllPlanets().first;
    final totalPages = 2 + mercury.facts.length + mercury.episodes.length;

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
                return _buildPage(mercury, index);
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
    final mercury = SolarSystemData.getAllPlanets().first;
    final factsCount = mercury.facts.length;

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

  Widget _buildPage(Planet planet, int index) {
    // Page 0: Overview
    if (index == 0) {
      return _buildOverviewCard(planet);
    }
    // Page 1: Description
    else if (index == 1) {
      return _buildDescriptionCard(planet);
    }
    // Pages 2-15: Facts (14 facts)
    else if (index < 2 + planet.facts.length) {
      final factIndex = index - 2;
      final factEntry = planet.facts.entries.elementAt(factIndex);
      return _buildFactCard(factEntry.key, factEntry.value);
    }
    // Pages 16-30: Episodes (15 episodes)
    else {
      final episodeIndex = index - 2 - planet.facts.length;
      return _buildEpisodeCard(planet.episodes[episodeIndex], episodeIndex);
    }
  }

  /// Overview card with metrics
  Widget _buildOverviewCard(Planet planet) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 56, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [_buildTag('Rocky Planet')],
                  ),
                  const SizedBox(height: 32),

                  // Planet icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsExtended.chainGPTOrange,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.public,
                        size: 64,
                        color: AppColorsExtended.chainGPTOrange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),

                  // Planet name
                  Text(
                    planet.name,
                    style: AppTypography.headlineLarge.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),

                  // Metrics grid (2x3)
                  _buildMetricsGrid(planet),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right) - Reference style
            Positioned(
              right: 24,
              bottom: 24,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColorsExtended.chainGPTOrange,
                  border: Border(
                    left: BorderSide(color: AppColors.borderPrimary, width: 1),
                    top: BorderSide(color: AppColors.borderPrimary, width: 1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Metrics grid - 2x3 layout (PortfolioCard style)
  Widget _buildMetricsGrid(Planet planet) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Column(
        children: [
          // Row 1
          Row(
            children: [
              Expanded(
                child: _buildMetricCell(
                  '${_formatNumber(planet.diameter)} km',
                  '지름',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: _buildMetricCell(
                  '${planet.distanceFromSun} AU',
                  '태양 거리',
                  borderRight: false,
                  borderBottom: true,
                ),
              ),
            ],
          ),
          // Row 2
          Row(
            children: [
              Expanded(
                child: _buildMetricCell(
                  '${_formatNumber(planet.orbitalPeriod)}일',
                  '공전주기',
                  borderRight: true,
                  borderBottom: true,
                ),
              ),
              Expanded(
                child: _buildMetricCell(
                  '${_formatNumber(planet.rotationPeriod)}h',
                  '자전주기',
                  borderRight: false,
                  borderBottom: true,
                ),
              ),
            ],
          ),
          // Row 3
          Row(
            children: [
              Expanded(
                child: _buildMetricCell(
                  '${planet.mass}⊕',
                  '질량',
                  borderRight: true,
                  borderBottom: false,
                ),
              ),
              Expanded(
                child: _buildMetricCell(
                  '${planet.gravity}m/s²',
                  '중력',
                  borderRight: false,
                  borderBottom: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCell(
    String value,
    String label, {
    required bool borderRight,
    required bool borderBottom,
  }) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        border: Border(
          right: borderRight
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
          bottom: borderBottom
              ? BorderSide(color: AppColors.borderPrimary, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              fontSize: 10,
              color: AppColorsExtended.neutralGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Description card
  Widget _buildDescriptionCard(Planet planet) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 56, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  _buildTag('Planet Overview'),
                  const SizedBox(height: 32),

                  // Description icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColorsExtended.chainGPTOrange.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.description_outlined,
                      size: 36,
                      color: AppColorsExtended.chainGPTOrange,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    '행성 정보',
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    planet.description,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Info rows
                  _buildInfoRow('타입', planet.type.toString().split('.').last),
                  const SizedBox(height: 16),
                  _buildInfoRow('위성 수', '${planet.moons.length}개'),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right)
            Positioned(
              right: 24,
              bottom: 24,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColorsExtended.chainGPTOrange,
                  border: Border(
                    left: BorderSide(color: AppColors.borderPrimary, width: 1),
                    top: BorderSide(color: AppColors.borderPrimary, width: 1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Fact card
  Widget _buildFactCard(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 56, bottom: 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  _buildTag('Interesting Fact'),
                  const SizedBox(height: 32),

                  // Fact icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColorsExtended.chainGPTOrange.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: 36,
                      color: AppColorsExtended.chainGPTOrange,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Fact title
                  Text(
                    title,
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Fact content
                  Text(
                    content,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right)
            Positioned(
              right: 24,
              bottom: 24,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColorsExtended.chainGPTOrange,
                  border: Border(
                    left: BorderSide(color: AppColors.borderPrimary, width: 1),
                    top: BorderSide(color: AppColors.borderPrimary, width: 1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Episode card
  Widget _buildEpisodeCard(String episode, int index) {
    // Parse episode string format: "제목: 내용"
    final parts = episode.split(':');
    final title = parts.isNotEmpty ? parts[0].trim() : '에피소드';
    final content = parts.length > 1
        ? parts.sublist(1).join(':').trim()
        : episode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 48),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag
                  _buildTag('Historical Episode'),
                  const SizedBox(height: 32),

                  // Episode number badge
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColorsExtended.chainGPTOrange.withValues(
                        alpha: 0.1,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsExtended.chainGPTOrange,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTypography.headlineMedium.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColorsExtended.chainGPTOrange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Episode title
                  Text(
                    title,
                    style: AppTypography.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Episode content
                  Text(
                    content,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 15,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 80), // Space for arrow button
                ],
              ),
            ),

            // Arrow button (bottom right)
            Positioned(
              right: 24,
              bottom: 24,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColorsExtended.chainGPTOrange,
                  border: Border(
                    left: BorderSide(color: AppColors.borderPrimary, width: 1),
                    top: BorderSide(color: AppColors.borderPrimary, width: 1),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondary,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _formatNumber(double number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
