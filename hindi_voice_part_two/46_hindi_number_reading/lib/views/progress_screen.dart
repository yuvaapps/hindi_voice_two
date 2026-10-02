
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
    final total = AppData.allItems.length;
    final done = vm.completedIds.length;
    final progress = total > 0 ? done / total : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: Text(loc.translate('progress')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overall stats
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF6A1B9A).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6)),
                ],
              ),
              child: Column(
                children: [
                  const Text('📊', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text('$done / $total',
                      style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text(loc.translate('completed_items'),
                      style: const TextStyle(
                          fontSize: 15, color: Colors.white70)),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}% complete',
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Score
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(icon: '⭐', label: '${vm.score}', sublabel: 'Score'),
                  _StatItem(
                      icon: '📂',
                      label: '${AppData.categoryNames.length}',
                      sublabel: 'Categories'),
                  _StatItem(
                      icon: '🏆',
                      label: done > 0 ? '${((done / total) * 100).toStringAsFixed(0)}%' : '0%',
                      sublabel: 'Mastery'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Per-category breakdown
            const Text(
              '📁 Category Progress',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C)),
            ),
            const SizedBox(height: 12),

            ...List.generate(AppData.categoryNames.length, (i) {
              final catItems = AppData.getCategory(i);
              final catDone = vm.completedIds
                  .where((id) {
                    final n = int.tryParse(id) ?? -1;
                    return catItems.any((item) => item.number == n);
                  })
                  .length;
              final catProgress =
                  catItems.isNotEmpty ? catDone / catItems.length : 0.0;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2)),
                  ],
                ),
                child: Row(
                  children: [
                    Text(AppData.categoryEmojis[i],
                        style: const TextStyle(fontSize: 26)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppData.categoryNames[i],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Text('$catDone / ${catItems.length}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: catProgress,
                              backgroundColor: Colors.purple.shade50,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  const Color(0xFF6A1B9A)),
                              minHeight: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String sublabel;
  const _StatItem(
      {required this.icon, required this.label, required this.sublabel});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A))),
          Text(sublabel,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      );
}
