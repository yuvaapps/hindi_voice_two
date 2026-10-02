import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/recog_num.dart';
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
  bool _isAudioMode = true; // true: Listen & Identify, false: Look & Identify
  late RecogNum _target;
  late List<RecogNum> _choices;
  RecogNum? _selectedChoice;
  bool? _isCorrect;
  bool _showConfetti = false;
  bool _shakeWrong = false;
  int _questionCount = 0;
  final Random _rnd = Random();
  final AudioService _audio = AudioService();

  static const List<List<Color>> _categoryGradients = [
    [Color(0xFFC2185B), Color(0xFFE91E63)], // Pink/Rose
    [Color(0xFF7B1FA2), Color(0xFF9C27B0)], // Purple
    [Color(0xFF1976D2), Color(0xFF2196F3)], // Blue
    [Color(0xFF00796B), Color(0xFF009688)], // Teal
    [Color(0xFFE65100), Color(0xFFFF9800)], // Orange
    [Color(0xFFD81B60), Color(0xFFFF4081)], // Deep Pink (Animals)
    [Color(0xFFC62828), Color(0xFFEF5350)], // Red (Fruits)
    [Color(0xFF2E7D32), Color(0xFF4CAF50)], // Green (Veg)
    [Color(0xFF6A1B9A), Color(0xFFAB47BC)], // Violet (Colors)
    [Color(0xFF00838F), Color(0xFF00ACC1)], // Cyan (Body)
    [Color(0xFFAD1457), Color(0xFFEC407A)], // Rose (Family)
    [Color(0xFF283593), Color(0xFF3F51B5)], // Indigo (Transport)
    [Color(0xFF4527A0), Color(0xFF673AB7)], // Deep Purple (School)
    [Color(0xFF558B2F), Color(0xFF7CB342)], // Lime Green (Nature)
    [Color(0xFFBF360C), Color(0xFFFF5722)], // Deep Orange (Food)
  ];

  List<RecogNum> get _currentPool => AppData.getCategory(_categoryIndex);
  List<Color> get _currentGradient =>
      _categoryGradients[_categoryIndex % _categoryGradients.length];

  @override
  void initState() {
    super.initState();
    _categoryIndex = widget.initialCategory;
    _nextQuestion(isInitial: true);
  }

  void _nextQuestion({bool isInitial = false}) {
    final pool = _currentPool;
    if (pool.isEmpty) return;

    final targetIndex = _rnd.nextInt(pool.length);
    _target = pool[targetIndex];

    // Pick 3 distractors from the pool or allItems
    final distractorPool = List<RecogNum>.from(
        pool.length >= 4 ? pool : AppData.allItems)
      ..removeWhere((item) => item.number == _target.number);
    distractorPool.shuffle(_rnd);

    _choices = [_target, ...distractorPool.take(3)]..shuffle(_rnd);
    _selectedChoice = null;
    _isCorrect = null;
    _showConfetti = false;
    _shakeWrong = false;
    _questionCount++;

    setState(() {});

    // Automatically speak the target audio if in audio mode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _playTargetAudio();
      }
    });
  }

  void _playTargetAudio() {
    final vm = context.read<AppViewModel>();
    if (!vm.soundEnabled) return;
    _audio.playAudio(_target.audio, textFallback: _target.hindiName);
  }

  void _onChoiceSelected(RecogNum choice) {
    if (_isCorrect == true) return; // already solved correctly

    final correct = (choice.number == _target.number);
    final vm = context.read<AppViewModel>();

    setState(() {
      _selectedChoice = choice;
      _isCorrect = correct;
      if (correct) {
        _showConfetti = true;
        _shakeWrong = false;
      } else {
        _shakeWrong = true;
      }
    });

    vm.recordAttempt(number: _target.number, isCorrect: correct);

    if (correct) {
      if (vm.soundEnabled) {
        _audio.playAudio('assets/audio/hi/feedback_great.mp3',
            textFallback: 'बहुत बढ़िया!');
      }
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (mounted && _isCorrect == true) {
          _nextQuestion();
        }
      });
    } else {
      if (vm.soundEnabled) {
        _audio.playAudio('assets/audio/hi/feedback_try.mp3',
            textFallback: 'फिर कोशिश करें');
      }
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          setState(() => _shakeWrong = false);
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
                          color: Color(0xFFC2185B))),
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: AppData.categoryNames.length,
                itemBuilder: (_, i) {
                  final selected = (i == _categoryIndex);
                  final catItems = AppData.getCategory(i);
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    selected: selected,
                    selectedTileColor:
                        AppTheme.primaryColor.withOpacity(0.08),
                    leading: Text(AppData.categoryEmojis[i],
                        style: const TextStyle(fontSize: 28)),
                    title: Text(AppData.categoryNames[i],
                        style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: selected
                                ? AppTheme.primaryColor
                                : Colors.black87)),
                    subtitle: Text('${catItems.length} items',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    trailing: selected
                        ? Icon(Icons.check_circle_rounded,
                            color: AppTheme.primaryColor)
                        : null,
                    onTap: () {
                      setState(() {
                        _categoryIndex = i;
                      });
                      Navigator.pop(ctx);
                      _nextQuestion();
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

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: Text(
          AppData.categoryNames[_categoryIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Mode switch (Audio vs Visual)
          IconButton(
            icon: Icon(_isAudioMode
                ? Icons.hearing_rounded
                : Icons.visibility_rounded),
            tooltip: _isAudioMode ? 'Audio Mode' : 'Visual Mode',
            onPressed: () {
              setState(() {
                _isAudioMode = !_isAudioMode;
              });
              _nextQuestion();
            },
          ),
          // Category selector
          IconButton(
            icon: const Icon(Icons.category_rounded),
            tooltip: loc.translate('categories'),
            onPressed: _showCategoryPicker,
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
                    final isSel = i == _categoryIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _categoryIndex = i;
                        });
                        _nextQuestion();
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

              // ── Score & Streak Bar ────────────────────────────────────────
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
                                color: Color(0xFFC2185B)),
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
                    const Spacer(),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Q #$_questionCount',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Main Recognition Card & Options ──────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
                  child: Column(
                    children: [
                      // Prompt Banner
                      StaggeredEntrance(
                        key: ValueKey('prompt-$_questionCount'),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: grad,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: grad[0].withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                _isAudioMode
                                    ? loc.translate('prompt')
                                    : loc.translate('prompt_visual'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),

                              if (_isAudioMode) ...[
                                // Audio Speaker with Waves
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: _playTargetAudio,
                                      child: NumberPulseAura(
                                        active: _showConfetti,
                                        color: Colors.white,
                                        child: Container(
                                          width: 76,
                                          height: 76,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.25),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                          ),
                                          child: const Icon(
                                            Icons.volume_up_rounded,
                                            color: Colors.white,
                                            size: 42,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: _audio.isPlayingNotifier,
                                      builder: (_, playing, __) =>
                                          AudioSoundwaveWave(
                                        isPlaying: playing,
                                        color: Colors.white,
                                        barCount: 5,
                                        height: 34,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  loc.translate('listen_again'),
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 11),
                                ),
                              ] else ...[
                                // Visual display of Target
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _target.emoji,
                                      style: const TextStyle(fontSize: 42),
                                    ),
                                    const SizedBox(width: 14),
                                    BouncingWidget(
                                      amplitude: 4,
                                      child: Text(
                                        _target.devanagari,
                                        style: const TextStyle(
                                          fontSize: 52,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 4 Recognition Option Cards (2x2 Grid)
                      Expanded(
                        child: ShakeWidget(
                          shake: _shakeWrong,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.15,
                            ),
                            itemCount: _choices.length,
                            itemBuilder: (ctx, i) {
                              final choice = _choices[i];
                              final isSelected = (_selectedChoice == choice);
                              final isTarget = (choice.number == _target.number);

                              Color bgColor = Colors.white;
                              Color borderColor = Colors.transparent;
                              Color textColor = const Color(0xFFC2185B);

                              if (_isCorrect != null && isSelected) {
                                if (_isCorrect!) {
                                  bgColor = const Color(0xFFE8F5E9);
                                  borderColor = const Color(0xFF4CAF50);
                                  textColor = const Color(0xFF2E7D32);
                                } else {
                                  bgColor = const Color(0xFFFFEBEE);
                                  borderColor = const Color(0xFFEF5350);
                                  textColor = const Color(0xFFC62828);
                                }
                              } else if (_isCorrect == true && isTarget) {
                                // Highlight target if wrong was picked
                                bgColor = const Color(0xFFE8F5E9);
                                borderColor = const Color(0xFF4CAF50);
                                textColor = const Color(0xFF2E7D32);
                              }

                              return StaggeredEntrance(
                                delayMs: 80 * i,
                                child: InkWell(
                                  onTap: () => _onChoiceSelected(choice),
                                  borderRadius: BorderRadius.circular(20),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 2.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isSelected && _isCorrect == true
                                              ? const Color(0xFF4CAF50)
                                                  .withOpacity(0.3)
                                              : Colors.black.withOpacity(0.06),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Primary display
                                              Text(
                                                _isAudioMode
                                                    ? choice.devanagari
                                                    : choice.hindiName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: _isAudioMode ? 38 : 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              // Translation or transliteration subtext
                                              Text(
                                                _isAudioMode
                                                    ? choice.hindiName
                                                    : choice.englishName,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                choice.tamil,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey.shade500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Feedback icon badge
                                        if (isSelected && _isCorrect != null)
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _isCorrect!
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              child: Icon(
                                                _isCorrect!
                                                    ? Icons.check
                                                    : Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Feedback Banner
                      if (_isCorrect != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: AnimatedOpacity(
                            opacity: 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              _isCorrect!
                                  ? loc.translate('great_job')
                                  : loc.translate('try_again'),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _isCorrect!
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFFD84315),
                              ),
                            ),
                          ),
                        ),

                      // Next Button
                      ElevatedButton.icon(
                        onPressed: () => _nextQuestion(),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: Text(loc.translate('next')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
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
}
