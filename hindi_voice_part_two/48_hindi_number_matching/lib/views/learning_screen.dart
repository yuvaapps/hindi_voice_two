import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/matching_pair.dart';
import '../services/audio_service.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialCategory;
  const LearningScreen({super.key, this.initialCategory = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _categoryIndex = 0;
  late List<MatchingPair> _currentPairs;
  late List<MatchingPair> _shuffledNames;
  int? _selectedNum;
  int? _selectedName;
  final Set<int> _matched = {};
  bool _showConfetti = false;
  bool _shakeWrong = false;
  int _roundCount = 1;
  final Random _rnd = Random();
  final AudioService _audio = AudioService();

  static const List<List<Color>> _categoryGradients = [
    [Color(0xFF00897B), Color(0xFF26A69A)], // Teal
    [Color(0xFF00796B), Color(0xFF4DB6AC)], // Deep Teal
    [Color(0xFF1976D2), Color(0xFF42A5F5)], // Blue
    [Color(0xFF7B1FA2), Color(0xFFAB47BC)], // Purple
    [Color(0xFFE65100), Color(0xFFFF9800)], // Orange
    [Color(0xFFC2185B), Color(0xFFEC407A)], // Pink (Animals)
    [Color(0xFFC62828), Color(0xFFEF5350)], // Red (Fruits)
    [Color(0xFF2E7D32), Color(0xFF66BB6A)], // Green (Veg)
    [Color(0xFF512DA8), Color(0xFF7E57C2)], // Indigo (Colors)
    [Color(0xFF00838F), Color(0xFF00ACC1)], // Cyan (Body)
    [Color(0xFFAD1457), Color(0xFFF06292)], // Rose (Family)
    [Color(0xFF283593), Color(0xFF5C6BC0)], // Navy (Transport)
    [Color(0xFF4527A0), Color(0xFF7E57C2)], // Violet (School)
    [Color(0xFF558B2F), Color(0xFF9CCC65)], // Lime (Nature)
    [Color(0xFFBF360C), Color(0xFFFF7043)], // Rust (Food)
  ];

  List<MatchingPair> get _currentPool => AppData.getCategory(_categoryIndex);
  List<Color> get _currentGradient =>
      _categoryGradients[_categoryIndex % _categoryGradients.length];

  @override
  void initState() {
    super.initState();
    _categoryIndex = widget.initialCategory;
    _loadRound();
  }

  void _loadRound() {
    final pool = _currentPool;
    if (pool.isEmpty) return;

    final shuffledPool = List<MatchingPair>.from(pool)..shuffle(_rnd);
    const count = 4;
    _currentPairs = shuffledPool.take(count).toList();
    _shuffledNames = List<MatchingPair>.from(_currentPairs)..shuffle(_rnd);
    _selectedNum = null;
    _selectedName = null;
    _matched.clear();
    _showConfetti = false;
    _shakeWrong = false;
    setState(() {});
  }

  void _onSelectNum(int n) {
    if (_matched.contains(n)) return;
    setState(() => _selectedNum = n);
    final item = _currentPairs.firstWhere((p) => p.number == n);
    _audio.playAudio(item.audio, textFallback: item.name);
    _checkMatch();
  }

  void _onSelectName(int n) {
    if (_matched.contains(n)) return;
    setState(() => _selectedName = n);
    final item = _currentPairs.firstWhere((p) => p.number == n);
    _audio.playAudio(item.audio, textFallback: item.name);
    _checkMatch();
  }

  void _checkMatch() {
    if (_selectedNum == null || _selectedName == null) return;

    final vm = context.read<AppViewModel>();
    final isCorrect = (_selectedNum == _selectedName);

    if (isCorrect) {
      final matchedNumber = _selectedNum!;
      final pair = _currentPairs.firstWhere((p) => p.number == matchedNumber);

      setState(() {
        _matched.add(matchedNumber);
        _selectedNum = null;
        _selectedName = null;
        _shakeWrong = false;
      });

      vm.recordMatch(number: matchedNumber, isCorrect: true);

      // If all matched, celebratory confetti & voice!
      if (_matched.length == _currentPairs.length) {
        setState(() => _showConfetti = true);
        if (vm.soundEnabled) {
          _audio.playAudio('assets/audio/hi/feedback_great.mp3',
              textFallback: 'शानदार मिलान!');
        }
      }
    } else {
      vm.recordMatch(number: _selectedNum!, isCorrect: false);
      setState(() => _shakeWrong = true);
      if (vm.soundEnabled) {
        _audio.playAudio('assets/audio/hi/feedback_try.mp3',
            textFallback: 'फिर से प्रयास करें');
      }

      Future.delayed(const Duration(milliseconds: 550), () {
        if (mounted) {
          setState(() {
            _selectedNum = null;
            _selectedName = null;
            _shakeWrong = false;
          });
        }
      });
    }
  }

  void _showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollCtrl) => Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Text('📚 श्रेणियाँ (Categories)',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00897B))),
                  const Spacer(),
                  Text('${AppData.categoryNames.length} topics',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: AppData.categoryNames.length,
                itemBuilder: (_, i) {
                  final isSelected = (i == _categoryIndex);
                  final catItems = AppData.getCategory(i);
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    selected: isSelected,
                    selectedTileColor:
                        AppTheme.primaryColor.withOpacity(0.08),
                    leading: Text(AppData.categoryEmojis[i],
                        style: const TextStyle(fontSize: 28)),
                    title: Text(AppData.categoryNames[i],
                        style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.black87)),
                    subtitle: Text('${catItems.length} items',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    trailing: isSelected
                        ? Icon(Icons.check_circle_rounded,
                            color: AppTheme.primaryColor)
                        : null,
                    onTap: () {
                      setState(() {
                        _categoryIndex = i;
                        _roundCount = 1;
                      });
                      Navigator.pop(ctx);
                      _loadRound();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final grad = _currentGradient;
    final isRoundCleared = (_matched.length == _currentPairs.length);

    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: Text(
          AppData.categoryNames[_categoryIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.category_rounded),
            tooltip: loc.translate('categories'),
            onPressed: _showCategoryPicker,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Shuffle',
            onPressed: _loadRound,
          ),
        ],
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Column(
            children: [
              // ── Category Tabs Strip ──────────────────────────────────────
              SizedBox(
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  itemCount: AppData.categoryNames.length,
                  itemBuilder: (ctx, i) {
                    final isSel = (i == _categoryIndex);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _categoryIndex = i;
                          _roundCount = 1;
                        });
                        _loadRound();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSel ? AppTheme.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: isSel
                                  ? AppTheme.primaryColor.withOpacity(0.35)
                                  : Colors.black12,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(AppData.categoryEmojis[i],
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 5),
                            Text(
                              AppData.categoryNames[i],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSel ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ── Score, Streak, & Audio Wave Bar ──────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text('⭐', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            '${vm.score}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00897B)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            '${vm.streak}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE65100)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<bool>(
                      valueListenable: _audio.isPlayingNotifier,
                      builder: (_, playing, __) => AudioSoundwaveWave(
                        isPlaying: playing,
                        color: const Color(0xFF00897B),
                        barCount: 4,
                        height: 24,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Round #$_roundCount',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Prompt Banner ────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                child: StaggeredEntrance(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: grad,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: grad[0].withOpacity(0.28),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text('🎯', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            isRoundCleared
                                ? loc.translate('round_cleared')
                                : loc.translate('prompt'),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '${_matched.length} / ${_currentPairs.length}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Matching Columns (Devanagari vs Words) ───────────────────
              Expanded(
                child: ShakeWidget(
                  shake: _shakeWrong,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Left Column: Numerals / Symbols
                        Expanded(
                          child: Column(
                            children: List.generate(_currentPairs.length, (i) {
                              final p = _currentPairs[i];
                              final isM = _matched.contains(p.number);
                              final isS = (_selectedNum == p.number);

                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: StaggeredEntrance(
                                    delayMs: 60 * i,
                                    child: _MatchCard(
                                      text: p.devanagari,
                                      subtext: p.emoji,
                                      isMatched: isM,
                                      isSelected: isS,
                                      isNumeral: true,
                                      onTap: isM
                                          ? null
                                          : () => _onSelectNum(p.number),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // Right Column: Hindi Words
                        Expanded(
                          child: Column(
                            children: List.generate(_shuffledNames.length, (i) {
                              final p = _shuffledNames[i];
                              final isM = _matched.contains(p.number);
                              final isS = (_selectedName == p.number);

                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: StaggeredEntrance(
                                    delayMs: 60 * i + 80,
                                    child: _MatchCard(
                                      text: p.name,
                                      subtext: '${p.englishName} • ${p.tamil}',
                                      isMatched: isM,
                                      isSelected: isS,
                                      isNumeral: false,
                                      onTap: isM
                                          ? null
                                          : () => _onSelectName(p.number),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Bottom Action Button ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _roundCount++);
                    _loadRound();
                  },
                  icon: Icon(isRoundCleared
                      ? Icons.celebration_rounded
                      : Icons.arrow_forward_rounded),
                  label: Text(isRoundCleared
                      ? 'अगला स्तर (Next Level)'
                      : loc.translate('next')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRoundCleared
                        ? const Color(0xFF2E7D32)
                        : AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _MatchCard
// ─────────────────────────────────────────────────────────────────────────────
class _MatchCard extends StatelessWidget {
  final String text;
  final String subtext;
  final bool isMatched;
  final bool isSelected;
  final bool isNumeral;
  final VoidCallback? onTap;

  const _MatchCard({
    required this.text,
    required this.subtext,
    required this.isMatched,
    required this.isSelected,
    required this.isNumeral,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = Colors.transparent;
    Color textCol = const Color(0xFF004D40);

    if (isMatched) {
      bg = const Color(0xFFE8F5E9);
      border = const Color(0xFF4CAF50);
      textCol = const Color(0xFF2E7D32);
    } else if (isSelected) {
      bg = const Color(0xFFFFF3E0);
      border = const Color(0xFFFF9800);
      textCol = const Color(0xFFE65100);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: border,
            width: isSelected || isMatched ? 2.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFFFF9800).withOpacity(0.3)
                  : (isMatched
                      ? const Color(0xFF4CAF50).withOpacity(0.2)
                      : Colors.black.withOpacity(0.05)),
              blurRadius: isSelected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isNumeral ? 32 : 22,
                      fontWeight: FontWeight.bold,
                      color: textCol,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtext,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isNumeral ? 16 : 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (isMatched)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
