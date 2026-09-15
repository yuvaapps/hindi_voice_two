
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class LearningScreen extends StatelessWidget {
  final bool isTab;
  const LearningScreen({super.key, this.isTab = false});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    final list = ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: AppData.names.length,
      itemBuilder: (context, idx) {
          final item = AppData.names[idx];
          final isPlaying = vm.currentPlayingId == item.id;
          final isDone = vm.completedIds.contains(item.id);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(item.hindi, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              subtitle: Text('${item.english} • ${item.meaning}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_down, color: AppTheme.primaryColor, size: 28),
                    onPressed: () {
                      vm.playNameAudio(item);
                      vm.markCompleted(item.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PracticeScreen(initialIndex: idx)));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );

    if (isTab) return list;
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: SafeArea(child: list),
    );
  }
}
