
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/num100_item.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.numbers.where((n) {
      final q = vm.searchQuery.toLowerCase().trim();
      if (q.isEmpty) return true;
      return '${n.number}'.contains(q) || n.devanagari.contains(q) || n.hindiName.contains(q) || n.englishName.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('app_title')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: vm.setSearch,
              decoration: InputDecoration(
                hintText: loc.translate('search_hint'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final item = filtered[idx];
                final isDone = vm.completedIds.contains('${item.number}');

                return InkWell(
                  onTap: () {
                    vm.playAudio(item);
                    vm.markCompleted(item.number);
                    _showDetail(context, item, isHindi, vm);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDone ? Colors.green.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Center(
                      child: Text(item.devanagari, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
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

  void _showDetail(BuildContext context, Num100Item item, bool isHindi, AppViewModel vm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.devanagari, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                const SizedBox(width: 20),
                Text('(${item.number})', style: const TextStyle(fontSize: 32, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Text(isHindi ? item.hindiName : item.englishName, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            Text(isHindi ? item.englishName : item.hindiName, style: const TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 16),
            IconButton.filled(
              onPressed: () => vm.playAudio(item),
              icon: const Icon(Icons.volume_up, size: 36),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
            ),
          ],
        ),
      ),
    );
  }
}
