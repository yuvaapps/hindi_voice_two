
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.prompts.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
