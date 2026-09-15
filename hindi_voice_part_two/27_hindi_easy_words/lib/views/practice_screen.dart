
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/easy_word.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _onTapLetter(String letter) {
    if (_isCorrect == true) return;
    setState(() {
      _selectedLetters.add(letter);
      _shuffledLetters.remove(letter);

      if (_selectedLetters.length == _target.letters.length) {
        final formed = _selectedLetters.join('');
        final correct = (formed == _target.hindi);
        _isCorrect = correct;
        final vm = context.read<AppViewModel>();
        if (correct) {
          vm.addScore(15);
          vm.markCompleted(_target.id);
          vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
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

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('word_builder'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(_target.emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 10),
            IconButton.filled(
              onPressed: () => vm.playWordAudio(_target),
              icon: const Icon(Icons.volume_up_rounded, size: 32),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_target.letters.length, (i) {
                  final letter = i < _selectedLetters.length ? _selectedLetters[i] : '_';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(letter, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 14,
              children: _shuffledLetters.map((l) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryLight,
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => _onTapLetter(l),
                  child: Text(l, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(
                _isCorrect! ? loc.translate('great_job') : loc.translate('try_again'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange),
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetWord,
                    child: Text(loc.translate('cancel')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(_loadWord),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
                    child: Text(loc.translate('next')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
