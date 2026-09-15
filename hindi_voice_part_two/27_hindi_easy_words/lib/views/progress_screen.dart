
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.words.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  Text('$done / $total', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(value: total > 0 ? done / total : 0, minHeight: 12, color: AppTheme.accentColor),
                  ),
                  const SizedBox(height: 14),
                  Text('${loc.translate('total_score')}: ${vm.score}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
