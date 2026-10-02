import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/num_trace.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class StrokeLine {
  final List<Offset> points;
  final Color color;
  final double width;
  StrokeLine({required this.points, required this.color, required this.width});
}

class LearningScreen extends StatefulWidget {
  final int initialIndex;
  const LearningScreen({super.key, this.initialIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late int _idx;
  final List<StrokeLine> _strokes = [];
  List<Offset>? _currentStroke;

  final List<Color> _brushColors = const [
    Color(0xFFE91E63), // Pink
    Color(0xFF00B0FF), // Sky Blue
    Color(0xFF00E676), // Bright Green
    Color(0xFFFFD54F), // Gold
    Color(0xFFFF6F00), // Amber
    Color(0xFF7C4DFF), // Purple
  ];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex.clamp(0, AppData.numbers.length - 1);
  }

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _currentStroke = null;
    });
  }

  void _undoStroke() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
      });
    }
  }

  void _selectNumber(int newIndex) {
    if (newIndex >= 0 && newIndex < AppData.numbers.length) {
      setState(() {
        _idx = newIndex;
        _strokes.clear();
        _currentStroke = null;
      });
      final item = AppData.numbers[newIndex];
      final vm = context.read<AppViewModel>();
      vm.playItem(item);
    }
  }

  void _completeAndNext() {
    final vm = context.read<AppViewModel>();
    final item = AppData.numbers[_idx];
    vm.markCompleted(item.number);
    vm.triggerConfetti();

    if (_idx < AppData.numbers.length - 1) {
      _selectNumber(_idx + 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎉 बधाई! आपने सभी संख्याएँ पूरी कर ली हैं!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';
    final currentItem = AppData.numbers[_idx];
    final isPlaying = vm.activeNumber == currentItem.number;
    final isDone = vm.completedIds.contains('${currentItem.number}');

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('app_title')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Test Audio Voice',
            onPressed: vm.testVoice,
            icon: const Icon(Icons.record_voice_over),
          ),
          IconButton(
            tooltip: vm.soundEnabled ? 'Mute' : 'Unmute',
            onPressed: vm.toggleSound,
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Horizontal Number Selector Strip
                Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.numbers.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final item = AppData.numbers[i];
                      final isSelected = i == _idx;
                      final isFinished = vm.completedIds.contains('${item.number}');

                      return BouncingWidget(
                        onTap: () => _selectNumber(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : (isFinished ? const Color(0xFFFCE4EC) : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : (isFinished ? const Color(0xFFF48FB1) : Colors.grey.shade300),
                              width: isSelected ? 1.8 : 1.0,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              Text(
                                item.devanagari,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${item.number})',
                                style: TextStyle(
                                  color: isSelected ? Colors.white.withOpacity(0.85) : Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Number Info Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${currentItem.devanagari} = ${currentItem.name}',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC2185B)),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '("${currentItem.transliteration}")',
                                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFFE65100)),
                              ),
                            ],
                          ),
                          Text(
                            '🇬🇧 ${currentItem.englishName} • 🇮🇳 தமிழ்: ${currentItem.tamilName}',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (isDone)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF43A047),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('Traced ⭐',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          const SizedBox(width: 6),
                          BouncingWidget(
                            onTap: () => vm.playItem(currentItem),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCE4EC),
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                              ),
                              child: isPlaying
                                  ? AudioSoundwaveWave(isPlaying: true, color: AppTheme.primaryColor, height: 16)
                                  : const Icon(Icons.volume_up, size: 20, color: AppTheme.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // Tracing Canvas Area
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TracingCanvasAura(
                      active: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0xFFF8BBD0), width: 2.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: GestureDetector(
                            onPanStart: (details) {
                              setState(() {
                                _currentStroke = [details.localPosition];
                                _strokes.add(
                                  StrokeLine(
                                    points: _currentStroke!,
                                    color: vm.strokeColor,
                                    width: vm.strokeWidth,
                                  ),
                                );
                              });
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                _currentStroke?.add(details.localPosition);
                              });
                            },
                            onPanEnd: (_) {
                              _currentStroke = null;
                            },
                            child: CustomPaint(
                              painter: _TraceCanvasPainter(
                                strokes: _strokes,
                                devanagari: currentItem.devanagari,
                                emoji: currentItem.emoji,
                                guideColor: const Color(0xFFFCE4EC),
                              ),
                              size: Size.infinite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Color Palette & Brush Size Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Brush Colors
                      Row(
                        children: _brushColors.map((c) {
                          final isSelected = vm.strokeColor == c;
                          return GestureDetector(
                            onTap: () => vm.setStrokeColor(c),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              margin: const EdgeInsets.only(right: 8),
                              width: isSelected ? 30 : 24,
                              height: isSelected ? 30 : 24,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.white : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: c.withOpacity(0.4),
                                    blurRadius: isSelected ? 6 : 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Tool Actions: Undo & Clear
                      Row(
                        children: [
                          BouncingWidget(
                            onTap: _undoStroke,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.undo, size: 20, color: Colors.black87),
                            ),
                          ),
                          const SizedBox(width: 8),
                          BouncingWidget(
                            onTap: _clearCanvas,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(loc.translate('clear'), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Bottom Dual Voice & Next Action Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Row(
                    children: [
                      // Hindi Voice Button
                      BouncingWidget(
                        onTap: () => vm.playHindi(currentItem),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE91E63), Color(0xFFC2185B)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE91E63).withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.volume_up, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text('हिन्दी Voice', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // English Voice Button
                      BouncingWidget(
                        onTap: () => vm.playEnglish(currentItem),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.primaryColor),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.record_voice_over, color: AppTheme.primaryColor, size: 16),
                              SizedBox(width: 4),
                              Text('English Voice',
                                  style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Complete & Next Button
                      Expanded(
                        child: BouncingWidget(
                          onTap: _completeAndNext,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF00B0FF), Color(0xFF0091EA)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00B0FF).withOpacity(0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isHindi ? 'पूर्ण & अगला' : 'Complete & Next',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CelebrationConfettiBurst(show: vm.showConfetti),
        ],
      ),
    );
  }
}

class _TraceCanvasPainter extends CustomPainter {
  final List<StrokeLine> strokes;
  final String devanagari;
  final String emoji;
  final Color guideColor;

  _TraceCanvasPainter({
    required this.strokes,
    required this.devanagari,
    required this.emoji,
    required this.guideColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw large background guiding template letter
    final tp = TextPainter(
      text: TextSpan(
        text: devanagari,
        style: TextStyle(
          fontSize: (size.height * 0.65).clamp(160, 280),
          color: const Color(0xFFFCE4EC),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final textOffset = Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2);
    tp.paint(canvas, textOffset);

    // 2. Draw dashed outline guide for tracing
    final outlineTp = TextPainter(
      text: TextSpan(
        text: devanagari,
        style: TextStyle(
          fontSize: (size.height * 0.65).clamp(160, 280),
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.0
            ..color = const Color(0xFFF48FB1).withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    outlineTp.paint(canvas, textOffset);

    // 3. Small emoji watermark in top-right
    final emojiTp = TextPainter(
      text: TextSpan(text: emoji, style: const TextStyle(fontSize: 32)),
      textDirection: TextDirection.ltr,
    )..layout();
    emojiTp.paint(canvas, Offset(size.width - emojiTp.width - 16, 16));

    // 4. Draw user strokes
    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;
      final paint = Paint()
        ..color = stroke.color
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = stroke.width;

      if (stroke.points.length == 1) {
        canvas.drawCircle(stroke.points[0], stroke.width / 2, paint);
      } else {
        for (int i = 0; i < stroke.points.length - 1; i++) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TraceCanvasPainter oldDelegate) => true;
}
