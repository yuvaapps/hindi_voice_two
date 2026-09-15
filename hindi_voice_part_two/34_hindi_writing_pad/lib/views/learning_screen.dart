
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final List<Offset?> _points = [];
  Color _penColor = Colors.white;
  final double _strokeWidth = 6.0;
  int _selectedPromptIdx = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final prompt = AppData.prompts[_selectedPromptIdx];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('app_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () => vm.playAudio(prompt.audio),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _points.clear()),
          ),
        ],
      ),
      body: Column(
        children: [
          // Prompt horizontal bar
          Container(
            height: 52,
            color: Colors.black26,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppData.prompts.length,
              itemBuilder: (context, idx) {
                final isSel = idx == _selectedPromptIdx;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: ChoiceChip(
                    label: Text(AppData.prompts[idx].text, style: const TextStyle(fontSize: 18)),
                    selected: isSel,
                    onSelected: (_) {
                      setState(() {
                        _selectedPromptIdx = idx;
                        _points.clear();
                      });
                      vm.playAudio(AppData.prompts[idx].audio);
                      vm.markCompleted(AppData.prompts[idx].text);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1B262C),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24, width: 3),
              ),
              child: GestureDetector(
                onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                onPanEnd: (_) => _points.add(null),
                child: CustomPaint(
                  painter: _ChalkPainter(_points, _penColor, _strokeWidth, prompt.text),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          // Chalk controls
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorDot(Colors.white),
                _colorDot(Colors.yellow),
                _colorDot(Colors.cyan),
                _colorDot(Colors.pinkAccent),
                _colorDot(Colors.limeAccent),
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: () {
                    if (_points.isNotEmpty) {
                      setState(() {
                        _points.removeLast();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color c) {
    final isSel = _penColor == c;
    return GestureDetector(
      onTap: () => setState(() => _penColor = c),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: isSel ? Colors.blue : Colors.transparent, width: 3),
        ),
      ),
    );
  }
}

class _ChalkPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double width;
  final String watermark;
  _ChalkPainter(this.points, this.color, this.width, this.watermark);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: watermark, style: TextStyle(fontSize: 120, color: Colors.white.withAlpha(20), fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = color..strokeCap = StrokeCap.round..strokeWidth = width;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
