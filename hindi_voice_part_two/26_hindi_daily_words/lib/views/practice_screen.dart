import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/word_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late WordItem _targetWord;
  late List<WordItem> _options;
  String? _selectedId;
  bool? _isCorrect;
  int _questionCount = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadNewQuestion();
  }

  void _loadNewQuestion() {
    final all = List<WordItem>.from(AppData.dailyWords)..shuffle(_random);
    _targetWord = all.first;

    // Pick 3 distractors
    final distractors = all.skip(1).take(3).toList();
    _options = [_targetWord, ...distractors]..shuffle(_random);

    _selectedId = null;
    _isCorrect = null;
    _questionCount++;

    // Auto-play target word after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playTargetAudio();
    });
  }

  void _playTargetAudio() {
    final vm = context.read<AppViewModel>();
    vm.playWordAudio(_targetWord);
  }

  void _onSelectOption(WordItem word) {
    if (_isCorrect == true) return; // already answered correctly

    final vm = context.read<AppViewModel>();
    final correct = (word.id == _targetWord.id);

    setState(() {
      _selectedId = word.id;
      _isCorrect = correct;
    });

    if (correct) {
      vm.addScore(15);
      vm.markCompleted(_targetWord.id);
      vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
    } else {
      vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    return ConfettiCelebrationOverlay(
      celebrate: _isCorrect == true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.translate('practice')),
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            BouncingWidget(
              onTap: () => vm.toggleSound(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: AnimatedRotation(
                  turns: vm.soundEnabled ? 0.0 : -0.1,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                // Header prompt & animated speaker
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          loc.translate('listen_and_choose'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Big speaker button with ripple effect & pulse
                      AudioRippleEffect(
                        isPlaying: vm.currentPlayingId == _targetWord.id,
                        rippleColor: AppTheme.secondaryColor,
                        child: BouncingWidget(
                          onTap: _playTargetAudio,
                          child: PulsingScale(
                            minScale: 0.96,
                            maxScale: 1.05,
                            duration: const Duration(milliseconds: 1000),
                            active: vm.currentPlayingId == _targetWord.id,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.secondaryColor.withOpacity(0.15),
                                border: Border.all(color: AppTheme.secondaryColor, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.secondaryColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.volume_up_rounded,
                                size: 40,
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.translate('replay'),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.subtitleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 4 Choice Cards with staggered entrance & interactive feedback
                Expanded(
                  child: GridView.count(
                    key: ValueKey('q_$_questionCount'),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                    children: _options.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final option = entry.value;
                      final isSelected = (_selectedId == option.id);
                      final isWrongChoice = isSelected && _isCorrect == false;
                      final isRightChoice = isSelected && _isCorrect == true;

                      Color cardBorderColor = Colors.black.withOpacity(0.08);
                      Color cardBgColor = Colors.white;

                      if (isRightChoice) {
                        cardBorderColor = Colors.green;
                        cardBgColor = Colors.green.shade50;
                      } else if (isWrongChoice) {
                        cardBorderColor = Colors.redAccent;
                        cardBgColor = Colors.red.shade50;
                      }

                      return StaggeredEntrance(
                        index: idx,
                        child: ShakeWidget(
                          shake: isWrongChoice,
                          child: BouncingWidget(
                            onTap: () => _onSelectOption(option),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              decoration: BoxDecoration(
                                color: cardBgColor,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: cardBorderColor,
                                  width: isSelected ? 3 : 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isRightChoice
                                        ? Colors.green.withOpacity(0.25)
                                        : (isWrongChoice
                                            ? Colors.redAccent.withOpacity(0.25)
                                            : Colors.black.withOpacity(0.06)),
                                    blurRadius: isSelected ? 12 : 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: isRightChoice
                                          ? ElasticPop(
                                              child: Text(option.emoji, style: const TextStyle(fontSize: 48)),
                                            )
                                          : FloatingAnimation(
                                              offset: 3.0,
                                              duration: const Duration(milliseconds: 2000),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(option.emoji, style: const TextStyle(fontSize: 44)),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      isHindi ? option.hindi : option.english,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: isRightChoice
                                            ? Colors.green.shade800
                                            : (isWrongChoice ? Colors.redAccent.shade700 : AppTheme.textColor),
                                      ),
                                      maxLines: 1,
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
                ),

                // Feedback Banner & Next Button
                if (_isCorrect != null) ...[
                  const SizedBox(height: 8),
                  ElasticPop(
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: _isCorrect! ? Colors.green.shade100 : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _isCorrect! ? Colors.green.shade400 : Colors.orange.shade400,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (_isCorrect! ? Colors.green : Colors.orange).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_isCorrect! ? '🎉 ' : '💡 ', style: const TextStyle(fontSize: 20)),
                          Flexible(
                            child: Text(
                              _isCorrect!
                                  ? loc.translate('great_job')
                                  : loc.translate('try_again'),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isCorrect! ? Colors.green.shade800 : Colors.orange.shade900,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ] else
                  const SizedBox(height: 8),

                // Next Button with pulsing highlight when question solved
                PulsingScale(
                  active: _isCorrect == true,
                  minScale: 0.98,
                  maxScale: 1.04,
                  duration: const Duration(milliseconds: 700),
                  child: BouncingWidget(
                    onTap: () {
                      setState(() {
                        _loadNewQuestion();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.secondaryColor.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loc.translate('next'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
