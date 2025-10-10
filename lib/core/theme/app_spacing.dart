/// Spacing and sizing system for Universe101 app
/// Based on 8px grid system
class AppSpacing {
  AppSpacing._();

  // ========== Base Unit ==========
  static const double baseUnit = 8.0;

  // ========== Spacing Scale ==========
  static const double xs = baseUnit * 0.5; // 4px
  static const double sm = baseUnit; // 8px
  static const double md = baseUnit * 2; // 16px
  static const double lg = baseUnit * 3; // 24px
  static const double xl = baseUnit * 4; // 32px
  static const double xxl = baseUnit * 6; // 48px
  static const double xxxl = baseUnit * 8; // 64px

  // ========== Padding ==========
  static const double paddingXS = xs;
  static const double paddingSM = sm;
  static const double paddingMD = md;
  static const double paddingLG = lg;
  static const double paddingXL = xl;

  // ========== Margin ==========
  static const double marginXS = xs;
  static const double marginSM = sm;
  static const double marginMD = md;
  static const double marginLG = lg;
  static const double marginXL = xl;

  // ========== Border Radius ==========
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusFull = 9999.0;

  // ========== Icon Sizes ==========
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // ========== Button Heights ==========
  static const double buttonSM = 32.0;
  static const double buttonMD = 40.0;
  static const double buttonLG = 48.0;
  static const double buttonXL = 56.0;

  // ========== Card Sizes ==========
  static const double cardMinHeight = 120.0;
  static const double cardMediumHeight = 200.0;
  static const double cardLargeHeight = 300.0;

  // ========== Glassmorphism Blur ==========
  static const double blurSM = 10.0;
  static const double blurMD = 20.0;
  static const double blurLG = 30.0;
  static const double blurXL = 40.0;
}
