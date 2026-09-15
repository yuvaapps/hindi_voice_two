
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/easy_word.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.words.where((w) {
      if (vm.filterLetterCount == 0) return true;
      return w.letterCount == vm.filterLetterCount;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('start_learning')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(loc.translate('all')),
                  selected: vm.filterLetterCount == 0,
                  onSelected: (_) => vm.setFilter(0),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(loc.translate('two_letter')),
                  selected: vm.filterLetterCount == 2,
                  onSelected: (_) => vm.setFilter(2),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(loc.translate('three_letter')),
                  selected: vm.filterLetterCount == 3,
                  onSelected: (_) => vm.setFilter(3),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isCompleted = vm.completedIds.contains(word.id);

                return InkWell(
                  onTap: () {
                    vm.playWordAudio(word);
                    vm.markCompleted(word.id);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isPlaying ? AppTheme.primaryColor : (isCompleted ? Colors.green : Colors.grey.shade200),
                        width: isPlaying ? 2.5 : 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(word.emoji, style: const TextStyle(fontSize: 42)),
                        const SizedBox(height: 6),
                        Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('${word.letters.join(" + ")} = ${word.hindi}', style: const TextStyle(fontSize: 12, color: AppTheme.subtitleColor)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.volume_up_rounded, size: 20, color: isPlaying ? Colors.white : AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
