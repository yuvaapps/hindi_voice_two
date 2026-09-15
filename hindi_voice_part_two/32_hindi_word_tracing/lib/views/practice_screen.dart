
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
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
  final List<Offset?> _points = [];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(word.emoji, style: const TextStyle(fontSize: 40)),
                Text(word.hindi, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playWordAudio(word)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: Text(loc.translate('clear'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.shade200, width: 3),
                ),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _WordTracePainter(_points, word.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(word.id);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.words.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}

class _WordTracePainter extends CustomPainter {
  final List<Offset?> points;
  final String word;
  _WordTracePainter(this.points, this.word);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: word, style: TextStyle(fontSize: 84, color: Colors.indigo.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()
      ..color = Colors.indigo
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
