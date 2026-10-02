import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final List<Offset?> _points = [];
  int _wordIdx = 0;
  bool _showCelebration = false;
  Color _penColor = const Color(0xFFFF6D00); // Default Orange pen

  final List<Color> _penColors = [
    const Color(0xFFFF6D00), // Vibrant Tangerine
    const Color(0xFFE65100), // Deep Rust Orange
    const Color(0xFFD84315), // Crimson Amber
    const Color(0xFF2E7D32), // Emerald
    const Color(0xFF1565C0), // Royal Blue
    const Color(0xFF37474F), // Slate Graphite
  ];

  void _triggerCelebration() {
    setState(() => _showCelebration = true);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _showCelebration = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_wordIdx];
    final isHindi = vm.locale.languageCode == 'hi';
    final isPlaying = vm.currentPlayingId == word.id;

    return ConfettiCelebrationOverlay(
      celebrate: _showCelebration,
      child: Scaffold(
        backgroundColor: AppTheme.notebookBg,
        appBar: AppBar(
          title: Text(loc.translate('write_word'), style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  '${_wordIdx + 1} / ${AppData.words.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top Card: Word & Audio & Clear
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(word.emoji, style: const TextStyle(fontSize: 34)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              word.hindi,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textColor,
                              ),
                            ),
                            Text(
                              word.english,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.subtitleColor.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AudioRippleEffect(
                        isPlaying: isPlaying,
                        rippleColor: AppTheme.primaryColor,
                        child: BouncingWidget(
                          onTap: () => vm.playWordAudio(word),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryLight,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.primaryColor, width: 1.5),
                            ),
                            child: const Icon(
                              Icons.volume_up_rounded,
                              color: AppTheme.primaryColor,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      BouncingWidget(
                        onTap: () {
                          setState(() => _points.clear());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFFFCDD2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline_rounded, size: 16, color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                loc.translate('clear'),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Pen color palette row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isHindi ? 'कलम रंग:' : 'Pen Color:',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.subtitleColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ..._penColors.map((c) {
                      final isSelected = _penColor == c;
                      return GestureDetector(
                        onTap: () => setState(() => _penColor = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isSelected ? 26 : 20,
                          height: isSelected ? 26 : 20,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.transparent,
                              width: 2.5,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: c.withOpacity(0.5),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    }),
                  ],
                ),

                const SizedBox(height: 12),

                // Practice Slate Canvas (Notebook style with guide tracing)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFFFCC80), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            final renderBox = context.findRenderObject() as RenderBox?;
                            if (renderBox != null) {
                              _points.add(details.localPosition);
                            }
                          });
                        },
                        onPanEnd: (_) => _points.add(null),
                        child: CustomPaint(
                          painter: _SlateNotebookPainter(
                            points: _points,
                            guideText: word.hindi,
                            strokeColor: _penColor,
                          ),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Next Page Button with celebration & orange theme
                BouncingWidget(
                  onTap: () {
                    _triggerCelebration();
                    setState(() {
                      _points.clear();
                      _wordIdx = (_wordIdx + 1) % AppData.words.length;
                    });
                    vm.markCompleted(word.id);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: AppTheme.headerGradient,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          loc.translate('next_page'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SlateNotebookPainter extends CustomPainter {
  final List<Offset?> points;
  final String guideText;
  final Color strokeColor;

  _SlateNotebookPainter({
    required this.points,
    required this.guideText,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw notebook background ruled lines
    final marginPaint = Paint()
      ..color = const Color(0xFFFFAB91).withOpacity(0.35)
      ..strokeWidth = 1.5;
    canvas.drawLine(const Offset(34, 0), Offset(34, size.height), marginPaint);

    final linePaint = Paint()
      ..color = const Color(0xFFFFE0B2).withOpacity(0.3)
      ..strokeWidth = 1.0;
    const lineSpacing = 32.0;
    for (double y = 48.0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 2. Draw watermark guide tracing text in center
    final textPainter = TextPainter(
      text: TextSpan(
        text: guideText,
        style: TextStyle(
          fontSize: 96,
          color: const Color(0xFFFFCC80).withOpacity(0.38),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2),
    );

    // 3. Draw user finger handwriting strokes
    final paint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.5;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SlateNotebookPainter oldDelegate) => true;
}
