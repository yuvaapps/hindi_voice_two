
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/recog_num.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late RecogNum _target;
  late List<RecogNum> _choices;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<RecogNum>.from(AppData.numbers)..shuffle(_rnd);
    _target = list.first;
    _choices = list.take(3).toList()..shuffle(_rnd);
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playAudio(_target.audio);
    });
  }

  void _check(RecogNum choice) {
    if (_isCorrect == true) return;
    final correct = (choice.number == _target.number);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.playAudio('assets/audio/hi/feedback_great.mp3');
      vm.markCompleted(_target.number);
    } else {
      vm.playAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('prompt'), textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            IconButton.filled(
              onPressed: () => vm.playAudio(_target.audio),
              icon: const Icon(Icons.volume_up, size: 54),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _choices.map((c) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => _check(c),
                  child: Text(c.devanagari, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => setState(_load),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}
