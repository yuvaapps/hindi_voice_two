
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
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

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final name = AppData.names[_idx];

    final content = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.hindi, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppTheme.textColor)),
                    Text(name.english, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                IconButton.filled(
                  onPressed: () => vm.playNameAudio(name),
                  icon: const Icon(Icons.volume_up, size: 28),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _strokes.clear()),
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
                  border: Border.all(color: Colors.cyan.shade200, width: 3),
                ),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() => _strokes.add(details.localPosition));
                  },
                  onPanEnd: (_) => _strokes.add(null),
                  child: CustomPaint(
                    painter: _NameTracePainter(_strokes, name.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(name.id);
                setState(() {
                  _strokes.clear();
                  _idx = (_idx + 1) % AppData.names.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      );

    if (widget.isTab) return SafeArea(child: content);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: SafeArea(child: content),
    );
  }
}

class _NameTracePainter extends CustomPainter {
  final List<Offset?> strokes;
  final String text;
  _NameTracePainter(this.strokes, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    // Dotted guide
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 70, color: Colors.cyan.shade100, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));

    final paint = Paint()
      ..color = Colors.cyan.shade800
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.0;

    for (int i = 0; i < strokes.length - 1; i++) {
      if (strokes[i] != null && strokes[i + 1] != null) {
        canvas.drawLine(strokes[i]!, strokes[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
