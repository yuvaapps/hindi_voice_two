import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialIndex;
  const LearningScreen({super.key, this.initialIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final List<_ChalkPoint?> _points = [];
  Color _penColor = const Color(0xFFFFD600); // Sunflower Yellow Chalk default
  double _strokeWidth = 8.0;
  bool _isEraser = false;
  bool _showWatermark = true;
  bool _showCelebration = false;
  late int _selectedPromptIdx;

  final List<Color> _chalkColors = const [
    Color(0xFFFFFFFF), // Pure White
    Color(0xFFFFD600), // Sunflower Yellow
    Color(0xFF00E5FF), // Electric Cyan
    Color(0xFFFF4081), // Neon Pink
    Color(0xFF76FF03), // Lime Green
    Color(0xFFFF6D00), // Bright Orange
    Color(0xFFE040FB), // Lavender Violet
  ];

  @override
  void initState() {
    super.initState();
    _selectedPromptIdx = widget.initialIndex.clamp(0, AppData.prompts.length - 1);
  }

  void _nextPrompt(AppViewModel vm) {
    final prompt = AppData.prompts[_selectedPromptIdx];
    vm.markCompleted(prompt.text);
    setState(() {
      _showCelebration = true;
      _points.clear();
      _selectedPromptIdx = (_selectedPromptIdx + 1) % AppData.prompts.length;
    });

    Future.delayed(const Duration(milliseconds: 1300), () {
      if (mounted) setState(() => _showCelebration = false);
    });
  }

  void _prevPrompt() {
    setState(() {
      _points.clear();
      _selectedPromptIdx = (_selectedPromptIdx - 1 + AppData.prompts.length) % AppData.prompts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final prompt = AppData.prompts[_selectedPromptIdx];
    final isDone = vm.completedIds.contains(prompt.text);
    final isPlaying = vm.isKeyPlaying(prompt.text);

    return ChalkSparkleBurst(
      celebrate: _showCelebration,
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBg,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.translate('app_title'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${_selectedPromptIdx + 1}/${AppData.prompts.length}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Watermark Guide',
              icon: Icon(_showWatermark ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _showWatermark = !_showWatermark),
            ),
            IconButton(
              tooltip: 'Clear Slate',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => setState(() => _points.clear()),
            ),
            IconButton(
              tooltip: 'Search Prompts',
              icon: const Icon(Icons.search),
              onPressed: () => _showSearchModal(context),
            ),
          ],
        ),
        body: Column(
          children: [
            // Top Prompt Info Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppTheme.cardColor,
              child: Row(
                children: [
                  FloatingAnimation(
                    offset: 3,
                    child: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.accentColor.withOpacity(0.5)),
                      ),
                      child: Text(prompt.emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              prompt.text,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isDone)
                              const Icon(Icons.check_circle, color: Color(0xFF76FF03), size: 18),
                          ],
                        ),
                        if (prompt.english.isNotEmpty)
                          Text(
                            prompt.english,
                            style: const TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                      ],
                    ),
                  ),
                  // Voice Button with AudioSoundwaveWave
                  AudioSoundwaveWave(
                    isPlaying: isPlaying,
                    waveColor: AppTheme.accentColor,
                    child: BouncingWidget(
                      onTap: () => vm.playPrompt(prompt),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.volume_up, color: Colors.black87, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Prompt Carousel
            Container(
              height: 48,
              color: const Color(0xFF1F292E),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: AppData.prompts.length,
                itemBuilder: (context, idx) {
                  final p = AppData.prompts[idx];
                  final isSel = idx == _selectedPromptIdx;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPromptIdx = idx;
                          _points.clear();
                        });
                        vm.playPrompt(p);
                        vm.markCompleted(p.text);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.accentColor : Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSel ? AppTheme.accentColor : Colors.white12,
                          ),
                        ),
                        child: Text(
                          p.text,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSel ? Colors.black87 : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Chalkboard Slate Canvas
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF151D21), // Authentic Deep Slate Black
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF455A64), width: 3.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: Stack(
                    children: [
                      // Watermark Guide
                      if (_showWatermark)
                        Positioned.fill(
                          child: ChalkGlowAura(
                            child: Center(
                              child: Text(
                                prompt.text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: prompt.text.length > 5 ? 60 : 130,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Interactive Drawing Canvas
                      Positioned.fill(
                        child: GestureDetector(
                          onPanUpdate: (d) {
                            setState(() {
                              _points.add(_ChalkPoint(
                                offset: d.localPosition,
                                color: _isEraser ? const Color(0xFF151D21) : _penColor,
                                strokeWidth: _isEraser ? 24.0 : _strokeWidth,
                              ));
                            });
                          },
                          onPanEnd: (_) {
                            setState(() => _points.add(null));
                          },
                          child: CustomPaint(
                            painter: _ChalkSlatePainter(points: _points),
                            size: Size.infinite,
                          ),
                        ),
                      ),

                      // Corner Slate Badge
                      Positioned(
                        top: 10,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            prompt.category,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF00E5FF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Chalk Controls Toolbar (Colors, Eraser, Width, Undo)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: AppTheme.cardColor,
              child: Row(
                children: [
                  // Chalk Colors
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _chalkColors.map((c) {
                          final isSel = !_isEraser && _penColor == c;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEraser = false;
                                _penColor = c;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 8),
                              width: isSel ? 32 : 24,
                              height: isSel ? 32 : 24,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSel ? Colors.white : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  if (isSel)
                                    BoxShadow(
                                      color: c.withOpacity(0.6),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Eraser Toggle
                  BouncingWidget(
                    onTap: () => setState(() => _isEraser = !_isEraser),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: _isEraser ? const Color(0xFFFF4081) : Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cleaning_services,
                            size: 16,
                            color: _isEraser ? Colors.white : Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'डस्टर',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _isEraser ? Colors.white : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Stroke Width Menu
                  PopupMenuButton<double>(
                    tooltip: 'Chalk Thickness',
                    initialValue: _strokeWidth,
                    onSelected: (w) => setState(() => _strokeWidth = w),
                    itemBuilder: (ctx) => const [
                      PopupMenuItem(value: 4.0, child: Text('Fine (4px)')),
                      PopupMenuItem(value: 8.0, child: Text('Medium (8px)')),
                      PopupMenuItem(value: 14.0, child: Text('Bold (14px)')),
                    ],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_strokeWidth.toInt()}px',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Undo Button
                  IconButton(
                    tooltip: 'Undo Stroke',
                    icon: const Icon(Icons.undo, color: Colors.white70),
                    onPressed: () {
                      if (_points.isNotEmpty) {
                        setState(() {
                          while (_points.isNotEmpty && _points.last != null) {
                            _points.removeLast();
                          }
                          if (_points.isNotEmpty && _points.last == null) {
                            _points.removeLast();
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            // Bottom Navigation (Prev / Next)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  BouncingWidget(
                    onTap: _prevPrompt,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BouncingWidget(
                      onTap: () => _nextPrompt(vm),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFD600), Color(0xFFFFAB00)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'अगला शब्द / अक्षर',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        String query = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = AppData.prompts.where((p) {
              if (query.isEmpty) return true;
              final q = query.toLowerCase();
              return p.text.toLowerCase().contains(q) ||
                  p.english.toLowerCase().contains(q);
            }).toList();

            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search any word, letter, or number...',
                      prefixIcon: const Icon(Icons.search, color: AppTheme.accentColor),
                      fillColor: Colors.white10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => setModalState(() => query = val),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length > 80 ? 80 : filtered.length,
                      itemBuilder: (context, i) {
                        final p = filtered[i];
                        final origIdx = AppData.prompts.indexOf(p);
                        return ListTile(
                          leading: Text(p.emoji, style: const TextStyle(fontSize: 22)),
                          title: Text(p.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(p.english, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(p.category, style: const TextStyle(fontSize: 11, color: Color(0xFF00E5FF))),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedPromptIdx = origIdx;
                              _points.clear();
                            });
                            Navigator.pop(ctx);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ChalkPoint {
  final Offset offset;
  final Color color;
  final double strokeWidth;

  _ChalkPoint({
    required this.offset,
    required this.color,
    required this.strokeWidth,
  });
}

class _ChalkSlatePainter extends CustomPainter {
  final List<_ChalkPoint?> points;

  _ChalkSlatePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];

      if (p1 != null && p2 != null) {
        final paint = Paint()
          ..color = p1.color
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = p1.strokeWidth;
        canvas.drawLine(p1.offset, p2.offset, paint);
      } else if (p1 != null && p2 == null) {
        final paint = Paint()
          ..color = p1.color
          ..style = PaintingStyle.fill;
        canvas.drawCircle(p1.offset, p1.strokeWidth / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ChalkSlatePainter oldDelegate) => true;
}
