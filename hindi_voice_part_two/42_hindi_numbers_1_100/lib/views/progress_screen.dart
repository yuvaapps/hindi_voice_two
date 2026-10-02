import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.numbers.length;
    final done = vm.completedIds.length;
    final percent = (done / total).clamp(0.0, 1.0);

    final ranges = [
      {'title': '१ - २० (Numbers 1-20)', 'tag': '1-20', 'range': [1, 20]},
      {'title': '२१ - ४० (Numbers 21-40)', 'tag': '21-40', 'range': [21, 40]},
      {'title': '४१ - ६० (Numbers 41-60)', 'tag': '41-60', 'range': [41, 60]},
      {'title': '६१ - ८० (Numbers 61-80)', 'tag': '61-80', 'range': [61, 80]},
      {'title': '८१ - १०० (Numbers 81-100)', 'tag': '81-100', 'range': [81, 100]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('progress')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                // Top Progress Hero Card
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const FloatingAnimation(
                        offset: 8.0,
                        child: Text('🌟', style: TextStyle(fontSize: 64)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$done / $total',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        loc.translate('completed_items'),
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                          minHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${(percent * 100).toInt()}% ${vm.locale.languageCode == 'hi' ? 'पूर्ण' : 'Completed'}',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                          Text('⭐ ${vm.score} ${vm.locale.languageCode == 'hi' ? 'अंक' : 'Points'}',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.secondaryColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Milestones Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.military_tech, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        vm.locale.languageCode == 'hi' ? 'संख्या समूह प्रगति' : 'Milestone Mastery',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                ...ranges.map((r) {
                  final rangeList = r['range'] as List<int>;
                  final start = rangeList[0];
                  final end = rangeList[1];
                  int groupCompleted = 0;
                  for (int i = start; i <= end; i++) {
                    if (vm.completedIds.contains('$i')) groupCompleted++;
                  }
                  final groupTotal = end - start + 1;
                  final isMastered = groupCompleted == groupTotal;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isMastered ? const Color(0xFFE8F5E9) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isMastered ? AppTheme.primaryColor : Colors.grey.shade200,
                        width: isMastered ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          isMastered ? '🏆' : '🎯',
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['title'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isMastered ? AppTheme.primaryColor : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$groupCompleted / $groupTotal ${vm.locale.languageCode == 'hi' ? 'संख्या' : 'Numbers'}',
                                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        if (isMastered)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('Passed! ⭐',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 16),
                // Celebrate button
                BouncingWidget(
                  onTap: vm.triggerConfetti,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F00).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF6F00).withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🎉', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8),
                        Text(
                          'Celebrate Progress',
                          style: TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CelebrationConfettiBurst(show: vm.showConfetti),
        ],
      ),
    );
  }
}
