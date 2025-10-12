import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors_extended.dart';

/// Particle types for different visual effects
enum ParticleType {
  star,         // White star particles
  tech,         // Cyan tech particles
  energy,       // Orange energy particles
  nebula,       // Purple nebula particles
  plasma,       // Pink plasma particles
}

/// Single particle data
class Particle {
  Offset position;
  Offset velocity;
  double size;
  Color color;
  double opacity;
  final ParticleType type;
  double lifetime;
  double maxLifetime;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
    required this.opacity,
    required this.type,
    this.lifetime = 0,
    this.maxLifetime = double.infinity,
  });

  void update(double dt) {
    position += velocity * dt;
    lifetime += dt;

    // Fade out near end of lifetime
    if (maxLifetime != double.infinity) {
      final lifeRatio = lifetime / maxLifetime;
      opacity = (1.0 - lifeRatio).clamp(0.0, 1.0);
    }
  }

  bool get isDead => lifetime >= maxLifetime;
}

/// Advanced particle system painter
class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final bool showGlow;

  ParticlePainter({
    required this.particles,
    this.showGlow = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withValues(alpha: particle.opacity)
        ..style = PaintingStyle.fill;

      // Draw glow effect
      if (showGlow && particle.opacity > 0.3) {
        final glowPaint = Paint()
          ..color = particle.color.withValues(alpha: particle.opacity * 0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size * 2);

        canvas.drawCircle(
          particle.position,
          particle.size * 1.5,
          glowPaint,
        );
      }

      // Draw particle
      canvas.drawCircle(
        particle.position,
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

/// Advanced particle system widget with multiple effects
class AdvancedParticleSystem extends StatefulWidget {
  final int particleCount;
  final ParticleType particleType;
  final double minSize;
  final double maxSize;
  final double minSpeed;
  final double maxSpeed;
  final bool enableGlow;
  final bool autoRespawn;
  final double particleLifetime;

  const AdvancedParticleSystem({
    super.key,
    this.particleCount = 50,
    this.particleType = ParticleType.star,
    this.minSize = 1.0,
    this.maxSize = 3.0,
    this.minSpeed = 10.0,
    this.maxSpeed = 30.0,
    this.enableGlow = true,
    this.autoRespawn = true,
    this.particleLifetime = double.infinity,
  });

  @override
  State<AdvancedParticleSystem> createState() => _AdvancedParticleSystemState();
}

class _AdvancedParticleSystemState extends State<AdvancedParticleSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();
  DateTime _lastUpdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeParticles();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 365), // Effectively infinite
    )..addListener(_updateParticles);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    _particles.clear();

    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(_createParticle());
    }
  }

  Particle _createParticle() {
    final size = context.size;
    if (size == null) {
      return _createDefaultParticle();
    }

    final position = Offset(
      _random.nextDouble() * size.width,
      _random.nextDouble() * size.height,
    );

    final angle = _random.nextDouble() * 2 * math.pi;
    final speed = widget.minSpeed +
        _random.nextDouble() * (widget.maxSpeed - widget.minSpeed);

    final velocity = Offset(
      math.cos(angle) * speed,
      math.sin(angle) * speed,
    );

    final particleSize = widget.minSize +
        _random.nextDouble() * (widget.maxSize - widget.minSize);

    final color = _getParticleColor(widget.particleType);
    final opacity = 0.5 + _random.nextDouble() * 0.5;

    return Particle(
      position: position,
      velocity: velocity,
      size: particleSize,
      color: color,
      opacity: opacity,
      type: widget.particleType,
      maxLifetime: widget.particleLifetime,
    );
  }

  Particle _createDefaultParticle() {
    return Particle(
      position: Offset.zero,
      velocity: const Offset(10, 10),
      size: 2.0,
      color: Colors.white,
      opacity: 1.0,
      type: widget.particleType,
      maxLifetime: widget.particleLifetime,
    );
  }

  Color _getParticleColor(ParticleType type) {
    switch (type) {
      case ParticleType.star:
        return AppColorsExtended.starfieldParticle;
      case ParticleType.tech:
        return AppColorsExtended.particleCyan;
      case ParticleType.energy:
        return AppColorsExtended.particleOrange;
      case ParticleType.nebula:
        return AppColorsExtended.particlePurple;
      case ParticleType.plasma:
        return AppColorsExtended.particleOrange;
    }
  }

  void _updateParticles() {
    final now = DateTime.now();
    final dt = now.difference(_lastUpdate).inMilliseconds / 1000.0;
    _lastUpdate = now;

    final size = context.size;
    if (size == null) return;

    // Update existing particles
    for (int i = _particles.length - 1; i >= 0; i--) {
      _particles[i].update(dt);

      // Wrap around screen edges
      if (_particles[i].position.dx < -10) {
        _particles[i].position = Offset(
          size.width + 10,
          _particles[i].position.dy,
        );
      } else if (_particles[i].position.dx > size.width + 10) {
        _particles[i].position = Offset(
          -10,
          _particles[i].position.dy,
        );
      }

      if (_particles[i].position.dy < -10) {
        _particles[i].position = Offset(
          _particles[i].position.dx,
          size.height + 10,
        );
      } else if (_particles[i].position.dy > size.height + 10) {
        _particles[i].position = Offset(
          _particles[i].position.dx,
          -10,
        );
      }

      // Remove dead particles
      if (_particles[i].isDead) {
        _particles.removeAt(i);
      }
    }

    // Respawn particles if needed
    if (widget.autoRespawn) {
      while (_particles.length < widget.particleCount) {
        _particles.add(_createParticle());
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParticlePainter(
        particles: _particles,
        showGlow: widget.enableGlow,
      ),
      size: Size.infinite,
    );
  }
}
