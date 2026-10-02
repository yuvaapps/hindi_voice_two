import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.numbers.length;
    final done = vm.completedIds.length;
    final percent = (done / total).clamp(0.0, 1.0);

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
                          Text(
                            '${(percent * 100).toInt()}% ${vm.locale.languageCode == 'hi' ? 'अनुरेखित' : 'Traced'}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                          ),
                          Text(
                            '⭐ ${vm.score} ${vm.locale.languageCode == 'hi' ? 'अंक' : 'Points'}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Numbers Tracing List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.draw, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        vm.locale.languageCode == 'hi' ? 'संख्या अनुरेखण स्थिति' : 'Number Tracing Mastery',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC2185B)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                ...List.generate(AppData.numbers.length, (i) {
                  final item = AppData.numbers[i];
                  final isDone = vm.completedIds.contains('${item.number}');
                  return BouncingWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LearningScreen(initialIndex: i)),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isDone ? const Color(0xFFFCE4EC) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDone ? AppTheme.primaryColor : Colors.grey.shade200,
                          width: isDone ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${item.devanagari} (${item.number}) - ${item.name}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.5,
                                        color: isDone ? AppTheme.primaryColor : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('• ${item.transliteration}',
                                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.englishName} • தமிழ்: ${item.tamilName}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          if (isDone)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('Traced ⭐',
                                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            )
                          else
                            const Icon(Icons.edit, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 16),
                // Celebrate Progress Button
                BouncingWidget(
                  onTap: vm.triggerConfetti,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🎉', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 8),
                        Text(
                          'Celebrate Progress',
                          style: TextStyle(color: Color(0xFF0091EA), fontWeight: FontWeight.bold),
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
