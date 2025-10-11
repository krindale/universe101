import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors_extended.dart';

/// Constellation node (star point)
class ConstellationNode {
  Offset position;
  double size;
  Color color;

  ConstellationNode({
    required this.position,
    required this.size,
    required this.color,
  });
}

/// Constellation painter with connected nodes
class ConstellationPainter extends CustomPainter {
  final List<ConstellationNode> nodes;
  final double connectionDistance;
  final bool showConnections;
  final bool showGlow;

  ConstellationPainter({
    required this.nodes,
    this.connectionDistance = 150.0,
    this.showConnections = true,
    this.showGlow = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections first (behind nodes)
    if (showConnections) {
      _drawConnections(canvas);
    }

    // Draw nodes
    for (final node in nodes) {
      // Draw glow
      if (showGlow) {
        final glowPaint = Paint()
          ..color = node.color.withValues(alpha: 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

        canvas.drawCircle(
          node.position,
          node.size * 2,
          glowPaint,
        );
      }

      // Draw node
      final nodePaint = Paint()
        ..color = node.color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        node.position,
        node.size,
        nodePaint,
      );
    }
  }

  void _drawConnections(Canvas canvas) {
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final node1 = nodes[i];
        final node2 = nodes[j];

        final distance = (node1.position - node2.position).distance;

        if (distance <= connectionDistance) {
          final opacity = (1.0 - distance / connectionDistance) * 0.4;

          final linePaint = Paint()
            ..color = AppColorsExtended.constellationLine.withValues(
              alpha: opacity,
            )
            ..strokeWidth = 1.0
            ..style = PaintingStyle.stroke;

          canvas.drawLine(
            node1.position,
            node2.position,
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ConstellationPainter oldDelegate) => true;
}

/// Interactive constellation effect widget
class ConstellationEffect extends StatefulWidget {
  final int nodeCount;
  final double minNodeSize;
  final double maxNodeSize;
  final double connectionDistance;
  final bool animated;
  final double animationSpeed;
  final bool showGlow;

  const ConstellationEffect({
    super.key,
    this.nodeCount = 30,
    this.minNodeSize = 2.0,
    this.maxNodeSize = 4.0,
    this.connectionDistance = 150.0,
    this.animated = true,
    this.animationSpeed = 5.0,
    this.showGlow = true,
  });

  @override
  State<ConstellationEffect> createState() => _ConstellationEffectState();
}

class _ConstellationEffectState extends State<ConstellationEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ConstellationNode> _nodes = [];
  final List<Offset> _velocities = [];
  final math.Random _random = math.Random();
  DateTime _lastUpdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeNodes();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 365),
    )..addListener(_updateNodes);

    if (widget.animated) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeNodes() {
    _nodes.clear();
    _velocities.clear();

    for (int i = 0; i < widget.nodeCount; i++) {
      final size = context.size ?? const Size(400, 800);

      final position = Offset(
        _random.nextDouble() * size.width,
        _random.nextDouble() * size.height,
      );

      final nodeSize = widget.minNodeSize +
          _random.nextDouble() * (widget.maxNodeSize - widget.minNodeSize);

      final color = _random.nextBool()
          ? AppColorsExtended.constellationNode
          : AppColorsExtended.constellationNode.withValues(alpha: 0.8);

      _nodes.add(ConstellationNode(
        position: position,
        size: nodeSize,
        color: color,
      ));

      // Random velocity for animation
      final angle = _random.nextDouble() * 2 * math.pi;
      final speed = widget.animationSpeed;
      _velocities.add(Offset(
        math.cos(angle) * speed,
        math.sin(angle) * speed,
      ));
    }
  }

  void _updateNodes() {
    if (!widget.animated) return;

    final now = DateTime.now();
    final dt = now.difference(_lastUpdate).inMilliseconds / 1000.0;
    _lastUpdate = now;

    final size = context.size;
    if (size == null) return;

    for (int i = 0; i < _nodes.length; i++) {
      // Update position
      _nodes[i].position += _velocities[i] * dt;

      // Wrap around edges
      if (_nodes[i].position.dx < -10) {
        _nodes[i].position = Offset(
          size.width + 10,
          _nodes[i].position.dy,
        );
      } else if (_nodes[i].position.dx > size.width + 10) {
        _nodes[i].position = Offset(
          -10,
          _nodes[i].position.dy,
        );
      }

      if (_nodes[i].position.dy < -10) {
        _nodes[i].position = Offset(
          _nodes[i].position.dx,
          size.height + 10,
        );
      } else if (_nodes[i].position.dy > size.height + 10) {
        _nodes[i].position = Offset(
          _nodes[i].position.dx,
          -10,
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConstellationPainter(
        nodes: _nodes,
        connectionDistance: widget.connectionDistance,
        showGlow: widget.showGlow,
      ),
      size: Size.infinite,
    );
  }
}
