import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/object_group.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialCategoryIndex;
  const LearningScreen({super.key, this.initialCategoryIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late int _categoryIdx;
  int _itemIdx = 0;
  late List<int> _options;
  int? _selectedAnswer;
  bool? _isCorrect;
  bool _shakeCard = false;
  bool _showConfetti = false;
  final Set<int> _tappedIndices = {};
  final math.Random _rnd = math.Random();

  @override
  void initState() {
    super.initState();
    _categoryIdx = widget.initialCategoryIndex;
    _setupItem();
  }

  List<ObjectGroup> get _currentList => AppData.getCategory(_categoryIdx);
  ObjectGroup get _target => _currentList[_itemIdx];

  void _setupItem() {
    _tappedIndices.clear();
    _selectedAnswer = null;
    _isCorrect = null;
    _shakeCard = false;

    final correctCount = _target.count;
    final opts = <int>{correctCount};

    // Generate 3 unique distractors close to the correct count
    while (opts.length < 4) {
      int delta = _rnd.nextInt(5) - 2;
      if (delta == 0) delta = _rnd.nextBool() ? 1 : -1;
      int fake = correctCount + delta;
      if (fake < 1) fake = correctCount + opts.length;
      if (fake > 20) fake = (correctCount - opts.length).clamp(1, 20);
      opts.add(fake);
    }

    _options = opts.toList()..shuffle(_rnd);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakQuestionPrompt();
    });
  }

  void _speakQuestionPrompt() {
    final vm = context.read<AppViewModel>();
    final isHi = vm.locale.languageCode == 'hi';
    final text = isHi
        ? 'यहाँ कितने ${_target.objectHindi} हैं?'
        : 'How many ${_target.objectEnglish.toLowerCase()} are there?';
    vm.speakWord(text);
  }

  void _onCategorySelected(int index) {
    if (_categoryIdx == index) return;
    setState(() {
      _categoryIdx = index;
      _itemIdx = 0;
      _setupItem();
    });
    context.read<AppViewModel>().setCategory(index);
  }

  void _onObjectTap(int index) {
    if (_tappedIndices.contains(index)) return;
    setState(() {
      _tappedIndices.add(index);
    });
    final tapCount = _tappedIndices.length;
    context.read<AppViewModel>().speakCount(tapCount);
  }

  void _checkAnswer(int ans) {
    if (_isCorrect == true) return;
    final correct = (ans == _target.count);
    final vm = context.read<AppViewModel>();

    setState(() {
      _selectedAnswer = ans;
      _isCorrect = correct;
    });

    if (correct) {
      setState(() => _showConfetti = true);
      Future.delayed(const Duration(milliseconds: 2200), () {
        if (mounted) setState(() => _showConfetti = false);
      });
      vm.playAudio(_target.numAudio, textFallback: '${_target.count}');
      vm.markCompleted(_target.id);
    } else {
      setState(() => _shakeCard = true);
      vm.playAudio('assets/audio/hi/feedback_try.mp3', textFallback: 'फिर से गिनें');
    }
  }

  void _prevItem() {
    if (_itemIdx > 0) {
      setState(() {
        _itemIdx--;
        _setupItem();
      });
    }
  }

  void _nextItem() {
    if (_itemIdx < _currentList.length - 1) {
      setState(() {
        _itemIdx++;
        _setupItem();
      });
    }
  }

  void _randomItem() {
    final rand = _rnd.nextInt(_currentList.length);
    setState(() {
      _itemIdx = rand;
      _setupItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = _target;
    final catName = AppData.categoryNames[_categoryIdx];

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('app_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$catName (${_itemIdx + 1}/${_currentList.length})',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: loc.translate('sound'),
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
            onPressed: vm.toggleSound,
          ),
          IconButton(
            tooltip: vm.locale.languageCode == 'hi' ? 'English' : 'हिन्दी',
            icon: const Icon(Icons.translate),
            onPressed: vm.toggleLanguage,
          ),
        ],
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Column(
            children: [
              // ── Category Selector Tabs ──────────────────────────────────
              Container(
                color: Colors.white,
                height: 52,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  itemCount: AppData.categoryNames.length,
                  itemBuilder: (context, idx) {
                    final isSelected = _categoryIdx == idx;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        avatar: Text(AppData.categoryEmojis[idx]),
                        label: Text(
                          AppData.categoryNames[idx],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppTheme.primaryColor,
                        backgroundColor: const Color(0xFFF1F5F9),
                        onSelected: (_) => _onCategorySelected(idx),
                        showCheckmark: false,
                      ),
                    );
                  },
                ),
              ),

              // ── Progress indicator bar across category ────────────────────
              LinearProgressIndicator(
                value: (_itemIdx + 1) / _currentList.length,
                backgroundColor: const Color(0xFFFFE0B2),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                minHeight: 4,
              ),

              // ── Main Content Area ─────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Column(
                    children: [
                      // Question Prompt Banner with Audio Button
                      StaggeredEntrance(
                        key: ValueKey('prompt_${item.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: _speakQuestionPrompt,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.volume_up, color: AppTheme.primaryColor, size: 24),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vm.locale.languageCode == 'hi'
                                          ? '${loc.translate('prompt_prefix')} ${item.objectHindi} ${loc.translate('prompt_suffix')}'
                                          : '${loc.translate('prompt_prefix')} ${item.objectEnglish.toLowerCase()} ${loc.translate('prompt_suffix')}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E293B),
                                      ),
                                    ),
                                    Text(
                                      '${item.objectEnglish} • ${item.tamil}',
                                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                    ),
                                  ],
                                ),
                              ),
                              // Live Soundwave visualizer
                              ValueListenableBuilder<bool>(
                                valueListenable: vm.audioService.isPlayingNotifier,
                                builder: (context, isPlaying, _) {
                                  return AudioSoundwaveWave(
                                    isPlaying: isPlaying,
                                    color: isPlaying ? AppTheme.primaryColor : const Color(0xFFCBD5E1),
                                    barCount: 5,
                                    height: 24,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Interactive Objects Arena (Tap-To-Count)
                      ShakeWidget(
                        shake: _shakeCard,
                        onComplete: () => setState(() => _shakeCard = false),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(minHeight: 180),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withValues(alpha: 0.12),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Arena Header Tip
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3E0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        const Text('👆', style: TextStyle(fontSize: 12)),
                                        const SizedBox(width: 4),
                                        Text(
                                          loc.translate('tap_to_count'),
                                          style: const TextStyle(
                                            color: Color(0xFFE65100),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${_tappedIndices.length} / ${item.count}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Grid / Wrap of Interactive Object Emojis
                              Wrap(
                                spacing: 14,
                                runSpacing: 14,
                                alignment: WrapAlignment.center,
                                children: List.generate(item.count, (i) {
                                  final isTapped = _tappedIndices.contains(i);
                                  return GestureDetector(
                                    onTap: () => _onObjectTap(i),
                                    child: BouncingWidget(
                                      amplitude: 3,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: isTapped
                                                  ? AppTheme.primaryColor.withValues(alpha: 0.15)
                                                  : const Color(0xFFF8FAFC),
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                color: isTapped ? AppTheme.primaryColor : const Color(0xFFE2E8F0),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Text(
                                              item.emoji,
                                              style: TextStyle(
                                                fontSize: item.count > 12 ? 32 : (item.count > 6 ? 40 : 48),
                                              ),
                                            ),
                                          ),
                                          if (isTapped)
                                            Positioned(
                                              top: -6,
                                              right: -6,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: AppTheme.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${_tappedIndices.toList().indexOf(i) + 1}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),

                              // Success indicator banner
                              if (_isCorrect == true) ...[
                                const SizedBox(height: 16),
                                NumberPulseAura(
                                  color: const Color(0xFF4CAF50),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${item.hindiDevanagari} (${item.hindiName} - ${item.count}) ${loc.translate('great_job')}',
                                          style: const TextStyle(
                                            color: Color(0xFF2E7D32),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 4 Multiple Choice Answer Options
                      Text(
                        loc.translate('select_correct'),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _options.map((opt) {
                          final isSelected = (_selectedAnswer == opt);
                          Color btnBg = Colors.white;
                          Color textColor = AppTheme.primaryColor;
                          BorderSide border = const BorderSide(color: Color(0xFFFFCC80), width: 1.5);

                          if (isSelected) {
                            if (_isCorrect == true) {
                              btnBg = const Color(0xFF2E7D32);
                              textColor = Colors.white;
                              border = const BorderSide(color: Color(0xFF1B5E20), width: 2);
                            } else if (_isCorrect == false) {
                              btnBg = const Color(0xFFD32F2F);
                              textColor = Colors.white;
                              border = const BorderSide(color: Color(0xFFB71C1C), width: 2);
                            }
                          }

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () => _checkAnswer(opt),
                                borderRadius: BorderRadius.circular(18),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: btnBg,
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.fromBorderSide(border),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '$opt',
                                        style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        AppData.items.firstWhere((e) => e.count == opt).hindiDevanagari,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.white70 : const Color(0xFF78909C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bottom Navigation Controls ────────────────────────────────
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _itemIdx > 0 ? _prevItem : null,
                        icon: const Icon(Icons.arrow_back_ios, size: 14),
                        label: Text(loc.translate('previous')),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton.filledTonal(
                      onPressed: _randomItem,
                      tooltip: loc.translate('random'),
                      icon: const Icon(Icons.shuffle, color: AppTheme.primaryColor),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.12),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _itemIdx < _currentList.length - 1 ? _nextItem : null,
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        label: Text(loc.translate('next')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
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
      ),
    );
  }
}
