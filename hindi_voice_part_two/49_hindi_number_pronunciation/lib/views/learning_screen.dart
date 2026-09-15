
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
    final item = AppData.numbers[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('${_idx + 1} / ${AppData.numbers.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
                    Text(item.devanagari, style: const TextStyle(fontSize: 110, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 16),
                    Text(item.hindiName, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('${item.number} • ${item.englishName}', style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    const SizedBox(height: 24),
                    IconButton.filled(
                      onPressed: () {
                        vm.playAudio(item);
                        vm.markCompleted(item.number);
                      },
                      icon: const Icon(Icons.volume_up, size: 44),
                      style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
                    ),
                    const SizedBox(height: 10),
                    Text(loc.translate('replay'), style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                ElevatedButton(onPressed: _idx < AppData.numbers.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
