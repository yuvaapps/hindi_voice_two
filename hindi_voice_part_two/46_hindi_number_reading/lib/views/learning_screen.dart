
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
    final item = AppData.items[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('${_idx + 1} / ${AppData.items.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.devanagari, style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 16),
                    Text(item.hindiName, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${item.number} • ${item.englishName}', style: const TextStyle(fontSize: 24, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                IconButton.filled(
                  onPressed: () {
                    vm.playAudio(item.audio);
                    vm.markCompleted(item.number);
                  },
                  icon: const Icon(Icons.volume_up, size: 36),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
                ),
                ElevatedButton(onPressed: _idx < AppData.items.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
