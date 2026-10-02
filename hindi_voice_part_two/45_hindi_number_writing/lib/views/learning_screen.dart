
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/num_write.dart';
import '../services/audio_service.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _categoryIndex = 0;
  int _itemIndex = 0;
  final List<Offset?> _points = [];
  bool _showConfetti = false;
  bool _brushColorOpen = false;
  Color _brushColor = const Color(0xFF1B5E20);
  double _brushSize = 10.0;
  final AudioService _audio = AudioService();

  final List<Color> _palette = [
    const Color(0xFF1B5E20), // dark green
    const Color(0xFF0D47A1), // dark blue
    const Color(0xFFB71C1C), // dark red
    const Color(0xFFF57F17), // amber
    const Color(0xFF4A148C), // deep purple
    Colors.black,
    Colors.teal.shade700,
    Colors.pink.shade700,
  ];

  List<NumWrite> get _currentList => AppData.getCategory(_categoryIndex);
  NumWrite get _item => _currentList[_itemIndex % _currentList.length];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextItem() {
    setState(() {
      _points.clear();
      _itemIndex = (_itemIndex + 1) % _currentList.length;
      _showConfetti = false;
    });
    context.read<AppViewModel>().markCompleted(_item.number);
  }

  void _prevItem() {
    setState(() {
      _points.clear();
      _itemIndex = (_itemIndex - 1 + _currentList.length) % _currentList.length;
      _showConfetti = false;
    });
  }

  void _onTapPlay() {
    _audio.playAudio(_item.audio);
    setState(() => _showConfetti = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showConfetti = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final totalCategories = AppData.categoryNames.length;

    final gradients = [
      [const Color(0xFF6C63FF), const Color(0xFF48CAE4)],
      [const Color(0xFFFF6584), const Color(0xFFFFBE76)],
      [const Color(0xFF43E97B), const Color(0xFF38F9D7)],
      [const Color(0xFFFA8231), const Color(0xFFF7B731)],
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFF953C6), const Color(0xFFB91D73)],
      [const Color(0xFF11998E), const Color(0xFF38EF7D)],
      [const Color(0xFFFC4A1A), const Color(0xFFF7B733)],
      [const Color(0xFF1A1A2E), const Color(0xFF16213E)],
      [const Color(0xFF0F3460), const Color(0xFFE94560)],
      [const Color(0xFF2ECC71), const Color(0xFF1ABC9C)],
    ];
    final grad = gradients[_categoryIndex % gradients.length];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text(
          AppData.categoryNames[_categoryIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.category_rounded),
            onPressed: _showCategoryPicker,
            tooltip: 'Category',
          ),
        ],
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Column(
            children: [
              // Category tabs (horizontal scroll)
              SizedBox(
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  itemCount: totalCategories,
                  itemBuilder: (ctx, i) {
                    final selected = i == _categoryIndex;
                    return GestureDetector(
                      onTap: () => setState(() {
                        _categoryIndex = i;
                        _itemIndex = 0;
                        _points.clear();
                        _showConfetti = false;
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected ? AppTheme.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: selected
                              ? [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.35), blurRadius: 8)]
                              : [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Row(
                          children: [
                            Text(AppData.categoryEmojis[i], style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 4),
                            Text(
                              AppData.categoryNames[i],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
                  child: Column(
                    children: [
                      // Word info card
                      StaggeredEntrance(
                        key: ValueKey('$_categoryIndex-$_itemIndex'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: grad,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: grad[0].withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NumberPulseAura(
                                      active: _showConfetti,
                                      color: Colors.white,
                                      child: Text(
                                        _item.devanagari,
                                        style: const TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _item.roman,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${_item.english}  •  ${_item.tamil}',
                                      style: const TextStyle(fontSize: 13, color: Colors.white60),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  // Play audio button
                                  GestureDetector(
                                    onTap: _onTapPlay,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.25),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.volume_up, color: Colors.white, size: 30),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: _audio.isPlayingNotifier,
                                    builder: (_, playing, __) => AudioSoundwaveWave(
                                      isPlaying: playing,
                                      color: Colors.white,
                                      barCount: 4,
                                      height: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Progress indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_itemIndex + 1} / ${_currentList.length}',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                          ),
                          Row(
                            children: [
                              // Brush color picker toggle
                              GestureDetector(
                                onTap: () => setState(() => _brushColorOpen = !_brushColorOpen),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: _brushColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                    boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Brush size slider
                              SizedBox(
                                width: 90,
                                child: Slider(
                                  value: _brushSize,
                                  min: 4,
                                  max: 20,
                                  activeColor: _brushColor,
                                  onChanged: (v) => setState(() => _brushSize = v),
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Clear button
                              GestureDetector(
                                onTap: () => setState(() => _points.clear()),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.red.shade200),
                                  ),
                                  child: Text(
                                    loc.translate('clear'),
                                    style: TextStyle(color: Colors.red.shade700, fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Brush color palette
                      if (_brushColorOpen)
                        Container(
                          height: 44,
                          margin: const EdgeInsets.only(bottom: 4),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _palette.length,
                            itemBuilder: (_, i) => GestureDetector(
                              onTap: () => setState(() {
                                _brushColor = _palette[i];
                                _brushColorOpen = false;
                              }),
                              child: Container(
                                width: 34,
                                height: 34,
                                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _palette[i],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _brushColor == _palette[i] ? Colors.white : Colors.transparent,
                                    width: 3,
                                  ),
                                  boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Writing canvas
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.teal.shade200, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: GestureDetector(
                              onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                              onPanEnd: (_) => _points.add(null),
                              child: CustomPaint(
                                painter: _WritePainter(_points, _item.devanagari, _brushColor, _brushSize),
                                size: Size.infinite,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Navigation buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _prevItem,
                              icon: const Icon(Icons.arrow_back_rounded),
                              label: const Text('Prev'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.primaryColor,
                                side: BorderSide(color: AppTheme.primaryColor),
                                minimumSize: const Size(0, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: _nextItem,
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: Text(loc.translate('next')),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(0, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: AppData.categoryNames.length,
        itemBuilder: (_, i) => ListTile(
          leading: Text(AppData.categoryEmojis[i], style: const TextStyle(fontSize: 26)),
          title: Text(
            AppData.categoryNames[i],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${AppData.getCategory(i).length} words'),
          trailing: i == _categoryIndex ? const Icon(Icons.check_circle, color: Colors.teal) : null,
          onTap: () {
            setState(() {
              _categoryIndex = i;
              _itemIndex = 0;
              _points.clear();
              _showConfetti = false;
            });
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }
}

class _WritePainter extends CustomPainter {
  final List<Offset?> points;
  final String devanagari;
  final Color brushColor;
  final double brushSize;
  _WritePainter(this.points, this.devanagari, this.brushColor, this.brushSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Ghost character guide
    final tp = TextPainter(
      text: TextSpan(
        text: devanagari,
        style: TextStyle(
          fontSize: 180,
          color: Colors.teal.shade50,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    // Grid lines for practice
    final gridPaint = Paint()
      ..color = Colors.teal.withOpacity(0.06)
      ..strokeWidth = 1;
    for (double y = 40; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 40; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // User strokes
    final paint = Paint()
      ..color = brushColor
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = brushSize
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      if (points[i] == null) continue;
      if (i == 0 || points[i - 1] == null) {
        path.moveTo(points[i]!.dx, points[i]!.dy);
      } else {
        path.lineTo(points[i]!.dx, points[i]!.dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WritePainter old) =>
      old.points != points || old.brushColor != brushColor || old.brushSize != brushSize;
}
