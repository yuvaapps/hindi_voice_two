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
  final List<_DrawnStroke?> _points = [];
  Color _selectedColor = const Color(0xFF1B5E20); // Deep Forest Emerald default
  double _strokeWidth = 9.0;
  bool _showGuide = true;
  bool _showCelebration = false;

  final List<Color> _chalkColors = const [
    Color(0xFF1B5E20), // Deep Forest Emerald
    Color(0xFF2E7D32), // Jade Green
    Color(0xFFFFB300), // Chalk Gold
    Color(0xFFC62828), // Crimson Red
    Color(0xFF3F51B5), // Indigo
    Color(0xFF212121), // Slate Charcoal
  ];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex.clamp(0, AppData.letters.length - 1);
  }

  void _nextLetter(AppViewModel vm) {
    final item = AppData.letters[_idx];
    vm.markCompleted('${item.letter}-${item.word}');
    setState(() {
      _showCelebration = true;
      _points.clear();
      _idx = (_idx + 1) % AppData.letters.length;
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showCelebration = false);
    });
  }

  void _prevLetter() {
    setState(() {
      _points.clear();
      _idx = (_idx - 1 + AppData.letters.length) % AppData.letters.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final item = AppData.letters[_idx];
    final isDone = vm.completedIds.contains('${item.letter}-${item.word}');
    final isLetterAudioPlaying = vm.isKeyPlaying('letter-${item.letter}');

    return StarStampCelebration(
      celebrate: _showCelebration,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F9F4),
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
                  '${_idx + 1}/${AppData.letters.length}',
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
            // Top Letter Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
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
                      child: Text(item.emoji, style: const TextStyle(fontSize: 28)),
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
                              'अक्षर: ${item.letter}',
                              style: const TextStyle(
                                fontSize: 22,
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
                          '${item.letter} से ${item.word} (${item.englishWord})',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AudioSoundwaveWave(
                    isPlaying: isLetterAudioPlaying,
                    waveColor: Colors.white,
                    child: BouncingWidget(
                      onTap: () => vm.playLetter(item),
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

            // Chalk Color Palette & Stroke Thickness Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _chalkColors.map((c) {
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
                  // Thickness switch
                  PopupMenuButton<double>(
                    tooltip: 'Chalk Thickness',
                    initialValue: _strokeWidth,
                    onSelected: (val) => setState(() => _strokeWidth = val),
                    itemBuilder: (ctx) => const [
                      PopupMenuItem(value: 5.0, child: Text('Fine (5px)')),
                      PopupMenuItem(value: 9.0, child: Text('Medium Chalk (9px)')),
                      PopupMenuItem(value: 15.0, child: Text('Thick Chalk (15px)')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.brush, size: 16, color: AppTheme.primaryColor),
                          const SizedBox(width: 4),
                          Text(
                            '${_strokeWidth.toInt()}px',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tracing Notebook Canvas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.green.shade200, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: NotebookRuledBackground(
                      child: Stack(
                        children: [
                          // Watermark / Guide Letter
                          if (_showGuide)
                            Positioned.fill(
                              child: ChalkGlowAura(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.letter,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 160,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green.shade100.withOpacity(0.65),
                                        ),
                                      ),
                                      Text(
                                        '${item.emoji}  ${item.letter} से ${item.word}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          // Interactive Drawing Canvas
                          Positioned.fill(
                            child: GestureDetector(
                              onPanUpdate: (d) {
                                setState(() {
                                  _points.add(_DrawnStroke(
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
                                painter: _LetterCanvasPainter(points: _points),
                                size: Size.infinite,
                              ),
                            ),
                          ),

                          // Notebook corner indicator
                          Positioned(
                            top: 10,
                            right: 14,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.edit_note, size: 14, color: AppTheme.primaryColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    'नोटबुक पृष्ठ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
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
            ),

            const SizedBox(height: 12),

            // Navigation and Actions Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Previous Letter
                  BouncingWidget(
                    onTap: _prevLetter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Clear Canvas
                  BouncingWidget(
                    onTap: () => setState(() => _points.clear()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.refresh, size: 18, color: AppTheme.primaryColor),
                          const SizedBox(width: 6),
                          Text(
                            'साफ़ करें',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Next Letter & Award
                  Expanded(
                    child: BouncingWidget(
                      onTap: () => _nextLetter(vm),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1B5E20).withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'अगला अक्षर',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
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

class _DrawnStroke {
  final Offset offset;
  final Color color;
  final double strokeWidth;

  _DrawnStroke({
    required this.offset,
    required this.color,
    required this.strokeWidth,
  });
}

class _LetterCanvasPainter extends CustomPainter {
  final List<_DrawnStroke?> points;

  _LetterCanvasPainter({required this.points});

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
  bool shouldRepaint(covariant _LetterCanvasPainter oldDelegate) => true;
}
