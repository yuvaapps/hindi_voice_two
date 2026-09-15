
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
  bool _showBack = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final card = AppData.cards[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('${_idx + 1} / ${AppData.cards.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _showBack = !_showBack);
                  vm.playAudio(card);
                  vm.markCompleted(card.id);
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_showBack),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppTheme.primaryColor.withAlpha(50), width: 3),
                      boxShadow: [BoxShadow(color: Colors.purple.withAlpha(30), blurRadius: 16, offset: const Offset(0, 8))],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(card.emoji, style: const TextStyle(fontSize: 90)),
                        const SizedBox(height: 20),
                        Text(_showBack ? card.english : card.hindi, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: _showBack ? Colors.deepOrange : AppTheme.primaryColor)),
                        const SizedBox(height: 8),
                        Text(_showBack ? card.hindi : card.english, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                        const SizedBox(height: 24),
                        Text(loc.translate('tap_to_flip'), style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _idx > 0 ? () => setState(() { _idx--; _showBack = false; }) : null,
                  child: const Text('पिछला'),
                ),
                IconButton.filled(
                  onPressed: () => vm.playAudio(card),
                  icon: const Icon(Icons.volume_up, size: 30),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                ElevatedButton(
                  onPressed: _idx < AppData.cards.length - 1 ? () => setState(() { _idx++; _showBack = false; }) : null,
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
