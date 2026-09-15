
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final item = AppData.items[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('अभ्यास ${_idx + 1} / ${AppData.items.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.emoji, style: const TextStyle(fontSize: 44)),
                Text(item.hindi, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.audio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: const Text('साफ़ करें')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(painter: _WorkbookPainter(_points, item.hindi), size: Size.infinite),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.id);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.items.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला अभ्यास'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkbookPainter extends CustomPainter {
  final List<Offset?> points;
  final String word;
  _WorkbookPainter(this.points, this.word);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: word, style: TextStyle(fontSize: 90, color: Colors.pink.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.pink.shade700..strokeCap = StrokeCap.round..strokeWidth = 8.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
