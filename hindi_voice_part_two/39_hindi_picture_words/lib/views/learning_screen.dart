
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
  bool _revealed = false;

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
              child: GestureDetector(
                onTap: () {
                  setState(() => _revealed = true);
                  vm.playAudio(item.audio);
                  vm.markCompleted(item.id);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 110)),
                      const SizedBox(height: 24),
                      if (_revealed) ...[
                        Text(item.hindi, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        Text(item.english, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20)),
                          child: Text(loc.translate('tap_to_reveal'), style: const TextStyle(fontSize: 16, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _idx > 0 ? () => setState(() { _idx--; _revealed = false; }) : null,
                  child: const Text('पिछला'),
                ),
                IconButton.filled(
                  onPressed: () {
                    setState(() => _revealed = true);
                    vm.playAudio(item.audio);
                  },
                  icon: const Icon(Icons.volume_up, size: 30),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                ElevatedButton(
                  onPressed: _idx < AppData.items.length - 1 ? () => setState(() { _idx++; _revealed = false; }) : null,
                  child: const Text('अगला'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
