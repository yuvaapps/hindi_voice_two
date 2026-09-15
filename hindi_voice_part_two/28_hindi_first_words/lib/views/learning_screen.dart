
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: PageView.builder(
        itemCount: AppData.firstWords.length,
        itemBuilder: (context, idx) {
          final word = AppData.firstWords[idx];
          final isPlaying = vm.currentPlayingId == word.id;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: InkWell(
              onTap: () {
                vm.playWordAudio(word);
                vm.markCompleted(word.id);
              },
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: isPlaying ? AppTheme.primaryColor : Colors.pink.shade100, width: isPlaying ? 4 : 2),
                  boxShadow: [BoxShadow(color: Colors.pink.withAlpha(25), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(word.emoji, style: const TextStyle(fontSize: 110)),
                    const SizedBox(height: 20),
                    Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 8),
                    Text(isHindi ? word.english : word.hindi, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight, shape: BoxShape.circle),
                      child: Icon(Icons.volume_up, size: 40, color: isPlaying ? Colors.white : AppTheme.primaryColor),
                    ),
                    const SizedBox(height: 12),
                    Text(loc.translate('listen_prompt'), style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
