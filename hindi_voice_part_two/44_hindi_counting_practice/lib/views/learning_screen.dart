
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/counting_item.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late CountingItem _target;
  late List<int> _options;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<CountingItem>.from(AppData.items)..shuffle(_rnd);
    _target = list.first;

    final opts = {_target.count};
    while (opts.length < 4) {
      opts.add(_rnd.nextInt(10) + 1);
    }
    _options = opts.toList()..shuffle(_rnd);
    _isCorrect = null;
  }

  void _check(int ans) {
    if (_isCorrect == true) return;
    final correct = (ans == _target.count);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.playAudio(_target.audio);
      vm.markCompleted(_target.count);
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
            Text(loc.translate('question'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(_target.count, (i) {
                  return Text(_target.emoji, style: const TextStyle(fontSize: 44));
                }),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _options.map((opt) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => _check(opt),
                  child: Text('$opt', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 12),
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
