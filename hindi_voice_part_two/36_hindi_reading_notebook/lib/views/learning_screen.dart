
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
    final items = AppData.items.where((i) => i.level == vm.selectedLevel).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          // Level selector tabs
          SizedBox(
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: 5,
              itemBuilder: (context, idx) {
                final lvl = idx + 1;
                final isSel = (vm.selectedLevel == lvl);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('${loc.translate('level')} $lvl'),
                    selected: isSel,
                    onSelected: (_) => vm.setLevel(lvl),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final item = items[idx];
                final isDone = vm.completedIds.contains(item.hindi);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.hindi, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(item.english, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            vm.playAudio(item.audio);
                            vm.markCompleted(item.hindi);
                          },
                          icon: const Icon(Icons.volume_up),
                          style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
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
