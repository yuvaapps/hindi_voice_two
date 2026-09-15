
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_wordIdx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('write_word')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(word.hindi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: AppTheme.primaryColor),
                  onPressed: () => vm.playWordAudio(word),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _points.clear()),
                  child: Text(loc.translate('clear')),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
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
                    painter: _SlatePainter(_points, word.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _points.clear();
                  _wordIdx = (_wordIdx + 1) % AppData.words.length;
                });
                vm.markCompleted(word.id);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next_page')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlatePainter extends CustomPainter {
  final List<Offset?> points;
  final String guideText;
  _SlatePainter(this.points, this.guideText);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw guide background text
    final textPainter = TextPainter(
      text: TextSpan(
        text: guideText,
        style: TextStyle(fontSize: 90, color: Colors.grey.shade200, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));

    // Draw user strokes
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
