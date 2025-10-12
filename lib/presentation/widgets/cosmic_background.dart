import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Light background widget with ChainGPT Labs style
/// Clean, minimal, professional appearance
class CosmicBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final bool animated;

  const CosmicBackground({
    super.key,
    required this.child,
    this.gradient,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    // No animation in ChainGPT style - clean and static
    return Container(
      decoration: const BoxDecoration(
        // Light gray background - ChainGPT Labs style
        color: AppColors.background,
      ),
      child: child,
    );
  }
}

/// Animated cosmic background with stars
class AnimatedCosmicBackground extends StatefulWidget {
  final Widget child;
  final Gradient? gradient;

  const AnimatedCosmicBackground({
    super.key,
    required this.child,
    this.gradient,
  });

  @override
  State<AnimatedCosmicBackground> createState() =>
      _AnimatedCosmicBackgroundState();
}

class _AnimatedCosmicBackgroundState extends State<AnimatedCosmicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Light gray background - ChainGPT Labs style
        color: AppColors.background,
      ),
      child: widget.child,
    );
  }
}

/// Custom painter for animated stars
class StarsPainter extends CustomPainter {
  final double progress;

  StarsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Draw stars at various positions
    for (int i = 0; i < 100; i++) {
      final x = (i * 37.0 + progress * 100) % size.width;
      final y = (i * 53.0) % size.height;
      final radius = (i % 3) + 1.0;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
