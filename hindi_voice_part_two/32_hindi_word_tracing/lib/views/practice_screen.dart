import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  final int initialIndex;
  const PracticeScreen({super.key, this.initialIndex = 0});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late int _idx;
  final List<_DrawnPoint?> _points = [];
  Color _selectedColor = const Color(0xFF3F51B5); // Royal Indigo default
  double _strokeWidth = 7.0;
  bool _showCelebration = false;
  bool _showGuide = true;

  final List<Color> _palette = const [
    Color(0xFF3F51B5), // Royal Indigo
    Color(0xFF2979FF), // Electric Blue
    Color(0xFF7C4DFF), // Deep Violet
    Color(0xFFE91E63), // Vibrant Pink
    Color(0xFFFF9800), // Bright Orange
    Color(0xFF00C853), // Emerald Green
  ];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex.clamp(0, AppData.words.length - 1);
  }

  void _nextWord(AppViewModel vm) {
    vm.markCompleted(AppData.words[_idx].id);
    setState(() {
      _showCelebration = true;
      _points.clear();
      _idx = (_idx + 1) % AppData.words.length;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showCelebration = false);
    });
  }

  void _prevWord() {
    setState(() {
      _points.clear();
      _idx = (_idx - 1 + AppData.words.length) % AppData.words.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_idx];
    final isDone = vm.completedIds.contains(word.id);
    final isAudioPlaying = vm.currentPlayingId == word.id;

    return ConfettiCelebrationOverlay(
      celebrate: _showCelebration,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F3FA),
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.translate('practice'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${_idx + 1}/${AppData.words.length}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              tooltip: 'Guide Watermark',
              icon: Icon(_showGuide ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _showGuide = !_showGuide),
            ),
            IconButton(
              tooltip: 'Clear Canvas',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => setState(() => _points.clear()),
            ),
          ],
        ),
        body: Column(
          children: [
            // Top Word Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  FloatingAnimation(
                    offset: 3,
                    child: Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Text(word.emoji, style: const TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              word.hindi,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isDone)
                              const Icon(Icons.check_circle, color: Colors.amberAccent, size: 20),
                          ],
                        ),
                        Text(
                          word.english,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AudioRippleEffect(
                    isPlaying: isAudioPlaying,
                    rippleColor: Colors.white,
                    child: BouncingWidget(
                      onTap: () => vm.playWordAudio(word),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.volume_up, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Color Palette & Pen Size Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _palette.map((c) {
                          final selected = _selectedColor == c;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColor = c),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 10),
                              width: selected ? 34 : 26,
                              height: selected ? 34 : 26,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected ? Colors.white : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  if (selected)
                                    BoxShadow(
                                      color: c.withOpacity(0.55),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                              child: selected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Pen thickness switch
                  PopupMenuButton<double>(
                    tooltip: 'Stroke Width',
                    initialValue: _strokeWidth,
                    onSelected: (val) => setState(() => _strokeWidth = val),
                    itemBuilder: (ctx) => const [
                      PopupMenuItem(value: 4.0, child: Text('Fine (4px)')),
                      PopupMenuItem(value: 7.0, child: Text('Medium (7px)')),
                      PopupMenuItem(value: 12.0, child: Text('Bold (12px)')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.shade100),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16, color: Colors.indigo.shade700),
                          const SizedBox(width: 4),
                          Text(
                            '${_strokeWidth.toInt()}px',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tracing Canvas Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.indigo.shade100, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Stack(
                      children: [
                        // Watermark / Guide Text
                        if (_showGuide)
                          Positioned.fill(
                            child: TraceGuideShimmer(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      word.hindi,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 78,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.indigo.shade50.withOpacity(0.95),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    Text(
                                      '${word.emoji}  ${word.english}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.indigo.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        // Interactive Drawing Surface
                        Positioned.fill(
                          child: GestureDetector(
                            onPanUpdate: (d) {
                              setState(() {
                                _points.add(_DrawnPoint(
                                  offset: d.localPosition,
                                  color: _selectedColor,
                                  strokeWidth: _strokeWidth,
                                ));
                              });
                            },
                            onPanEnd: (_) {
                              setState(() {
                                _points.add(null);
                              });
                            },
                            child: CustomPaint(
                              painter: _TraceCanvasPainter(points: _points),
                              size: Size.infinite,
                            ),
                          ),
                        ),

                        // Helpful watermark hint
                        Positioned(
                          top: 10,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.touch_app, size: 14, color: Colors.indigo.shade400),
                                const SizedBox(width: 4),
                                Text(
                                  'Trace here',
                                  style: TextStyle(fontSize: 11, color: Colors.indigo.shade600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Navigation and Actions Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Previous button
                  BouncingWidget(
                    onTap: _prevWord,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.indigo.shade700),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Clear Button
                  BouncingWidget(
                    onTap: () => setState(() => _points.clear()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.refresh, size: 18, color: Colors.indigo.shade700),
                          const SizedBox(width: 6),
                          Text(
                            loc.translate('clear'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Next Word & Complete Button
                  Expanded(
                    child: BouncingWidget(
                      onTap: () => _nextWord(vm),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3F51B5).withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              loc.translate('next'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _DrawnPoint {
  final Offset offset;
  final Color color;
  final double strokeWidth;

  _DrawnPoint({
    required this.offset,
    required this.color,
    required this.strokeWidth,
  });
}

class _TraceCanvasPainter extends CustomPainter {
  final List<_DrawnPoint?> points;

  _TraceCanvasPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (p1 != null && p2 != null) {
        final paint = Paint()
          ..color = p1.color
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = p1.strokeWidth;
        canvas.drawLine(p1.offset, p2.offset, paint);
      } else if (p1 != null && p2 == null) {
        final paint = Paint()
          ..color = p1.color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(p1.offset, p1.strokeWidth / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TraceCanvasPainter oldDelegate) => true;
}
