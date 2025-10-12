import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Extended color palette with ChainGPT Labs-inspired futuristic space-tech colors
/// This extends the base AppColors with additional neon accents and tech-inspired colors
class AppColorsExtended {
  AppColorsExtended._();

  // ========== ChainGPT Labs Exact Colors ==========

  /// Primary accent - ChainGPT orange
  static const Color chainGPTOrange = Color(0xFFFF7120);

  /// Pure black - primary background
  static const Color pureBlack = Color(0xFF000000);

  /// Pure white - primary text and highlights
  static const Color pureWhite = Color(0xFFFFFFFF);

  /// Neutral gray - secondary text
  static const Color neutralGray = Color(0xFF9E9E9E);

  /// Light gray - subtle backgrounds
  static const Color lightGray = Color(0xFFF6F6F6);

  /// Border accent - orange with transparency
  static const Color borderAccent = Color(0xFFC15727);

  /// Shadow subtle - for depth
  static const Color shadowSubtle = Color(0x24787878);

  // ========== Space Theme Enhancement Colors ==========

  /// Deep space purple - for cosmic depth
  static const Color deepSpacePurple = Color(0xFF1A0B2E);

  /// Dark nebula - deeper purple tones
  static const Color darkNebula = Color(0xFF2D1B4E);

  /// Cosmic cyan - vibrant tech accent (secondary)
  static const Color cosmicCyan = Color(0xFF00D9FF);

  /// Tech purple - for UI elements
  static const Color techPurple = Color(0xFF8B7FFF);

  // ========== Enhanced Glassmorphism ==========

  /// Glass background - with white tint
  static const Color glassBackground = Color(0x1AFFFFFF);

  /// Glass border - orange accent
  static const Color glassBorderOrange = Color(0x66FF7120);

  /// Glass border - cyan accent
  static const Color glassBorderCyan = Color(0x6600D9FF);

  /// Angular glass - for sharp edges
  static const Color glassAngular = Color(0x1FFFFFFF);

  /// Glass with subtle tint
  static const Color glassSubtle = Color(0x0DFFFFFF);

  // ========== ChainGPT Style Gradients ==========

  /// Deep space gradient - darker, more dramatic
  static const LinearGradient deepSpaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      pureBlack,           // Pure black
      deepSpacePurple,     // Deep space purple
      darkNebula,          // Dark nebula
    ],
  );

  /// Primary gradient - black to orange (ChainGPT style)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      pureBlack,           // Pure black
      Color(0xFF1A0D05),   // Dark orange tint
      chainGPTOrange,      // ChainGPT orange
    ],
  );

  /// Tech gradient - cyan to orange
  static const LinearGradient techGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      cosmicCyan,          // Cosmic cyan
      techPurple,          // Tech purple
      chainGPTOrange,      // ChainGPT orange
    ],
  );

  /// Subtle gradient - for backgrounds
  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      pureBlack,           // Pure black
      Color(0xFF0A0A0A),   // Very dark gray
      pureBlack,           // Pure black
    ],
  );

  /// Border gradient - orange accent
  static const LinearGradient borderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      borderAccent,        // Border accent
      chainGPTOrange,      // ChainGPT orange
      borderAccent,        // Border accent
    ],
  );

  // ========== Text Colors (Extended) ==========

  /// Primary text - pure white
  static const Color textPrimary = pureWhite;

  /// Secondary text - neutral gray
  static const Color textSecondary = neutralGray;

  /// Accent text - ChainGPT orange
  static const Color textAccent = chainGPTOrange;

  /// Highlight text - cosmic cyan
  static const Color textHighlight = cosmicCyan;

  // ========== Interactive States ==========

  /// Hover state - orange glow
  static const Color hoverOrange = Color(0x33FF7120);

  /// Hover state - cyan glow
  static const Color hoverCyan = Color(0x3300D9FF);

  /// Active state - bright orange
  static const Color activeOrange = Color(0x66FF7120);

  /// Focus state - bright outline
  static const Color focusOutline = Color(0xFFFF7120);

  // ========== Particle & Effect Colors ==========

  /// Particle orange - primary accent particles
  static const Color particleOrange = chainGPTOrange;

  /// Particle cyan - secondary accent particles
  static const Color particleCyan = cosmicCyan;

  /// Particle white - starfield particles
  static const Color particleWhite = pureWhite;

  /// Particle purple - nebula particles
  static const Color particlePurple = techPurple;

  /// Constellation line color
  static const Color constellationLine = Color(0x33FF7120);

  /// Constellation node color
  static const Color constellationNode = Color(0x66FF7120);

  /// Starfield particle
  static const Color starfieldParticle = pureWhite;

  /// Glow particle - for effects
  static const Color glowParticle = Color(0x66FF7120);

  // ========== Surface Colors (Extended) ==========

  /// Dark overlay - semi-transparent black
  static const Color darkOverlay = Color(0xDD000000);

  /// Card surface - subtle white tint
  static const Color cardSurface = Color(0x0DFFFFFF);

  /// Panel surface - slightly brighter
  static const Color panelSurface = Color(0x1AFFFFFF);

  // ========== Helper Methods ==========

  /// Get color with opacity
  static Color withOpacity(Color color, {double opacity = 0.4}) {
    return color.withValues(alpha: opacity);
  }

  /// Get subtle shadow effects (ChainGPT style - minimal and elegant)
  static List<BoxShadow> getGlowShadow({
    Color color = chainGPTOrange,
    double blurRadius = 8,
    double spreadRadius = 0,
    double opacity = 0.2,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: opacity),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        offset: const Offset(0, 2),
      ),
    ];
  }

  /// Get angular glassmorphism decoration with sharp borders (ChainGPT style)
  static BoxDecoration getAngularGlassDecoration({
    Color? surfaceColor,
    Color? borderColor,
    double borderWidth = 1,
    double borderRadius = 0, // 0 for sharp angular borders (ChainGPT default)
    bool withGlow = false,
    Color? glowColor,
  }) {
    return BoxDecoration(
      color: surfaceColor ?? glassAngular,
      // Sharp corners by default - ChainGPT style
      borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
      border: Border.all(
        color: borderColor ?? chainGPTOrange, // Changed to orange
        width: borderWidth,
      ),
      // Subtle shadows only - minimal like ChainGPT
      boxShadow: withGlow
          ? [
              BoxShadow(
                color: (glowColor ?? chainGPTOrange).withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ]
          : null,
    );
  }

  /// Get hexagonal clip path (for angular shapes)
  static Path getHexagonalPath(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    final radius = (width < height ? width : height) / 2;

    // Create hexagon
    for (int i = 0; i < 6; i++) {
      final angle = (60 * i - 30) * math.pi / 180;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  /// Get tech border decoration with angular style
  static BoxDecoration getTechBorderDecoration({
    Gradient? borderGradient,
    double borderWidth = 2,
    double borderRadius = 0, // Angular by default
    bool withGlow = true,
  }) {
    return BoxDecoration(
      gradient: borderGradient ?? borderGradient,
      borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
      boxShadow: withGlow ? getGlowShadow() : null,
    );
  }
}
