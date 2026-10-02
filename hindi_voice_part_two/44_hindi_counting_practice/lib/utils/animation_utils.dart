import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// 1. Bouncing Widget
// ─────────────────────────────────────────────
class BouncingWidget extends StatefulWidget {
  final Widget child;
  final bool animate;
  const BouncingWidget({super.key, required this.child, this.animate = true});
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
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: -14).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (!widget.animate) return widget.child;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _anim.value), child: child),
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────
// 2. Audio Sound-wave Widget
// ─────────────────────────────────────────────
class AudioSoundwaveWave extends StatefulWidget {
  final bool isPlaying;
  final Color color;
  final int barCount;
  final double height;
  const AudioSoundwaveWave({
    super.key, required this.isPlaying,
    this.color = Colors.teal, this.barCount = 5, this.height = 40,
  });
  @override
  State<AudioSoundwaveWave> createState() => _AudioSoundwaveWaveState();
}
class _AudioSoundwaveWaveState extends State<AudioSoundwaveWave>
    with TickerProviderStateMixin {
  late List<AnimationController> _ctrls;
  late List<Animation<double>> _anims;
  final Random _rnd = Random();
  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(widget.barCount, (i) {
      final ms = 300 + _rnd.nextInt(400);
      return AnimationController(vsync: this, duration: Duration(milliseconds: ms))
        ..repeat(reverse: true);
    });
    _anims = _ctrls.map((c) =>
      Tween<double>(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut))).toList();
  }
  @override
  void dispose() { for (var c in _ctrls) c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) {
      return SizedBox(
        width: widget.barCount * 10.0,
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.barCount, (_) =>
            Container(width: 4, height: widget.height * 0.3,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4)))),
        ),
      );
    }
    return SizedBox(
      width: widget.barCount * 10.0,
      height: widget.height,
      child: AnimatedBuilder(
        animation: Listenable.merge(_ctrls),
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.barCount, (i) =>
            Container(
              width: 4,
              height: widget.height * _anims[i].value,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(4)))),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. Staggered Entrance
// ─────────────────────────────────────────────
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
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _ctrl.forward();
    });
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child));
}

// ─────────────────────────────────────────────
// 4. Number Pulse Aura
// ─────────────────────────────────────────────
class NumberPulseAura extends StatefulWidget {
  final Widget child;
  final bool active;
  final Color color;
  const NumberPulseAura({super.key, required this.child, this.active = false, this.color = Colors.teal});
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
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _opacity = Tween<double>(begin: 0.0, end: 0.35).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (!widget.active) return widget.child;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) => Stack(alignment: Alignment.center, children: [
        Container(
          width: 90 * _scale.value,
          height: 90 * _scale.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(_opacity.value)),
        ),
        child!,
      ]),
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────
// 5. Celebration Confetti Burst
// ─────────────────────────────────────────────
class ConfettiParticle {
  late double x, y, vx, vy, size, rotation, rotationSpeed;
  late Color color;
  ConfettiParticle(Random rnd, double w, double h) {
    x = rnd.nextDouble() * w;
    y = -20;
    vx = (rnd.nextDouble() - 0.5) * 6;
    vy = rnd.nextDouble() * 4 + 2;
    size = rnd.nextDouble() * 10 + 6;
    rotation = rnd.nextDouble() * pi * 2;
    rotationSpeed = (rnd.nextDouble() - 0.5) * 0.2;
    const colors = [
      Colors.red, Colors.blue, Colors.green, Colors.yellow,
      Colors.orange, Colors.purple, Colors.pink, Colors.teal,
    ];
    color = colors[rnd.nextInt(colors.length)];
  }
  void update() {
    x += vx; y += vy; vy += 0.1;
    rotation += rotationSpeed;
  }
}

class CelebrationConfettiBurst extends StatefulWidget {
  final bool active;
  final Widget child;
  const CelebrationConfettiBurst({super.key, required this.active, required this.child});
  @override
  State<CelebrationConfettiBurst> createState() => _CelebrationConfettiBurstState();
}
class _CelebrationConfettiBurstState extends State<CelebrationConfettiBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<ConfettiParticle> _particles = [];
  final Random _rnd = Random();
  Timer? _stopTimer;
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 16))
      ..addListener(_tick);
  }

  @override
  void didUpdateWidget(covariant CelebrationConfettiBurst oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) _start();
  }

  void _start() {
    _particles.clear();
    for (int i = 0; i < 80; i++) {
      _particles.add(ConfettiParticle(_rnd, _size.width, _size.height));
    }
    _ctrl.repeat();
    _stopTimer?.cancel();
    _stopTimer = Timer(const Duration(seconds: 3), () {
      _ctrl.stop();
      if (mounted) setState(() => _particles.clear());
    });
  }

  void _tick() {
    for (final p in _particles) p.update();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _stopTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (ctx, constraints) {
      _size = Size(constraints.maxWidth, constraints.maxHeight);
      return Stack(children: [
        widget.child,
        if (_particles.isNotEmpty)
          Positioned.fill(
            child: CustomPaint(painter: _ConfettiPainter(_particles)),
          ),
      ]);
    });
}

class _ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  _ConfettiPainter(this.particles);
  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      if (p.y > size.height + 20) continue;
      final paint = Paint()..color = p.color;
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5),
        paint);
      canvas.restore();
    }
  }
  @override
  bool shouldRepaint(covariant _ConfettiPainter old) => true;
}
