
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
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final word = AppData.words[_page];
    final isCompleted = vm.completedIds.contains(word.id);
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text('${loc.translate('page')} ${_page + 1} / ${AppData.words.length}'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Text(loc.translate('stamped'), style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
                ),
              const Spacer(),
              Text(word.emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 16),
              Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Text(isHindi ? word.english : word.hindi, style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 12),
              Text(word.exampleSentence, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              const Spacer(),
              IconButton.filled(
                onPressed: () {
                  vm.playWordAudio(word);
                  vm.markCompleted(word.id);
                },
                icon: const Icon(Icons.volume_up, size: 36),
                style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _page > 0 ? () => setState(() => _page--) : null,
                    child: Text(loc.translate('prev_page')),
                  ),
                  ElevatedButton(
                    onPressed: _page < AppData.words.length - 1 ? () => setState(() => _page++) : null,
                    child: Text(loc.translate('next_page')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
