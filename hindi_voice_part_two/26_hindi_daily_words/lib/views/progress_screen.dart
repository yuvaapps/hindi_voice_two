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
    final isHindi = vm.locale.languageCode == 'hi';

    final totalWords = AppData.dailyWords.length;
    final completedCount = vm.completedIds.length;
    final progressRatio = totalWords > 0 ? (completedCount / totalWords).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('progress')),
        backgroundColor: AppTheme.accentColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text('🌟', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 10),
                  Text(
                    '${(progressRatio * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$completedCount / $totalWords ${loc.translate('completed_items')}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progressRatio,
                      minHeight: 14,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        '${loc.translate('total_score')}: ${vm.score}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Completed List Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                loc.translate('completed_items'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            const SizedBox(height: 10),

            if (completedCount == 0)
              Container(
                padding: const EdgeInsets.all(24),
                child: const Text(
                  '🌱 अभी कोई शब्द पूर्ण नहीं हुआ है। सीखना शुरू करें!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppData.dailyWords.length,
                itemBuilder: (context, idx) {
                  final word = AppData.dailyWords[idx];
                  if (!vm.completedIds.contains(word.id)) return const SizedBox.shrink();

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Text(word.emoji, style: const TextStyle(fontSize: 28)),
                      title: Text(
                        isHindi ? word.hindi : word.english,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        isHindi ? word.english : word.hindi,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.volume_up_rounded, color: AppTheme.primaryColor),
                        onPressed: () => vm.playWordAudio(word),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
