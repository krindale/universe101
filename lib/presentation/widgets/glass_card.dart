import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Clean white card with ChainGPT Labs style
/// White background, gray borders, sharp corners, minimal shadows
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double blurStrength;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 0, // Sharp corners - ChainGPT Labs style
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.blurStrength = 0, // No blur in ChainGPT Labs style
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(AppSpacing.paddingMD),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.cardSurface,
        // Sharp corners - no border radius (ChainGPT Labs style)
        borderRadius: borderRadius > 0 ? BorderRadius.circular(borderRadius) : null,
        border: Border.all(
          color: borderColor ?? AppColors.borderPrimary,
          width: borderWidth,
        ),
        // Minimal shadow (ChainGPT Labs style)
        boxShadow: AppColors.getMinimalShadow(),
      ),
      child: child,
    );

    if (onTap != null) {
      return Container(
        margin: margin,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: content,
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      child: content,
    );
  }
}

/// Strong glass card variant for elevated surfaces
class GlassCardStrong extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GlassCardStrong({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      backgroundColor: AppColors.glassStrong,
      blurStrength: AppSpacing.blurLG,
      onTap: onTap,
      child: child,
    );
  }
}

/// Subtle glass card variant for backgrounds
class GlassCardSubtle extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GlassCardSubtle({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      backgroundColor: AppColors.glassSubtle,
      blurStrength: AppSpacing.blurSM,
      onTap: onTap,
      child: child,
    );
  }
}
