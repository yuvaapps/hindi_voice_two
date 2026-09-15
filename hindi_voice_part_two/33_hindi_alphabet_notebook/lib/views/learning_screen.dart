
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.letters[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('${loc.translate('page')} ${_idx + 1} / ${AppData.letters.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.orange.shade200, width: 2)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.letter, style: const TextStyle(fontSize: 84, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              const SizedBox(height: 10),
              Text(item.emoji, style: const TextStyle(fontSize: 60)),
              const SizedBox(height: 10),
              Text('${item.letter} से ${item.word}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Text(item.englishWord, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => vm.playAudio(item.letterAudio),
                    icon: const Icon(Icons.volume_up),
                    label: Text('अक्षर: ${item.letter}'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      vm.playAudio(item.wordAudio);
                      vm.markCompleted(item.letter);
                    },
                    icon: const Icon(Icons.volume_up),
                    label: Text('शब्द: ${item.word}'),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                  ElevatedButton(onPressed: _idx < AppData.letters.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
