
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppData.words.length,
        itemBuilder: (context, idx) {
          final item = AppData.words[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Text(item.emoji, style: const TextStyle(fontSize: 32)),
              title: Text(item.hindi, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              subtitle: Text(item.english),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PracticeScreen(initialIndex: idx)));
                },
                child: const Text('ट्रेस करें'),
              ),
            ),
          );
        },
      ),
    );
  }
}
