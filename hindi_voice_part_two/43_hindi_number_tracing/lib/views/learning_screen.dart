
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
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
    final loc = AppLocalizations.of(context);
    final item = AppData.numbers[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('${item.name} (${item.devanagari})'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${item.devanagari} = ${item.name}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.audio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: Text(loc.translate('clear'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _NumTracePainter(_points, item.devanagari),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.number);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.numbers.length;
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

class _NumTracePainter extends CustomPainter {
  final List<Offset?> points;
  final String devanagari;
  _NumTracePainter(this.points, this.devanagari);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: devanagari, style: TextStyle(fontSize: 200, color: Colors.pink.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.pink..strokeCap = StrokeCap.round..strokeWidth = 12.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
