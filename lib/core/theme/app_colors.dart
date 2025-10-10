import 'package:flutter/material.dart';

/// Cosmic-themed color palette for Universe101 app
/// Implements 2025 design trends: Dark Mode + Glassmorphism
class AppColors {
  AppColors._();

  // ========== Primary Cosmic Colors ==========

  /// Deep space black - main background
  static const Color deepSpace = Color(0xFF0A0E27);

  /// Nebula purple - primary accent
  static const Color nebulaPurple = Color(0xFF6C63FF);

  /// Cosmic blue - secondary accent
  static const Color cosmicBlue = Color(0xFF4A90E2);

  /// Stardust gold - highlights and CTAs
  static const Color stardustGold = Color(0xFFFFD700);

  /// Aurora green - success states
  static const Color auroraGreen = Color(0xFF00FFA3);

  /// Solar orange - warnings
  static const Color solarOrange = Color(0xFFFF6B35);

  /// Supernova red - errors
  static const Color supernovaRed = Color(0xFFFF2E63);

  // ========== Glassmorphism Colors ==========

  /// Glass surface with blur effect
  static const Color glassSurface = Color(0x1AFFFFFF);

  /// Glass border
  static const Color glassBorder = Color(0x33FFFFFF);

  /// Strong glass for elevated cards
  static const Color glassStrong = Color(0x26FFFFFF);

  /// Subtle glass for backgrounds
  static const Color glassSubtle = Color(0x0DFFFFFF);

  // ========== Gradient Colors ==========

  /// Cosmic gradient - used for backgrounds
  static const LinearGradient cosmicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A0E27), // Deep space
      Color(0xFF1A1F3A), // Mid space
      Color(0xFF2D1B4E), // Purple nebula
    ],
  );

  /// Nebula gradient - used for cards and surfaces
  static const LinearGradient nebulaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6C63FF), // Nebula purple
      Color(0xFF4A90E2), // Cosmic blue
    ],
  );

  /// Aurora gradient - used for special effects
  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00FFA3), // Aurora green
      Color(0xFF4A90E2), // Cosmic blue
      Color(0xFF6C63FF), // Nebula purple
    ],
  );

  // ========== Text Colors ==========

  /// Primary text color (white)
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Secondary text color (light gray)
  static const Color textSecondary = Color(0xFFB0B0B0);

  /// Tertiary text color (medium gray)
  static const Color textTertiary = Color(0xFF808080);

  /// Disabled text color
  static const Color textDisabled = Color(0xFF4D4D4D);

  // ========== Surface Colors ==========

  /// Card surface with glassmorphism
  static const Color cardSurface = Color(0x1AFFFFFF);

  /// Elevated surface
  static const Color elevatedSurface = Color(0x26FFFFFF);

  /// Overlay background
  static const Color overlayBackground = Color(0xCC0A0E27);

  // ========== Semantic Colors ==========

  /// Success color
  static const Color success = auroraGreen;

  /// Warning color
  static const Color warning = solarOrange;

  /// Error color
  static const Color error = supernovaRed;

  /// Info color
  static const Color info = cosmicBlue;

  // ========== Interactive States ==========

  /// Hover state
  static const Color hoverState = Color(0x1AFFFFFF);

  /// Pressed state
  static const Color pressedState = Color(0x33FFFFFF);

  /// Focus state
  static const Color focusState = Color(0x26FFFFFF);

  /// Disabled state
  static const Color disabledState = Color(0x0D808080);

  // ========== Helper Methods ==========

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Get glassmorphism surface color
  static Color getGlassSurface({double opacity = 0.1}) {
    return const Color(0xFFFFFFFF).withValues(alpha: opacity);
  }
}
