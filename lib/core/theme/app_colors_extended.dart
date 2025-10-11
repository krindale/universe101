import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Extended color palette with ChainGPT Labs-inspired futuristic space-tech colors
/// This extends the base AppColors with additional neon accents and tech-inspired colors
class AppColorsExtended {
  AppColorsExtended._();

  // ========== ChainGPT Labs Inspired Colors ==========

  /// Darker space purple - enhanced depth
  static const Color deepSpacePurple = Color(0xFF1A0B2E);

  /// Void black - darkest background
  static const Color voidBlack = Color(0xFF0D0221);

  /// Dark nebula - deeper purple tones
  static const Color darkNebula = Color(0xFF2D1B4E);

  /// Cosmic cyan - vibrant tech accent
  static const Color cosmicCyan = Color(0xFF00FFFF);

  /// Electric cyan - bright highlights
  static const Color electricCyan = Color(0xFF00D9FF);

  /// Neon orange - bright tech accent
  static const Color neonOrange = Color(0xFFFF6B35);

  /// Tech purple - for UI elements
  static const Color techPurple = Color(0xFF8B7FFF);

  /// Plasma pink - for energy effects
  static const Color plasmaPink = Color(0xFFFF10F0);

  // ========== Enhanced Glassmorphism ==========

  /// Neon glow border - cyan
  static const Color neonGlowCyan = Color(0x66FFFFFF);

  /// Neon glow border - orange
  static const Color neonGlowOrange = Color(0x66FF6B35);

  /// Angular glass - for sharp edges
  static const Color glassAngular = Color(0x1FFFFFFF);

  /// Glass with cyan tint
  static const Color glassCyanTint = Color(0x1A00FFFF);

  /// Glass with orange tint
  static const Color glassOrangeTint = Color(0x1AFF6B35);

  // ========== ChainGPT Style Gradients ==========

  /// Deep space gradient - darker, more dramatic
  static const LinearGradient deepSpaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      voidBlack,           // Void black
      deepSpacePurple,     // Deep space purple
      darkNebula,          // Dark nebula
    ],
  );

  /// Tech gradient - cyan to orange (ChainGPT style)
  static const LinearGradient techGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      cosmicCyan,             // Cosmic cyan
      Color(0xFF4A90E2),      // Cosmic blue
      neonOrange,             // Neon orange
    ],
  );

  /// Electric gradient - for glowing effects
  static const LinearGradient electricGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      cosmicCyan,          // Cosmic cyan
      electricCyan,        // Electric cyan
      Color(0xFF4A90E2),   // Cosmic blue
    ],
  );

  /// Neon glow gradient - for borders and highlights
  static const LinearGradient neonGlowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      cosmicCyan,     // Cosmic cyan
      neonOrange,     // Neon orange
    ],
  );

  /// Plasma gradient - for energy effects
  static const LinearGradient plasmaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      plasmaPink,      // Plasma pink
      techPurple,      // Tech purple
      cosmicCyan,      // Cosmic cyan
    ],
  );

  /// Holographic gradient - for special UI elements
  static const LinearGradient holographicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
    colors: [
      cosmicCyan,
      techPurple,
      plasmaPink,
      neonOrange,
      cosmicCyan,
    ],
  );

  // ========== Text Colors (Extended) ==========

  /// Neon text - cyan
  static const Color textNeonCyan = cosmicCyan;

  /// Neon text - orange
  static const Color textNeonOrange = neonOrange;

  /// Tech text - purple
  static const Color textTechPurple = techPurple;

  /// Glow text - for highlighted text
  static const Color textGlow = electricCyan;

  // ========== Interactive States (Enhanced with Glow) ==========

  /// Hover glow - cyan
  static const Color hoverGlowCyan = Color(0x3300FFFF);

  /// Hover glow - orange
  static const Color hoverGlowOrange = Color(0x33FF6B35);

  /// Focus glow - neon effect
  static const Color focusGlow = Color(0x4D00FFFF);

  /// Active glow - for active elements
  static const Color activeGlow = Color(0x6600FFFF);

  // ========== Particle & Effect Colors ==========

  /// Particle cyan - for tech particles
  static const Color particleCyan = cosmicCyan;

  /// Particle orange - for energy particles
  static const Color particleOrange = neonOrange;

  /// Particle purple - for nebula particles
  static const Color particlePurple = techPurple;

  /// Particle pink - for plasma particles
  static const Color particlePink = plasmaPink;

  /// Constellation line color
  static const Color constellationLine = Color(0x3300FFFF);

  /// Constellation node color
  static const Color constellationNode = Color(0x6600FFFF);

  /// Starfield particle
  static const Color starfieldParticle = Color(0xFFFFFFFF);

  /// Nebula particle
  static const Color nebulaParticle = Color(0x66FF6B35);

  // ========== Surface Colors (Extended) ==========

  /// Dark overlay - deeper
  static const Color darkOverlay = Color(0xDD0D0221);

  /// Tech surface - with cyan tint
  static const Color techSurface = glassCyanTint;

  /// Energy surface - with orange tint
  static const Color energySurface = glassOrangeTint;

  // ========== Helper Methods ==========

  /// Get neon glow color with opacity
  static Color getNeonGlow(Color color, {double opacity = 0.4}) {
    return color.withValues(alpha: opacity);
  }

  /// Get shadow color for glow effects
  static List<BoxShadow> getNeonGlowShadow({
    Color color = cosmicCyan,
    double blurRadius = 20,
    double spreadRadius = 2,
    double opacity = 0.5,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: opacity),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        color: color.withValues(alpha: opacity * 0.6),
        blurRadius: blurRadius * 1.5,
        spreadRadius: spreadRadius * 1.5,
      ),
      BoxShadow(
        color: color.withValues(alpha: opacity * 0.3),
        blurRadius: blurRadius * 2,
        spreadRadius: spreadRadius * 2,
      ),
    ];
  }

  /// Get angular glassmorphism decoration
  static BoxDecoration getAngularGlassDecoration({
    Color? surfaceColor,
    Color? borderColor,
    double borderWidth = 1,
    bool withGlow = false,
    Color? glowColor,
  }) {
    return BoxDecoration(
      color: surfaceColor ?? glassAngular,
      border: Border.all(
        color: borderColor ?? neonGlowCyan,
        width: borderWidth,
      ),
      boxShadow: withGlow
          ? getNeonGlowShadow(
              color: glowColor ?? cosmicCyan,
              blurRadius: 15,
              spreadRadius: 1,
            )
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

  /// Get tech border with gradient
  static BoxDecoration getTechBorderDecoration({
    Gradient? borderGradient,
    double borderWidth = 2,
    bool withGlow = true,
  }) {
    return BoxDecoration(
      gradient: borderGradient ?? techGradient,
      boxShadow: withGlow ? getNeonGlowShadow() : null,
    );
  }
}
