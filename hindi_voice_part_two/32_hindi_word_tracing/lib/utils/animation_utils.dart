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

/// Continuous pulsing scale animation
class PulsingScale extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final Duration duration;
  final bool active;

  const PulsingScale({
    super.key,
    required this.child,
    this.minScale = 0.94,
    this.maxScale = 1.06,
    this.duration = const Duration(milliseconds: 1100),
    this.active = true,
  });

  @override
  State<PulsingScale> createState() => _PulsingScaleState();
}

class _PulsingScaleState extends State<PulsingScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: widget.minScale, end: widget.maxScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.active) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant PulsingScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.active && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0.5;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return widget.child;
    return ScaleTransition(
      scale: _animation,
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

/// Concentric royal indigo ripple wave rings
class AudioRippleEffect extends StatefulWidget {
  final Widget child;
  final bool isPlaying;
  final Color rippleColor;

  const AudioRippleEffect({
    super.key,
    required this.child,
    required this.isPlaying,
    this.rippleColor = const Color(0xFF3F51B5),
  });

  @override
  State<AudioRippleEffect> createState() => _AudioRippleEffectState();
}

class _AudioRippleEffectState extends State<AudioRippleEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AudioRippleEffect oldWidget) {
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
      painter: _RipplePainter(
        progress: _controller,
        color: widget.rippleColor,
        enabled: widget.isPlaying,
      ),
      child: widget.child,
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Animation<double> progress;
  final Color color;
  final bool enabled;

  _RipplePainter({
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
  bool shouldRepaint(covariant _RipplePainter oldDelegate) =>
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
    this.baseDelay = const Duration(milliseconds: 35),
    this.duration = const Duration(milliseconds: 380),
    this.slideOffset = 22.0,
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

/// Elastic bounce pop animation
class ElasticPop extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ElasticPop({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<ElasticPop> createState() => _ElasticPopState();
}

class _ElasticPopState extends State<ElasticPop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}

/// App 32 Exclusive: Shimmering Trace Guide Line Aura
class TraceGuideShimmer extends StatefulWidget {
  final Widget child;
  final bool active;

  const TraceGuideShimmer({
    super.key,
    required this.child,
    this.active = true,
  });

  @override
  State<TraceGuideShimmer> createState() => _TraceGuideShimmerState();
}

class _TraceGuideShimmerState extends State<TraceGuideShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
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
        final opacity = 0.4 + _ctrl.value * 0.5;
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// App 32 Exclusive: Glowing Royal Indigo Halo Pulse
class IndigoHaloGlow extends StatefulWidget {
  final Widget child;
  const IndigoHaloGlow({super.key, required this.child});

  @override
  State<IndigoHaloGlow> createState() => _IndigoHaloGlowState();
}

class _IndigoHaloGlowState extends State<IndigoHaloGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
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
                color: const Color(0xFF3F51B5).withOpacity(_glow.value),
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

/// Indigo, Cyan & Gold Confetti Celebration Overlay
class ConfettiCelebrationOverlay extends StatefulWidget {
  final Widget child;
  final bool celebrate;

  const ConfettiCelebrationOverlay({
    super.key,
    required this.child,
    required this.celebrate,
  });

  @override
  State<ConfettiCelebrationOverlay> createState() =>
      _ConfettiCelebrationOverlayState();
}

class _ConfettiCelebrationOverlayState extends State<ConfettiCelebrationOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_ConfettiParticle> _particles = [];
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
      const Color(0xFF3F51B5),
      const Color(0xFF5C6BC0),
      const Color(0xFF7C4DFF),
      Colors.pinkAccent,
      Colors.amber,
      Colors.white,
    ];

    for (int i = 0; i < 40; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 120 + _random.nextDouble() * 180;
      final size = 6.0 + _random.nextDouble() * 6.0;
      final color = colors[_random.nextInt(colors.length)];
      final rotationSpeed = (_random.nextDouble() - 0.5) * 8;

      _particles.add(_ConfettiParticle(
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
  void didUpdateWidget(covariant ConfettiCelebrationOverlay oldWidget) {
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
                    painter: _ConfettiPainter(
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

class _ConfettiParticle {
  final double vx;
  final double vy;
  final double size;
  final Color color;
  final double rotationSpeed;
  final bool isStar;

  _ConfettiParticle({
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotationSpeed,
    required this.isStar,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

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
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
