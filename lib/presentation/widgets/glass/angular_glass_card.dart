import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_colors_extended.dart';

/// Angular glassmorphism card with sharp edges and neon glow
class AngularGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool enableGlow;
  final Color? glowColor;
  final double blurStrength;
  final bool clipEdges;

  const AngularGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.enableGlow = true,
    this.glowColor,
    this.blurStrength = 10.0,
    this.clipEdges = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColorsExtended.glassAngular,
        // Sharp corners - no border radius (ChainGPT style)
        border: Border.all(
          color: borderColor ?? AppColorsExtended.chainGPTOrange,
          width: borderWidth,
        ),
        // Minimal shadow (ChainGPT style)
        boxShadow: enableGlow
            ? AppColorsExtended.getGlowShadow(
                color: glowColor ?? AppColorsExtended.chainGPTOrange,
                blurRadius: 8,
                spreadRadius: 0,
                opacity: 0.2,
              )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Hexagonal glassmorphism card with tech aesthetic
class HexagonalGlassCard extends StatelessWidget {
  final Widget child;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool enableGlow;
  final Color? glowColor;

  const HexagonalGlassCard({
    super.key,
    required this.child,
    this.size = 120.0,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2.0,
    this.enableGlow = true,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HexagonPainter(
        backgroundColor: backgroundColor ?? AppColorsExtended.glassAngular,
        borderColor: borderColor ?? AppColorsExtended.chainGPTOrange,
        borderWidth: borderWidth,
        enableGlow: enableGlow,
        glowColor: glowColor ?? AppColorsExtended.chainGPTOrange,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size * 0.15),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Hexagon painter for custom hexagonal shapes
class HexagonPainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final bool enableGlow;
  final Color glowColor;

  HexagonPainter({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.enableGlow,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = AppColorsExtended.getHexagonalPath(size);

    // Draw glow
    if (enableGlow) {
      final glowPaint = Paint()
        ..color = glowColor.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth * 3;

      canvas.drawPath(path, glowPaint);
    }

    // Draw background
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, backgroundPaint);

    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) => false;
}

/// Tech-styled button with angular glass design
class AngularGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? glowColor;
  final bool enableGlow;

  const AngularGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 48.0,
    this.backgroundColor,
    this.borderColor,
    this.glowColor,
    this.enableGlow = true,
  });

  @override
  State<AngularGlassButton> createState() => _AngularGlassButtonState();
}

class _AngularGlassButtonState extends State<AngularGlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor ??
              (_isPressed
                  ? AppColors.glassStrong
                  : AppColorsExtended.glassAngular),
          // Sharp corners - no border radius (ChainGPT style)
          border: Border.all(
            color: widget.borderColor ?? AppColorsExtended.chainGPTOrange,
            width: 2.0,
          ),
          // Minimal shadow (ChainGPT style)
          boxShadow: widget.enableGlow && !_isPressed
              ? AppColorsExtended.getGlowShadow(
                  color: widget.glowColor ?? AppColorsExtended.chainGPTOrange,
                  blurRadius: 8,
                  spreadRadius: 0,
                  opacity: 0.2,
                )
              : null,
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}

/// Tech panel with angular design and gradient border
class TechPanel extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient? borderGradient;
  final bool enableGlow;

  const TechPanel({
    super.key,
    required this.child,
    this.title,
    this.padding,
    this.margin,
    this.borderGradient,
    this.enableGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColorsExtended.glassAngular,
        // Minimal shadow (ChainGPT style)
        boxShadow: enableGlow
            ? AppColorsExtended.getGlowShadow(
                color: AppColorsExtended.chainGPTOrange,
                blurRadius: 8,
                spreadRadius: 0,
                opacity: 0.2,
              )
            : null,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.transparent,
              ),
            ),
            child: Stack(
              children: [
                // Gradient border
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: borderGradient ?? AppColorsExtended.techGradient,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      color: AppColors.deepSpace,
                    ),
                  ),
                ),
                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColorsExtended.cosmicCyan.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          title!,
                          style: const TextStyle(
                            color: AppColorsExtended.chainGPTOrange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                    Expanded(
                      child: Padding(
                        padding: padding ?? const EdgeInsets.all(16),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Chip with angular glass design
class AngularGlassChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const AngularGlassChip({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColorsExtended.glassAngular,
          // Sharp corners - no border radius (ChainGPT style)
          border: Border.all(
            color: borderColor ?? AppColorsExtended.chainGPTOrange,
            width: 1,
          ),
          // Minimal shadow (ChainGPT style)
          boxShadow: [
            BoxShadow(
              color: (borderColor ?? AppColorsExtended.chainGPTOrange)
                  .withValues(alpha: 0.2),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: textColor ?? AppColorsExtended.chainGPTOrange,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor ?? AppColorsExtended.chainGPTOrange,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
