import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/first_word.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late FirstWord _target;
  late List<FirstWord> _choices;
  String? _selectedId;
  bool? _isCorrect;
  int _questionCount = 0;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final list = List<FirstWord>.from(AppData.firstWords)..shuffle(_rnd);
    _target = list.first;
    _choices = list.take(3).toList()..shuffle(_rnd);
    _selectedId = null;
    _isCorrect = null;
    _questionCount++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _choose(FirstWord w) {
    if (_isCorrect == true) return;
    final correct = (w.id == _target.id);
    setState(() {
      _selectedId = w.id;
      _isCorrect = correct;
    });
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.addScore(15);
      vm.markCompleted(_target.id);
      vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
    } else {
      vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final isHindi = vm.locale.languageCode == 'hi';
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
              onTap: vm.toggleSound,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        loc.translate('listen_and_choose'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textColor),
                      ),
                      const SizedBox(height: 12),
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
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.volume_up_rounded, size: 38, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    key: ValueKey('practice_$_questionCount'),
                    crossAxisCount: 1,
                    mainAxisSpacing: 14,
                    childAspectRatio: 3.2,
                    children: _choices.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final w = entry.value;
                      final isSelected = (_selectedId == w.id);
                      final isWrong = isSelected && _isCorrect == false;
                      final isRight = isSelected && _isCorrect == true;

                      return StaggeredEntrance(
                        index: idx,
                        child: ShakeWidget(
                          shake: isWrong,
                          child: BouncingWidget(
                            onTap: () => _choose(w),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isRight
                                    ? Colors.green.shade50
                                    : (isWrong ? Colors.red.shade50 : Colors.white),
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                  color: isRight
                                      ? Colors.green
                                      : (isWrong
                                          ? Colors.redAccent
                                          : AppTheme.primaryColor.withOpacity(0.2)),
                                  width: isSelected ? 3 : 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isRight
                                        ? Colors.green.withOpacity(0.2)
                                        : (isWrong
                                            ? Colors.redAccent.withOpacity(0.2)
                                            : Colors.black.withOpacity(0.04)),
                                    blurRadius: isSelected ? 10 : 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: Row(
                                children: [
                                  isRight
                                      ? const ElasticPop(
                                          child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 36),
                                        )
                                      : Text(w.emoji, style: const TextStyle(fontSize: 42)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isHindi ? w.hindi : w.english,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: isRight
                                                ? Colors.green.shade800
                                                : (isWrong ? Colors.redAccent.shade700 : AppTheme.textColor),
                                          ),
                                        ),
                                        Text(
                                          isHindi ? w.english : w.hindi,
                                          style: const TextStyle(fontSize: 14, color: AppTheme.subtitleColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.touch_app_rounded, color: Colors.grey, size: 22),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (_isCorrect != null)
                  ElasticPop(
                    duration: const Duration(milliseconds: 350),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: _isCorrect! ? Colors.green.shade100 : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: _isCorrect! ? Colors.green : Colors.orange, width: 1.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_isCorrect! ? '🎉 ' : '💡 ', style: const TextStyle(fontSize: 20)),
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
                PulsingScale(
                  active: _isCorrect == true,
                  minScale: 0.98,
                  maxScale: 1.05,
                  child: BouncingWidget(
                    onTap: _next,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.35),
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
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
