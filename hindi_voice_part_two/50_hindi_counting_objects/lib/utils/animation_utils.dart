import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// StaggeredEntrance — slides + fades in on mount
// ─────────────────────────────────────────────────────────────────────────────
class StaggeredEntrance extends StatefulWidget {
  final Widget child;
  final int delayMs;
  const StaggeredEntrance({super.key, required this.child, this.delayMs = 0});

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
            begin: const Offset(0, 0.18), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    if (widget.delayMs == 0) {
      _ctrl.forward();
    } else {
      Future.delayed(Duration(milliseconds: widget.delayMs), () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// BouncingWidget — gentle infinite bounce
// ─────────────────────────────────────────────────────────────────────────────
class BouncingWidget extends StatefulWidget {
  final Widget child;
  final double amplitude;
  const BouncingWidget({super.key, required this.child, this.amplitude = 8});

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: widget.amplitude)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, -_anim.value),
          child: widget.child,
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// ShakeWidget — shakes horizontally on error
// ─────────────────────────────────────────────────────────────────────────────
class ShakeWidget extends StatefulWidget {
  final Widget child;
  final bool shake;
  final VoidCallback? onComplete;
  const ShakeWidget(
      {super.key, required this.child, required this.shake, this.onComplete});

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _offset = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void didUpdateWidget(covariant ShakeWidget old) {
    super.didUpdateWidget(old);
    if (widget.shake && !old.shake) {
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _offset,
        builder: (_, __) => Transform.translate(
          offset: Offset(_offset.value, 0),
          child: widget.child,
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// NumberPulseAura — glowing pulsing aura behind items
// ─────────────────────────────────────────────────────────────────────────────
class NumberPulseAura extends StatefulWidget {
  final Widget child;
  final Color color;
  const NumberPulseAura(
      {super.key, required this.child, this.color = const Color(0xFFEF6C00)});

  @override
  State<NumberPulseAura> createState() => _NumberPulseAuraState();
}

class _NumberPulseAuraState extends State<NumberPulseAura>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat();
    _scale = Tween<double>(begin: 0.95, end: 1.35)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutQuad));
    _opacity = Tween<double>(begin: 0.5, end: 0.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutQuad));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: _scale.value,
              child: Opacity(
                opacity: _opacity.value,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.withOpacity(0.35),
                  ),
                ),
              ),
            ),
            child!,
          ],
        ),
        child: widget.child,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// AudioSoundwaveWave — animated bars for live speech/pronunciation
// ─────────────────────────────────────────────────────────────────────────────
class AudioSoundwaveWave extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final int barCount;
  final double height;
  const AudioSoundwaveWave({
    super.key,
    required this.isPlaying,
    this.color = Colors.white,
    this.barCount = 5,
    this.height = 30,
  });

  @override
  State<AudioSoundwaveWave> createState() => _AudioSoundwaveWaveState();
}

class _AudioSoundwaveWaveState extends State<AudioSoundwaveWave>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _anims = [];
  final _rng = math.Random();

  @override
  void initState() {
    super.initState();
    _buildBars();
  }

  void _buildBars() {
    for (int i = 0; i < widget.barCount; i++) {
      final dur = 280 + _rng.nextInt(280);
      final ctrl = AnimationController(
          vsync: this, duration: Duration(milliseconds: dur));
      ctrl.repeat(reverse: true);
      _controllers.add(ctrl);
      _anims.add(
          Tween<double>(begin: 0.2, end: 1.0)
              .animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)));
    }
  }

  @override
  void didUpdateWidget(covariant AudioSoundwaveWave old) {
    super.didUpdateWidget(old);
    for (final c in _controllers) {
      widget.isPlaying ? c.repeat(reverse: true) : c.stop();
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
  Widget build(BuildContext context) => SizedBox(
        height: widget.height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(widget.barCount, (i) {
            return AnimatedBuilder(
              animation: _anims[i],
              builder: (_, __) => Container(
                width: 4,
                height: widget.isPlaying
                    ? widget.height * _anims[i].value
                    : widget.height * 0.2,
                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// CelebrationConfettiBurst — colorful particle confetti celebration
// ─────────────────────────────────────────────────────────────────────────────
class CelebrationConfettiBurst extends StatefulWidget {
  final Widget child;
  final bool active;
  const CelebrationConfettiBurst(
      {super.key, required this.child, required this.active});

  @override
  State<CelebrationConfettiBurst> createState() =>
      _CelebrationConfettiBurstState();
}

class _CelebrationConfettiBurstState extends State<CelebrationConfettiBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  List<_Confetti> _pieces = [];
  final _rng = math.Random();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
  }

  @override
  void didUpdateWidget(covariant CelebrationConfettiBurst old) {
    super.didUpdateWidget(old);
    if (widget.active && !old.active) {
      _pieces = List.generate(
        45,
        (_) => _Confetti(
          x: _rng.nextDouble(),
          speed: 0.4 + _rng.nextDouble() * 0.6,
          size: 6 + _rng.nextDouble() * 8,
          color: _confettiColors[_rng.nextInt(_confettiColors.length)],
          drift: (_rng.nextDouble() - 0.5) * 0.4,
          spin: _rng.nextDouble() * 360,
        ),
      );
      _ctrl.forward(from: 0);
    }
  }

  static const _confettiColors = [
    Color(0xFFEF6C00), Color(0xFFFF9800), Color(0xFFFFD54F),
    Color(0xFF00B0FF), Color(0xFFE91E63), Color(0xFF7E57C2),
    Color(0xFF4CAF50), Colors.white,
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          widget.child,
          if (widget.active)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _ctrl,
                  builder: (_, __) => CustomPaint(
                    painter: _ConfettiPainter(_pieces, _ctrl.value),
                  ),
                ),
              ),
            ),
        ],
      );
}

class _Confetti {
  final double x, speed, size, drift, spin;
  final Color color;
  const _Confetti(
      {required this.x, required this.speed, required this.size,
       required this.color, required this.drift, required this.spin});
}

class _ConfettiPainter extends CustomPainter {
  final List<_Confetti> pieces;
  final double progress;
  _ConfettiPainter(this.pieces, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final y = p.speed * progress * size.height;
      final x = (p.x * size.width) + (p.drift * progress * size.width);
      final alpha = (1.0 - progress).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = p.color.withOpacity(alpha)
        ..style = PaintingStyle.fill;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate((p.spin * progress) * math.pi / 180);
      canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: p.size, height: p.size * 0.55),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}
