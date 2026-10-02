import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../models/practice_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialIndex;
  const LearningScreen({super.key, this.initialIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _Stroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  _Stroke(this.points, this.color, this.strokeWidth);
}

class _LearningScreenState extends State<LearningScreen> {
  late int _idx;
  final List<_Stroke> _strokes = [];
  _Stroke? _currentStroke;

  Color _selectedColor = AppTheme.primaryColor;
  double _selectedStrokeWidth = 8.0;
  bool _showGuidelines = true;
  bool _showWatermark = true;
  bool _showConfetti = false;

  final TextEditingController _searchController = TextEditingController();

  static const List<Color> _penColors = [
    Color(0xFFD81B60), // Berry
    Color(0xFF8E24AA), // Violet
    Color(0xFF1976D2), // Royal Blue
    Color(0xFF2E7D32), // Forest Green
    Color(0xFFF57C00), // Amber Orange
    Color(0xFF212121), // Charcoal Ink
  ];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex.clamp(0, AppData.items.length - 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final vm = context.read<AppViewModel>();
        if (vm.soundEnabled) {
          vm.playItem(AppData.items[_idx]);
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToIndex(int newIdx, {bool triggerConfetti = false}) {
    if (newIdx < 0 || newIdx >= AppData.items.length) return;
    setState(() {
      _idx = newIdx;
      _strokes.clear();
      _currentStroke = null;
      if (triggerConfetti) {
        _showConfetti = true;
      }
    });

    final vm = context.read<AppViewModel>();
    if (vm.soundEnabled) {
      vm.playItem(AppData.items[_idx]);
    }
  }

  void _nextItem() {
    final vm = context.read<AppViewModel>();
    final currentItem = AppData.items[_idx];
    vm.markCompleted(currentItem.id);
    _goToIndex((_idx + 1) % AppData.items.length, triggerConfetti: true);
  }

  void _prevItem() {
    _goToIndex((_idx - 1 + AppData.items.length) % AppData.items.length);
  }

  void _shuffleItem() {
    final rand = math.Random();
    int newIdx = rand.nextInt(AppData.items.length);
    if (newIdx == _idx && AppData.items.length > 1) {
      newIdx = (newIdx + 1) % AppData.items.length;
    }
    _goToIndex(newIdx);
  }

  void _showCategoryDialog() {
    // Collect unique categories in order
    final categories = <String>[];
    for (final item in AppData.items) {
      if (!categories.contains(item.category)) {
        categories.add(item.category);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'कार्यपुस्तिका श्रेणियाँ (Categories)',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: categories.length,
                    itemBuilder: (context, i) {
                      final cat = categories[i];
                      final firstIndex = AppData.items.indexWhere((it) => it.category == cat);
                      final count = AppData.items.where((it) => it.category == cat).length;
                      final isCurrent = AppData.items[_idx].category == cat;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCurrent ? AppTheme.primaryColor : const Color(0xFFFCE4EC),
                          foregroundColor: isCurrent ? Colors.white : AppTheme.primaryColor,
                          child: Text('${i + 1}'),
                        ),
                        title: Text(cat, style: TextStyle(fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500)),
                        subtitle: Text('$count अभ्यास (Exercises)'),
                        trailing: isCurrent ? const Icon(Icons.check_circle, color: AppTheme.primaryColor) : null,
                        onTap: () {
                          Navigator.pop(ctx);
                          if (firstIndex != -1) {
                            _goToIndex(firstIndex);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        String filter = '';
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            final matches = AppData.items.where((it) {
              if (filter.isEmpty) return false;
              final q = filter.toLowerCase().trim();
              return it.hindi.toLowerCase().contains(q) ||
                  it.english.toLowerCase().contains(q) ||
                  it.category.toLowerCase().contains(q);
            }).take(40).toList();

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('शब्द या अक्षर खोजें', style: TextStyle(color: AppTheme.primaryColor)),
              content: SizedBox(
                width: double.maxFinite,
                height: 420,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'उदा. कमल, आम, क, जल...',
                        prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                        filled: true,
                        fillColor: const Color(0xFFFCE4EC).withOpacity(0.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setDialogState(() => filter = '');
                                },
                              )
                            : null,
                      ),
                      onChanged: (val) {
                        setDialogState(() => filter = val);
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: matches.isEmpty
                          ? Center(
                              child: Text(
                                filter.isEmpty ? '1300+ अभ्यास में से खोजें' : 'कोई मेल नहीं मिला',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            )
                          : ListView.builder(
                              itemCount: matches.length,
                              itemBuilder: (context, i) {
                                final item = matches[i];
                                final originalIdx = AppData.items.indexOf(item);
                                return ListTile(
                                  dense: true,
                                  leading: Text(item.emoji, style: const TextStyle(fontSize: 24)),
                                  title: Text(item.hindi, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  subtitle: Text('${item.english} • ${item.category}'),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    _goToIndex(originalIdx);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('बंद करें'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final item = AppData.items[_idx];
    final isDone = vm.completedIds.contains(item.id);
    final isAudioPlaying = vm.isItemPlaying(item.id);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('अभ्यास ${_idx + 1} / ${AppData.items.length}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Text(item.category, style: const TextStyle(fontSize: 11, color: Colors.white70)),
          ],
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'रैंडम अभ्यास',
            icon: const Icon(Icons.shuffle),
            onPressed: _shuffleItem,
          ),
          IconButton(
            tooltip: 'खोजें',
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            tooltip: 'श्रेणियाँ',
            icon: const Icon(Icons.menu_book),
            onPressed: _showCategoryDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              child: Column(
                children: [
                  // Item Information Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        FloatingAnimation(
                          offset: 4,
                          duration: const Duration(milliseconds: 1400),
                          child: Text(item.emoji, style: const TextStyle(fontSize: 40)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      item.hindi,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF880E4F),
                                      ),
                                    ),
                                  ),
                                  if (isDone) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.verified, color: Colors.amber, size: 22),
                                  ],
                                ],
                              ),
                              Text(
                                item.english,
                                style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        // Voice Button
                        BouncingWidget(
                          onTap: () => vm.playItem(item),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isAudioPlaying ? AppTheme.primaryColor : const Color(0xFFFCE4EC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.volume_up,
                                  color: isAudioPlaying ? Colors.white : AppTheme.primaryColor,
                                  size: 24,
                                ),
                                const SizedBox(width: 6),
                                AudioSoundwaveWave(
                                  isPlaying: isAudioPlaying,
                                  color: isAudioPlaying ? Colors.white : AppTheme.primaryColor,
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Handwriting Practice Slate Canvas
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.35), width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: Stack(
                          children: [
                            // Notebook ruled lines
                            if (_showGuidelines)
                              Positioned.fill(
                                child: CustomPaint(painter: WorkbookLinesPainter()),
                              ),

                            // Watermark / Guide Word to trace
                            if (_showWatermark)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      item.hindi,
                                      style: TextStyle(
                                        fontSize: 130,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFF8BBD0).withOpacity(0.45),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Drawing interaction layer
                            GestureDetector(
                              onPanStart: (details) {
                                setState(() {
                                  _currentStroke = _Stroke(
                                    [details.localPosition],
                                    _selectedColor,
                                    _selectedStrokeWidth,
                                  );
                                  _strokes.add(_currentStroke!);
                                });
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  _currentStroke?.points.add(details.localPosition);
                                });
                              },
                              onPanEnd: (_) {
                                _currentStroke = null;
                              },
                              child: CustomPaint(
                                painter: _MultiStrokePainter(_strokes),
                                size: Size.infinite,
                              ),
                            ),

                            // Canvas Overlay Controls (Guide lines, Watermark, Undo, Clear)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Row(
                                children: [
                                  IconButton(
                                    iconSize: 20,
                                    tooltip: 'गाइड रेखाएं',
                                    icon: Icon(_showGuidelines ? Icons.grid_on : Icons.grid_off, color: Colors.grey.shade600),
                                    onPressed: () => setState(() => _showGuidelines = !_showGuidelines),
                                  ),
                                  IconButton(
                                    iconSize: 20,
                                    tooltip: 'वाटरमार्क गाइड',
                                    icon: Icon(_showWatermark ? Icons.visibility : Icons.visibility_off, color: Colors.grey.shade600),
                                    onPressed: () => setState(() => _showWatermark = !_showWatermark),
                                  ),
                                  IconButton(
                                    iconSize: 20,
                                    tooltip: 'वापस (Undo)',
                                    icon: Icon(Icons.undo, color: _strokes.isNotEmpty ? Colors.grey.shade800 : Colors.grey.shade300),
                                    onPressed: _strokes.isNotEmpty
                                        ? () => setState(() => _strokes.removeLast())
                                        : null,
                                  ),
                                  IconButton(
                                    iconSize: 20,
                                    tooltip: 'स्लेट साफ़ करें',
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                    onPressed: () => setState(() => _strokes.clear()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Pen Color & Thickness Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Pen Colors
                        Row(
                          children: _penColors.map((color) {
                            final isSelected = _selectedColor == color;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedColor = color),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: isSelected ? 30 : 24,
                                height: isSelected ? 30 : 24,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? Colors.pink.shade900 : Colors.transparent,
                                    width: 2.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 6)]
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Thickness Picker
                        Row(
                          children: [
                            _thicknessButton(4.0, 'पतला'),
                            const SizedBox(width: 4),
                            _thicknessButton(8.0, 'मध्यम'),
                            const SizedBox(width: 4),
                            _thicknessButton(14.0, 'मोटा'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Bottom Navigation: Previous, Counter, Next Exercise
                  Row(
                    children: [
                      BouncingWidget(
                        onTap: _prevItem,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppTheme.primaryColor),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: BouncingWidget(
                          onTap: _nextItem,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'अगला अभ्यास',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
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
          ),

          // Celebration Confetti Layer
          CelebrationConfettiBurst(
            isTriggered: _showConfetti,
            onFinished: () => setState(() => _showConfetti = false),
          ),
        ],
      ),
    );
  }

  Widget _thicknessButton(double width, String label) {
    final isSelected = _selectedStrokeWidth == width;
    return GestureDetector(
      onTap: () => setState(() => _selectedStrokeWidth = width),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFCE4EC) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}

class _MultiStrokePainter extends CustomPainter {
  final List<_Stroke> strokes;
  _MultiStrokePainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;
      final paint = Paint()
        ..color = stroke.color
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = stroke.strokeWidth;

      if (stroke.points.length == 1) {
        canvas.drawCircle(stroke.points.first, stroke.strokeWidth / 2, paint);
      } else {
        for (int i = 0; i < stroke.points.length - 1; i++) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _MultiStrokePainter oldDelegate) => true;
}
