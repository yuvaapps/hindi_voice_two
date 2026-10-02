import 'dart:math';
import 'package:flutter/material.dart';

/// Gentle floating animation (up and down)
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double offset;
  final Duration duration;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.offset = 5.0,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);
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

/// Tactile bounce button with spring response on press
class BouncingWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;
  final Duration duration;

  const BouncingWidget({
    super.key,
    required this.child,
    this.onTap,
    this.scaleFactor = 0.92,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleFactor : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}

/// Audio wave concentric pulse rings
class AudioSoundwaveWave extends StatefulWidget {
  final Widget child;
  final bool isPlaying;
  final Color waveColor;

  const AudioSoundwaveWave({
    super.key,
    required this.child,
    required this.isPlaying,
    this.waveColor = const Color(0xFF2E7D32),
  });

  @override
  State<AudioSoundwaveWave> createState() => _AudioSoundwaveWaveState();
}

class _AudioSoundwaveWaveState extends State<AudioSoundwaveWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AudioSoundwaveWave oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat();
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
    return CustomPaint(
      painter: _WavePainter(
        progress: _controller,
        color: widget.waveColor,
        enabled: widget.isPlaying,
      ),
      child: widget.child,
    );
  }
}

class _WavePainter extends CustomPainter {
  final Animation<double> progress;
  final Color color;
  final bool enabled;

  _WavePainter({
    required this.progress,
    required this.color,
    required this.enabled,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (!enabled) return;

    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 2;

    for (int i = 0; i < 3; i++) {
      final waveProgress = (progress.value + i / 3.0) % 1.0;
      final radius = baseRadius + waveProgress * 22.0;
      final opacity = (1.0 - waveProgress).clamp(0.0, 1.0) * 0.45;

      final paint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) =>
      oldDelegate.enabled != enabled || oldDelegate.color != color;
}

/// Staggered entry animation (fade-in & slide-up)
class StaggeredEntrance extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration baseDelay;
  final Duration duration;
  final double slideOffset;

  const StaggeredEntrance({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 30),
    this.duration = const Duration(milliseconds: 360),
    this.slideOffset = 20.0,
  });

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    final delay = widget.baseDelay * (widget.index < 12 ? widget.index : 12);
    Future.delayed(delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// App 33 Exclusive: Chalkboard & Letter Shimmer Aura
class ChalkGlowAura extends StatefulWidget {
  final Widget child;
  final bool active;

  const ChalkGlowAura({
    super.key,
    required this.child,
    this.active = true,
  });

  @override
  State<ChalkGlowAura> createState() => _ChalkGlowAuraState();
}

class _ChalkGlowAuraState extends State<ChalkGlowAura>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return widget.child;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final opacity = 0.5 + _ctrl.value * 0.5;
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// App 33 Exclusive: Forest Emerald Halo Pulse
class EmeraldHaloBreathing extends StatefulWidget {
  final Widget child;
  const EmeraldHaloBreathing({super.key, required this.child});

  @override
  State<EmeraldHaloBreathing> createState() => _EmeraldHaloBreathingState();
}

class _EmeraldHaloBreathingState extends State<EmeraldHaloBreathing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.15, end: 0.55).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2E7D32).withOpacity(_glow.value),
                blurRadius: 16,
                spreadRadius: 2,
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

/// App 33 Exclusive: Star & Leaf Celebration Confetti Overlay
class StarStampCelebration extends StatefulWidget {
  final Widget child;
  final bool celebrate;

  const StarStampCelebration({
    super.key,
    required this.child,
    required this.celebrate,
  });

  @override
  State<StarStampCelebration> createState() => _StarStampCelebrationState();
}

class _StarStampCelebrationState extends State<StarStampCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_CelebrationParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.celebrate) _spawnAndAnimate();
  }

  void _spawnAndAnimate() {
    _particles.clear();
    final colors = [
      const Color(0xFF1B5E20), // Forest Emerald
      const Color(0xFF2E7D32), // Jade Green
      const Color(0xFFFFB300), // Amber Gold
      const Color(0xFFFFD54F), // Pale Gold
      Colors.orangeAccent,
      Colors.white,
    ];

    for (int i = 0; i < 40; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 120 + _random.nextDouble() * 190;
      final size = 6.0 + _random.nextDouble() * 6.0;
      final color = colors[_random.nextInt(colors.length)];
      final rotationSpeed = (_random.nextDouble() - 0.5) * 8;

      _particles.add(_CelebrationParticle(
        vx: cos(angle) * speed,
        vy: sin(angle) * speed - 60,
        size: size,
        color: color,
        rotationSpeed: rotationSpeed,
        isStar: _random.nextBool(),
      ));
    }

    _controller.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(covariant StarStampCelebration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.celebrate && !oldWidget.celebrate) {
      _spawnAndAnimate();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_controller.isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _CelebrationPainter(
                      particles: _particles,
                      progress: _controller.value,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _CelebrationParticle {
  final double vx;
  final double vy;
  final double size;
  final Color color;
  final double rotationSpeed;
  final bool isStar;

  _CelebrationParticle({
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotationSpeed,
    required this.isStar,
  });
}

class _CelebrationPainter extends CustomPainter {
  final List<_CelebrationParticle> particles;
  final double progress;

  _CelebrationPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width / 2, size.height / 2);
    final t = progress;
    final gravity = 250.0 * t * t;
    final opacity = (1.0 - t).clamp(0.0, 1.0);

    for (final p in particles) {
      final x = origin.dx + p.vx * t;
      final y = origin.dy + p.vy * t + gravity;
      final paint = Paint()
        ..color = p.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotationSpeed * t);

      if (p.isStar) {
        final path = Path()
          ..moveTo(0, -p.size)
          ..lineTo(p.size * 0.7, 0)
          ..lineTo(0, p.size)
          ..lineTo(-p.size * 0.7, 0)
          ..close();
        canvas.drawPath(path, paint);
      } else {
        canvas.drawCircle(Offset.zero, p.size / 2, paint);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _CelebrationPainter oldDelegate) => true;
}

/// Authentic Ruled Notebook Background with Red Margin Line
class NotebookRuledBackground extends StatelessWidget {
  final Widget child;
  const NotebookRuledBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NotebookLinesPainter(),
      child: child,
    );
  }
}

class _NotebookLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.lightBlue.withOpacity(0.12)
      ..strokeWidth = 1.0;

    const spacing = 28.0;
    for (double y = 40.0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Left vertical margin line (red/rose)
    final marginPaint = Paint()
      ..color = Colors.red.withOpacity(0.18)
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(36, 0), Offset(36, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
