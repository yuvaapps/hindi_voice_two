import 'dart:math';
import 'package:flutter/material.dart';

/// Interactive button click bounce animation
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

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Floating idle animation for emojis and card icons
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double distance;
  final Duration duration;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.distance = 6.0,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = Tween<double>(begin: -widget.distance, end: widget.distance)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
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
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Active sound wave visualizer when voice/audio is playing
class AudioSoundwaveWave extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final double height;

  const AudioSoundwaveWave({
    super.key,
    required this.isPlaying,
    this.color = const Color(0xFF6A1B9A),
    this.height = 20,
  });

  @override
  State<AudioSoundwaveWave> createState() => _AudioSoundwaveWaveState();
}

class _AudioSoundwaveWaveState extends State<AudioSoundwaveWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    if (widget.isPlaying) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant AudioSoundwaveWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(4, (index) {
            final sinOffset = sin((_controller.value * pi) + (index * 0.7));
            final barHeight = 4.0 + (widget.height - 4.0) * sinOffset.abs();
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 3.5,
              height: barHeight,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}

/// Royal Purple Glow Aura for active flashcard
class PurpleGlowAura extends StatefulWidget {
  final Widget child;
  final bool isGlowing;
  final Color glowColor;

  const PurpleGlowAura({
    super.key,
    required this.child,
    this.isGlowing = true,
    this.glowColor = const Color(0xFF6A1B9A),
  });

  @override
  State<PurpleGlowAura> createState() => _PurpleGlowAuraState();
}

class _PurpleGlowAuraState extends State<PurpleGlowAura>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 4.0, end: 16.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isGlowing) return widget.child;

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.35),
                blurRadius: _glowAnimation.value,
                spreadRadius: _glowAnimation.value / 3.5,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// 3D Card Flip Animation (Y-axis perspective flip)
class CardFlip3DAnimation extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool showBack;
  final VoidCallback onTap;

  const CardFlip3DAnimation({
    super.key,
    required this.front,
    required this.back,
    required this.showBack,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: showBack ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
        builder: (context, value, child) {
          final isUnder = (value > 0.5);
          final angle = value * pi;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(angle),
            child: isUnder
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: back,
                  )
                : front,
          );
        },
      ),
    );
  }
}

/// Staggered Entrance animation for lists
class StaggeredEntrance extends StatelessWidget {
  final int index;
  final Widget child;
  final Duration duration;

  const StaggeredEntrance({
    super.key,
    required this.index,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  Widget build(BuildContext context) {
    final clampedIndex = index > 10 ? 10 : index;
    final delay = Duration(milliseconds: 35 * clampedIndex);

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration + delay,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Particle Confetti Burst
class CelebrationConfettiBurst extends StatefulWidget {
  final bool show;
  final VoidCallback? onFinished;

  const CelebrationConfettiBurst({
    super.key,
    required this.show,
    this.onFinished,
  });

  @override
  State<CelebrationConfettiBurst> createState() => _CelebrationConfettiBurstState();
}

class _CelebrationConfettiBurstState extends State<CelebrationConfettiBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onFinished?.call();
      }
    });

    if (widget.show) {
      _burst();
    }
  }

  @override
  void didUpdateWidget(covariant CelebrationConfettiBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _burst();
    }
  }

  void _burst() {
    _particles.clear();
    final colors = [
      const Color(0xFF6A1B9A), // Royal Purple
      const Color(0xFFFFD600), // Gold
      const Color(0xFFAB47BC), // Light Purple
      const Color(0xFFFF7043), // Coral Orange
      const Color(0xFF26A69A), // Mint Teal
    ];

    for (int i = 0; i < 35; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 70 + _random.nextDouble() * 160;
      _particles.add(
        _ConfettiParticle(
          dx: cos(angle) * speed,
          dy: sin(angle) * speed - 50,
          color: colors[_random.nextInt(colors.length)],
          size: 6 + _random.nextDouble() * 6,
          rotation: _random.nextDouble() * 4 * pi,
        ),
      );
    }
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show && !_controller.isAnimating) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final progress = _controller.value;
          final opacity = (1.0 - progress).clamp(0.0, 1.0);

          return CustomPaint(
            size: Size.infinite,
            painter: _ConfettiPainter(
              particles: _particles,
              progress: progress,
              opacity: opacity,
            ),
          );
        },
      ),
    );
  }
}

class _ConfettiParticle {
  final double dx;
  final double dy;
  final Color color;
  final double size;
  final double rotation;

  _ConfettiParticle({
    required this.dx,
    required this.dy,
    required this.color,
    required this.size,
    required this.rotation,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;
  final double opacity;

  _ConfettiPainter({
    required this.particles,
    required this.progress,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2.5);
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      paint.color = p.color.withOpacity(opacity);
      final currentX = center.dx + p.dx * progress;
      final currentY = center.dy + p.dy * progress + (140 * progress * progress);

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(p.rotation * progress);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.7),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
