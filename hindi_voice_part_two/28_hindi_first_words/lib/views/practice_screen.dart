
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/first_word.dart';
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
  bool? _isCorrect;
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
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _choose(FirstWord w) {
    if (_isCorrect == true) return;
    final correct = (w.id == _target.id);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
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

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('practice'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            IconButton.filled(
              onPressed: () => vm.playWordAudio(_target),
              icon: const Icon(Icons.volume_up, size: 50),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _choices.length,
                itemBuilder: (context, idx) {
                  final w = _choices[idx];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.textColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () => _choose(w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(w.emoji, style: const TextStyle(fontSize: 40)),
                          const SizedBox(width: 16),
                          Text(vm.locale.languageCode == 'hi' ? w.hindi : w.english, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(_next),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}
