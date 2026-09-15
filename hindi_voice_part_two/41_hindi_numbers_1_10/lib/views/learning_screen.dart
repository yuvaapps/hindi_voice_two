
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
    final num = AppData.numbers[_idx];
    final isHindi = vm.locale.languageCode == 'hi';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(num.devanagari, style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        const SizedBox(width: 24),
                        Text('${num.value}', style: const TextStyle(fontSize: 50, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(isHindi ? num.hindiName : num.englishName, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    Text(isHindi ? num.englishName : num.hindiName, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                    const SizedBox(height: 20),
                    // Counters
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(num.value, (_) => Text(num.objectEmoji, style: const TextStyle(fontSize: 36))),
                    ),
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
                    vm.playAudio(num);
                    vm.markCompleted('${num.value}');
                  },
                  icon: const Icon(Icons.volume_up, size: 32),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
                ),
                ElevatedButton(onPressed: _idx < AppData.numbers.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
