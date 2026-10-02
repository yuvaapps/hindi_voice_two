import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/easy_word.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late EasyWord _target;
  late List<String> _shuffledLetters;
  final List<String> _selectedLetters = [];
  bool? _isCorrect;
  int _questionIndex = 0;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _loadWord();
  }

  void _loadWord() {
    _target = AppData.words[_rnd.nextInt(AppData.words.length)];
    _shuffledLetters = List<String>.from(_target.letters)..shuffle(_rnd);
    _selectedLetters.clear();
    _isCorrect = null;
    _questionIndex++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _onTapLetter(String letter) {
    if (_isCorrect == true) return;
    final vm = context.read<AppViewModel>();
    vm.playLetterAudio(letter);

    setState(() {
      _selectedLetters.add(letter);
      _shuffledLetters.remove(letter);

      if (_selectedLetters.length == _target.letters.length) {
        final formed = _selectedLetters.join('');
        final correct = (formed == _target.hindi);
        _isCorrect = correct;
        if (correct) {
          vm.addScore(15);
          vm.markCompleted(_target.id);
          vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
          Future.delayed(const Duration(milliseconds: 1100), () {
            if (mounted) vm.playWordAudio(_target);
          });
        } else {
          vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
        }
      }
    });
  }

  void _resetWord() {
    setState(() {
      _shuffledLetters = List<String>.from(_target.letters)..shuffle(_rnd);
      _selectedLetters.clear();
      _isCorrect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isPlaying = vm.currentPlayingId == _target.id;

    return ConfettiCelebrationOverlay(
      celebrate: _isCorrect == true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.translate('practice')),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: [
                Text(
                  loc.translate('word_builder'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textColor),
                ),
                const SizedBox(height: 12),

                // Floating target emoji
                FloatingAnimation(
                  offset: 5,
                  duration: const Duration(milliseconds: 1800),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(_target.emoji, style: const TextStyle(fontSize: 60)),
                  ),
                ),
                const SizedBox(height: 10),

                // Speaker button with concentric wave ripples
                AudioRippleEffect(
                  isPlaying: isPlaying,
                  rippleColor: AppTheme.primaryColor,
                  child: BouncingWidget(
                    onTap: () => vm.playWordAudio(_target),
                    child: PulsingScale(
                      active: isPlaying,
                      minScale: 0.95,
                      maxScale: 1.08,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.volume_up_rounded, size: 28, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Word letter slots with Shake feedback on mistake
                ShakeWidget(
                  shake: _isCorrect == false,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isCorrect == true
                            ? Colors.green
                            : (_isCorrect == false ? Colors.redAccent : Colors.grey.shade300),
                        width: _isCorrect != null ? 2.5 : 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _isCorrect == true
                              ? Colors.green.withOpacity(0.2)
                              : (_isCorrect == false
                                  ? Colors.redAccent.withOpacity(0.2)
                                  : Colors.black.withOpacity(0.05)),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_target.letters.length, (i) {
                          final hasLetter = i < _selectedLetters.length;
                          final letter = hasLetter ? _selectedLetters[i] : '_';

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: hasLetter
                                ? ElasticPop(
                                    key: ValueKey('slot_${_questionIndex}_${i}_$letter'),
                                    child: Text(
                                      letter,
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: _isCorrect == true ? Colors.green.shade700 : AppTheme.primaryColor,
                                      ),
                                    ),
                                  )
                                : Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Shuffled letters with tactile spring bounce
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _shuffledLetters.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final l = entry.value;

                    return StaggeredEntrance(
                      index: idx,
                      child: BouncingWidget(
                        onTap: () => _onTapLetter(l),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryColor.withOpacity(0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            l,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Feedback Banner
                if (_isCorrect != null)
                  ElasticPop(
                    duration: const Duration(milliseconds: 350),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: _isCorrect! ? Colors.green.shade100 : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _isCorrect! ? Colors.green.shade400 : Colors.orange.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_isCorrect! ? '🎉 ' : '💡 ', style: const TextStyle(fontSize: 22)),
                          Text(
                            _isCorrect! ? loc.translate('great_job') : loc.translate('try_again'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _isCorrect! ? Colors.green.shade800 : Colors.orange.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Reset and Next Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: BouncingWidget(
                        onTap: _resetWord,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade400, width: 1.5),
                          ),
                          child: Center(
                            child: Text(
                              loc.translate('cancel'),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PulsingScale(
                        active: _isCorrect == true,
                        minScale: 0.98,
                        maxScale: 1.05,
                        child: BouncingWidget(
                          onTap: () => setState(_loadWord),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  loc.translate('next'),
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                              ],
                            ),
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
      ),
    );
  }
}
