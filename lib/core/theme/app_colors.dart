import 'package:flutter/material.dart';

/// ChainGPT Labs-inspired design system
/// Light theme with white cards, gray borders, and orange accents
class AppColors {
  AppColors._();

  // ========== Background Colors (ChainGPT Labs Style) ==========

  /// Light gray background - main app background
  static const Color background = Color(0xFFF5F5F5);

  /// Off-white background - alternative
  static const Color backgroundAlt = Color(0xFFFAFAFA);

  /// Deep space - for backwards compatibility (now same as background)
  static const Color deepSpace = Color(0xFFF5F5F5);

  // ========== Primary Colors ==========

  /// Dark Gray - primary accent (ChainGPT Labs style)
  static const Color accent = Color(0xFF4A4A4A);

  /// Dark Gray hover state
  static const Color accentHover = Color(0xFF5A5A5A);

  /// Dark Gray pressed state
  static const Color accentPressed = Color(0xFF3A3A3A);

  // ========== Card & Surface Colors ==========

  /// White card surface
  static const Color cardSurface = Color(0xFFFFFFFF);

  /// Glass surface - white with subtle transparency
  static const Color glassSurface = Color(0xFFFFFFFF);

  /// Strong glass for elevated cards
  static const Color glassStrong = Color(0xFFFFFFFF);

  /// Subtle glass for backgrounds
  static const Color glassSubtle = Color(0xFFFAFAFA);

  /// Elevated surface
  static const Color elevatedSurface = Color(0xFFFFFFFF);

  // ========== Border Colors ==========

  /// Primary border - light gray
  static const Color borderPrimary = Color(0xFFE0E0E0);

  /// Secondary border - lighter gray
  static const Color borderSecondary = Color(0xFFEEEEEE);

  /// Subtle border - very light gray
  static const Color borderSubtle = Color(0xFFF5F5F5);

  /// Glass border - for backwards compatibility
  static const Color glassBorder = Color(0xFFE0E0E0);

  /// Dark Gray border (for special cases only)
  static const Color borderAccent = Color(0xFF4A4A4A);

  // ========== Text Colors ==========

  /// Primary text - black
  static const Color textPrimary = Color(0xFF000000);

  /// Secondary text - medium gray
  static const Color textSecondary = Color(0xFF666666);

  /// Tertiary text - light gray
  static const Color textTertiary = Color(0xFF999999);

  /// Disabled text
  static const Color textDisabled = Color(0xFFCCCCCC);

  /// Accent text - dark gray (use sparingly)
  static const Color textAccent = Color(0xFF4A4A4A);

  // ========== Planet Colors (Kept for backwards compatibility) ==========

  static const Color mercuryGray = Color(0xFF8C8C8C);
  static const Color venusYellow = Color(0xFFFFC107);
  static const Color earthBlue = Color(0xFF2196F3);
  static const Color marsRed = Color(0xFFE53935);
  static const Color jupiterOrange = Color(0xFFFF9800);
  static const Color saturnBeige = Color(0xFFFFE082);
  static const Color uranusCyan = Color(0xFF00BCD4);
  static const Color neptuneBlue = Color(0xFF3F51B5);
  static const Color moonGray = Color(0xFFBDBDBD);
  static const Color sunYellow = Color(0xFFFDD835);

  // ========== Semantic Colors ==========

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF42A5F5);

  // ========== Interactive States ==========

  /// Hover state - very subtle gray
  static const Color hoverState = Color(0xFFFAFAFA);

  /// Pressed state - light gray
  static const Color pressedState = Color(0xFFF0F0F0);

  /// Focus state - dark gray outline
  static const Color focusState = Color(0xFF4A4A4A);

  /// Disabled state
  static const Color disabledState = Color(0xFFF5F5F5);

  // ========== Overlay ==========

  /// Overlay background - semi-transparent white
  static const Color overlayBackground = Color(0xF2FFFFFF);

  // ========== DEPRECATED Colors (for migration) ==========

  @Deprecated('Use accent instead')
  static const Color solarOrange = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color stardustGold = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color nebulaPurple = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color cosmicBlue = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color galaxyPurple = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color cosmicPink = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color auroraGreen = Color(0xFF4A4A4A);

  @Deprecated('Use accent instead')
  static const Color supernovaRed = Color(0xFF4A4A4A);

  @Deprecated('No gradients in ChainGPT style')
  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), Color(0xFFF5F5F5)],
  );

  @Deprecated('No gradients in ChainGPT style')
  static const LinearGradient nebulaGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), Color(0xFFF5F5F5)],
  );

  @Deprecated('No gradients in ChainGPT style')
  static const LinearGradient auroraGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), Color(0xFFF5F5F5)],
  );

  // ========== Helper Methods ==========

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Get minimal shadow (ChainGPT style - very subtle)
  static List<BoxShadow> getMinimalShadow({
    Color? color,
    double opacity = 0.05,
  }) {
    return [
      BoxShadow(
        color: (color ?? const Color(0xFF000000)).withValues(alpha: opacity),
        blurRadius: 4,
        spreadRadius: 0,
        offset: const Offset(0, 1),
      ),
    ];
  }

  /// Get angular card decoration (ChainGPT style)
  static BoxDecoration getAngularCard({
    Color? backgroundColor,
    Color? borderColor,
    double borderWidth = 1,
    bool withShadow = true,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? cardSurface,
      border: Border.all(
        color: borderColor ?? borderPrimary,
        width: borderWidth,
      ),
      boxShadow: withShadow ? getMinimalShadow() : null,
    );
  }

  /// Get glass surface color (backwards compatibility)
  static Color getGlassSurface({double opacity = 1.0}) {
    return cardSurface.withValues(alpha: opacity);
  }
}
