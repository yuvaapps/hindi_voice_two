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

/// Smooth floating animation for emojis & reading icons
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double offset;
  final Duration duration;

  const FloatingAnimation({
    super.key,
    required this.child,
    double offset = 6.0,
    double? distance,
    this.duration = const Duration(milliseconds: 1600),
  }) : offset = distance ?? offset;

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
    this.color = const Color(0xFF1565C0),
    this.height = 20,
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
                width: 3.2,
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

/// Royal Blue Glow Aura for selected reading cards
class RoyalBlueGlowAura extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final bool active;

  const RoyalBlueGlowAura({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFF1565C0),
    this.active = true,
  });

  @override
  State<RoyalBlueGlowAura> createState() => _RoyalBlueGlowAuraState();
}

class _RoyalBlueGlowAuraState extends State<RoyalBlueGlowAura> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 3.0, end: 12.0).animate(
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
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.3),
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

/// Staggered Entrance animation for reading list items
class StaggeredEntrance extends StatelessWidget {
  final Widget child;
  final int index;

  const StaggeredEntrance({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 350 + (index * 30).clamp(0, 450)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 16 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}

/// Celebration Confetti Burst on reading completion
class CelebrationConfettiBurst extends StatelessWidget {
  final bool isTriggered;
  final VoidCallback? onFinished;

  const CelebrationConfettiBurst({
    super.key,
    bool isTriggered = false,
    bool? show,
    this.onFinished,
  }) : isTriggered = show ?? isTriggered;

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
    final rand = math.Random(i * 23);
    final angle = rand.nextDouble() * 2 * math.pi;
    final speed = 80.0 + rand.nextDouble() * 220.0;
    final color = [
      const Color(0xFF1565C0), // Royal Blue
      const Color(0xFFFF9800), // Amber
      const Color(0xFF43A047), // Green
      const Color(0xFFE91E63), // Pink
      const Color(0xFF00ACC1), // Cyan
      const Color(0xFFFFD600), // Gold
    ][i % 6];
    return _Particle(angle, speed, color, rand.nextDouble() * 7.0 + 4.0);
  });

  _ConfettiPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    for (final p in _particles) {
      final dist = p.speed * progress;
      final x = center.dx + dist * math.cos(p.angle);
      final y = center.dy + dist * math.sin(p.angle) + (progress * progress * 75.0);
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

/// Authentic School Notebook Ruled Page Background Painter
class NotebookPagePainter extends CustomPainter {
  final Color marginColor;
  final Color ruledColor;

  NotebookPagePainter({
    this.marginColor = const Color(0xFFFFCDD2), // Soft pink/red margin line
    this.ruledColor = const Color(0xFFE3F2FD), // Soft blue ruled lines
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw red margin line
    final marginPaint = Paint()
      ..color = marginColor
      ..strokeWidth = 1.8;
    canvas.drawLine(const Offset(36, 0), Offset(36, size.height), marginPaint);

    // Draw horizontal ruled lines
    final linePaint = Paint()
      ..color = ruledColor
      ..strokeWidth = 1.0;

    const double lineSpacing = 28.0;
    double y = 40.0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
      y += lineSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
