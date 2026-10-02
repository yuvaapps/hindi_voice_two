import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Interactive bounce on press/tap
class BouncingWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;

  const BouncingWidget({
    super.key,
    required this.child,
    this.onTap,
    this.scaleFactor = 0.95,
  });

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}

/// Smooth floating animation for emojis, icons & highlights
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double offset;
  final Duration duration;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.offset = 8.0,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat(reverse: true);
    _animation = Tween<double>(begin: -widget.offset, end: widget.offset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _animation.value),
        child: widget.child,
      ),
    );
  }
}

/// Dynamic sound wave bars for active audio playback
class AudioSoundwaveWave extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final double height;

  const AudioSoundwaveWave({
    super.key,
    required this.isPlaying,
    this.color = const Color(0xFFD81B60),
    this.height = 24,
  });

  @override
  State<AudioSoundwaveWave> createState() => _AudioSoundwaveWaveState();
}

class _AudioSoundwaveWaveState extends State<AudioSoundwaveWave> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    final delays = [200, 450, 300, 600];
    _controllers = List.generate(4, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: delays[i]),
      );
    });

    _animations = _controllers.map((c) {
      return Tween<double>(begin: 0.25, end: 1.0).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();

    if (widget.isPlaying) {
      for (final c in _controllers) {
        c.repeat(reverse: true);
      }
    }
  }

  @override
  void didUpdateWidget(covariant AudioSoundwaveWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        for (final c in _controllers) {
          c.repeat(reverse: true);
        }
      } else {
        for (final c in _controllers) {
          c.stop();
          c.reset();
        }
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(4, (i) {
          return AnimatedBuilder(
            animation: _animations[i],
            builder: (context, child) {
              final h = widget.isPlaying ? (widget.height * _animations[i].value) : 4.0;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 3.5,
                height: h,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Gentle Berry & Magenta Glow Aura
class BerryGlowAura extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final bool active;

  const BerryGlowAura({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFFD81B60),
    this.active = true,
  });

  @override
  State<BerryGlowAura> createState() => _BerryGlowAuraState();
}

class _BerryGlowAuraState extends State<BerryGlowAura> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 4.0, end: 14.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return widget.child;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.35),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 3,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Staggered entry animation for lists & cards
class StaggeredEntrance extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration delay;

  const StaggeredEntrance({
    super.key,
    required this.child,
    required this.index,
    this.delay = const Duration(milliseconds: 40),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 35).clamp(0, 500)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}

/// Burst of celebration confetti when child completes handwriting practice
class CelebrationConfettiBurst extends StatelessWidget {
  final bool isTriggered;
  final VoidCallback? onFinished;

  const CelebrationConfettiBurst({
    super.key,
    required this.isTriggered,
    this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    if (!isTriggered) return const SizedBox.shrink();

    return IgnorePointer(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        onEnd: onFinished,
        builder: (context, progress, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(progress),
          );
        },
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final double progress;
  static final List<_Particle> _particles = List.generate(45, (i) {
    final rand = math.Random(i * 19);
    final angle = rand.nextDouble() * 2 * math.pi;
    final speed = 80.0 + rand.nextDouble() * 240.0;
    final color = [
      const Color(0xFFD81B60), // Berry
      const Color(0xFF8E24AA), // Violet
      const Color(0xFFFFB300), // Amber
      const Color(0xFF00ACC1), // Cyan
      const Color(0xFF43A047), // Green
      const Color(0xFFFF4081), // Pink
    ][i % 6];
    return _Particle(angle, speed, color, rand.nextDouble() * 8.0 + 4.0);
  });

  _ConfettiPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    for (final p in _particles) {
      final dist = p.speed * progress;
      final x = center.dx + dist * math.cos(p.angle);
      final y = center.dy + dist * math.sin(p.angle) + (progress * progress * 80.0);
      final paint = Paint()
        ..color = p.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), p.size * (1.0 - progress * 0.4), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}

class _Particle {
  final double angle;
  final double speed;
  final Color color;
  final double size;
  _Particle(this.angle, this.speed, this.color, this.size);
}

/// Hindi Workbook 4-line / ruled practice notebook painter
class WorkbookLinesPainter extends CustomPainter {
  final Color lineColor;
  final Color baselineColor;

  WorkbookLinesPainter({
    this.lineColor = const Color(0xFFE1BEE7), // Soft violet/pink ruled lines
    this.baselineColor = const Color(0xFFCE93D8),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withOpacity(0.5)
      ..strokeWidth = 1.0;

    final basePaint = Paint()
      ..color = baselineColor.withOpacity(0.8)
      ..strokeWidth = 1.5;

    // Draw Devanagari guide lines: Top line (Shirorekha guide), Middle line, Base line, Lower guide
    final centerY = size.height / 2;
    final spacing = size.height * 0.12;

    // Top Shirorekha guide
    canvas.drawLine(Offset(16, centerY - spacing * 1.5), Offset(size.width - 16, centerY - spacing * 1.5), paint);
    // Upper body guide
    canvas.drawLine(Offset(16, centerY - spacing * 0.5), Offset(size.width - 16, centerY - spacing * 0.5), paint);
    // Main baseline
    canvas.drawLine(Offset(16, centerY + spacing * 0.8), Offset(size.width - 16, centerY + spacing * 0.8), basePaint);
    // Lower matra guide
    canvas.drawLine(Offset(16, centerY + spacing * 1.8), Offset(size.width - 16, centerY + spacing * 1.8), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
