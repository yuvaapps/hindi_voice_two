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
    final isHindi = vm.locale.languageCode == 'hi';
    final total = AppData.words.length;
    final done = vm.completedIds.length;
    final progressRatio = total > 0 ? (done / total).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('progress')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress Card
            StaggeredEntrance(
              index: 0,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FloatingAnimation(
                      offset: 6,
                      duration: const Duration(milliseconds: 1700),
                      child: PulsingScale(
                        minScale: 0.95,
                        maxScale: 1.08,
                        child: const Text('🌟', style: TextStyle(fontSize: 56)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progressRatio),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, _) {
                        return Text(
                          '${(val * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$done / $total ${loc.translate('completed_items')}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.subtitleColor),
                    ),
                    const SizedBox(height: 16),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progressRatio),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, _) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: val,
                            minHeight: 14,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                loc.translate('completed_items'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textColor),
              ),
            ),
            const SizedBox(height: 10),
            if (done == 0)
              StaggeredEntrance(
                index: 1,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Center(
                    child: Text(
                      '🌱 अभी कोई शब्द पूर्ण नहीं हुआ है। सीखना शुरू करें!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppData.words.length,
                itemBuilder: (context, idx) {
                  final word = AppData.words[idx];
                  if (!vm.completedIds.contains(word.id)) return const SizedBox.shrink();

                  final isPlaying = vm.currentPlayingId == word.id;

                  return StaggeredEntrance(
                    index: idx,
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: FloatingAnimation(
                          offset: 2.5,
                          duration: const Duration(milliseconds: 1700),
                          child: Text(word.emoji, style: const TextStyle(fontSize: 28)),
                        ),
                        title: Text(
                          isHindi ? word.hindi : word.english,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          isHindi ? word.english : word.hindi,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        trailing: AudioRippleEffect(
                          isPlaying: isPlaying,
                          rippleColor: AppTheme.primaryColor,
                          child: BouncingWidget(
                            onTap: () => vm.playWordAudio(word),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                color: isPlaying ? Colors.white : AppTheme.primaryColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
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
