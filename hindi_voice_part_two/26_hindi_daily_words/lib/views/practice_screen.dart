import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/word_item.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('practice')),
        backgroundColor: AppTheme.secondaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => vm.toggleSound(),
            icon: Icon(
              vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header prompt & speaker
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      loc.translate('listen_and_choose'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Big speaker button
                    InkWell(
                      onTap: _playTargetAudio,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.secondaryColor.withOpacity(0.15),
                          border: Border.all(color: AppTheme.secondaryColor, width: 3),
                        ),
                        child: const Icon(
                          Icons.volume_up_rounded,
                          size: 44,
                          color: AppTheme.secondaryColor,
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

              const SizedBox(height: 20),

              // 4 Choice Cards
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.05,
                  children: _options.map((option) {
                    final isSelected = (_selectedId == option.id);
                    Color cardBorderColor = Colors.black.withOpacity(0.08);
                    Color cardBgColor = Colors.white;

                    if (isSelected) {
                      if (_isCorrect == true) {
                        cardBorderColor = Colors.green;
                        cardBgColor = Colors.green.shade50;
                      } else {
                        cardBorderColor = Colors.redAccent;
                        cardBgColor = Colors.red.shade50;
                      }
                    }

                    return InkWell(
                      onTap: () => _onSelectOption(option),
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: cardBorderColor, width: isSelected ? 3 : 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(option.emoji, style: const TextStyle(fontSize: 48)),
                            const SizedBox(height: 8),
                            Text(
                              isHindi ? option.hindi : option.english,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Feedback Banner & Next Button
              if (_isCorrect != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: _isCorrect! ? Colors.green.shade100 : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isCorrect!
                            ? loc.translate('great_job')
                            : loc.translate('try_again'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isCorrect! ? Colors.green.shade800 : Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _loadNewQuestion();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(loc.translate('next')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
