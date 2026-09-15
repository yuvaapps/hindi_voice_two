
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
  int _idx = 0;
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final item = AppData.letters[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.letter, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.letterAudio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: const Text('साफ़ करें')),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(painter: _LetterPainter(_points, item.letter), size: Size.infinite),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.letter);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.letters.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला अक्षर'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterPainter extends CustomPainter {
  final List<Offset?> points;
  final String letter;
  _LetterPainter(this.points, this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: letter, style: TextStyle(fontSize: 160, color: Colors.orange.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.deepOrange..strokeCap = StrokeCap.round..strokeWidth = 10.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
