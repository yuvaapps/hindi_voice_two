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
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 1)
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
        builder: (_, child) => Transform.translate(
          offset: Offset(0, -widget.amplitude * _anim.value),
          child: child,
        ),
        child: widget.child,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// NumberPulseAura — glowing pulse ring around active speaker
// ─────────────────────────────────────────────────────────────────────────────
class NumberPulseAura extends StatefulWidget {
  final Widget child;
  final bool active;
  final Color color;
  const NumberPulseAura(
      {super.key, required this.child, this.active = false, this.color = Colors.white});

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
        vsync: this, duration: const Duration(milliseconds: 700));
    _scale = Tween<double>(begin: 1.0, end: 1.25)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _opacity = Tween<double>(begin: 0.6, end: 0.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant NumberPulseAura old) {
    super.didUpdateWidget(old);
    if (widget.active && !old.active) {
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
        animation: _ctrl,
        builder: (_, child) => Stack(
          alignment: Alignment.center,
          children: [
            if (widget.active)
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
    Color(0xFF00ACC1), Color(0xFFFF7043), Color(0xFFFFD700),
    Color(0xFF26C6DA), Color(0xFFE91E63), Color(0xFF7E57C2),
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
      final y = size.height * progress * p.speed - 20;
      final x = size.width * p.x + size.width * p.drift * progress;
      final paint = Paint()..color = p.color.withOpacity(1 - progress * 0.6);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.spin * progress * 3.14 / 180);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset.zero, width: p.size, height: p.size * 0.5),
          paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// ShakeWidget — subtle shake effect
// ─────────────────────────────────────────────────────────────────────────────
class ShakeWidget extends StatefulWidget {
  final Widget child;
  final bool shake;
  const ShakeWidget({super.key, required this.child, required this.shake});

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _anim = Tween<double>(begin: 0, end: 1).animate(_ctrl);
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

  double _shakeOffset(double t) {
    const count = 4;
    return math.sin(t * count * math.pi) * 10;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, child) => Transform.translate(
          offset: Offset(_shakeOffset(_anim.value), 0),
          child: child,
        ),
        child: widget.child,
      );
}
