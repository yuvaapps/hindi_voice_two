import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  final int initialIndex;
  final bool isTab;
  const PracticeScreen({super.key, this.initialIndex = 0, this.isTab = false});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late int _idx;
  final List<Offset?> _strokes = [];
  bool _celebrate = false;
  Color _penColor = const Color(0xFF0096C7); // Vivid Sea Teal

  final List<Color> _penColors = [
    const Color(0xFF0096C7), // Sea Teal
    const Color(0xFF0077B6), // Deep Ocean
    const Color(0xFF00B4D8), // Sky Cyan
    const Color(0xFF00E676), // Mint Emerald
    const Color(0xFFFF7043), // Warm Coral
    const Color(0xFF4A148C), // Royal Plum
  ];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex;
  }

  void _triggerCelebration() {
    setState(() => _celebrate = true);
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _celebrate = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final isHindi = vm.locale.languageCode == 'hi';
    final name = AppData.names[_idx % AppData.names.length];
    final isPlaying = vm.currentPlayingId == name.id;

    final content = ConfettiCelebrationOverlay(
      celebrate: _celebrate,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Card: Name Display & Audio
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF80DEEA), width: 1.5),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.hindi,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          '${name.english} • ${name.meaning}',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.subtitleColor.withOpacity(0.85),
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
                      onTap: () => vm.playNameAudio(name),
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
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  BouncingWidget(
                    onTap: () => setState(() => _strokes.clear()),
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

            // Pen Color Palette
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isHindi ? 'स्याही रंग / Ink:' : 'Ink Color:',
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

            // Calligraphy Tracing Canvas
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: const Color(0xFF80DEEA), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() => _strokes.add(details.localPosition));
                    },
                    onPanEnd: (_) => _strokes.add(null),
                    child: CustomPaint(
                      painter: _CalligraphyTracePainter(
                        strokes: _strokes,
                        guideText: name.hindi,
                        inkColor: _penColor,
                      ),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Navigation Row: Prev Name and Next Name
            Row(
              children: [
                Expanded(
                  child: BouncingWidget(
                    onTap: _idx > 0
                        ? () {
                            setState(() {
                              _strokes.clear();
                              _idx--;
                            });
                          }
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: _idx > 0 ? Colors.white : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _idx > 0 ? AppTheme.primaryColor : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_rounded, color: _idx > 0 ? AppTheme.primaryColor : Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            isHindi ? 'पिछला' : 'Prev',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: _idx > 0 ? AppTheme.primaryColor : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BouncingWidget(
                    onTap: () {
                      _triggerCelebration();
                      vm.markCompleted(name.id);
                      setState(() {
                        _strokes.clear();
                        _idx = (_idx + 1) % AppData.names.length;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: AppTheme.headerGradient,
                        borderRadius: BorderRadius.circular(16),
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
                          const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            loc.translate('next'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (widget.isTab) return SafeArea(child: content);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text('${loc.translate('practice')} (${_idx + 1}/${AppData.names.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(child: content),
    );
  }
}

class _CalligraphyTracePainter extends CustomPainter {
  final List<Offset?> strokes;
  final String guideText;
  final Color inkColor;

  _CalligraphyTracePainter({
    required this.strokes,
    required this.guideText,
    required this.inkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Watermark Guide text with cyan tint
    final textPainter = TextPainter(
      text: TextSpan(
        text: guideText,
        style: TextStyle(
          fontSize: 88,
          color: const Color(0xFFB2EBF2).withOpacity(0.65),
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

    // 2. User Calligraphy Ink Strokes
    final paint = Paint()
      ..color = inkColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.0;

    for (int i = 0; i < strokes.length - 1; i++) {
      if (strokes[i] != null && strokes[i + 1] != null) {
        canvas.drawLine(strokes[i]!, strokes[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CalligraphyTracePainter oldDelegate) => true;
}
