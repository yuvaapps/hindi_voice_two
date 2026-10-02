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
            // Animated Progress Card
            StaggeredEntrance(
              index: 0,
              slideOffset: 20,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentColor.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Floating celebration star
                    FloatingAnimation(
                      offset: 6,
                      duration: const Duration(milliseconds: 1700),
                      child: PulsingScale(
                        minScale: 0.95,
                        maxScale: 1.08,
                        duration: const Duration(milliseconds: 1200),
                        child: const Text('🌟', style: TextStyle(fontSize: 52)),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Animated Percentage Counter
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.0, end: progressRatio),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, _) {
                        return Text(
                          '${(val * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        );
                      },
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
                    const SizedBox(height: 18),

                    // Animated Progress Bar Fill
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
                            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    // Animated Total Score
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PulsingScale(
                          minScale: 0.9,
                          maxScale: 1.15,
                          duration: const Duration(milliseconds: 900),
                          child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 30),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${loc.translate('total_score')}: ',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textColor,
                                ),
                              ),
                              TweenAnimationBuilder<int>(
                                tween: IntTween(begin: 0, end: vm.score),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, scoreVal, _) {
                                  return Text(
                                    '$scoreVal',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Completed List Section Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                loc.translate('completed_items'),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            const SizedBox(height: 10),

            if (completedCount == 0)
              StaggeredEntrance(
                index: 1,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                itemCount: AppData.dailyWords.length,
                itemBuilder: (context, idx) {
                  final word = AppData.dailyWords[idx];
                  if (!vm.completedIds.contains(word.id)) return const SizedBox.shrink();

                  final isPlaying = (vm.currentPlayingId == word.id);

                  return StaggeredEntrance(
                    index: idx,
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: FloatingAnimation(
                          offset: 2.5,
                          duration: const Duration(milliseconds: 1800),
                          child: Text(word.emoji, style: const TextStyle(fontSize: 30)),
                        ),
                        title: Text(
                          isHindi ? word.hindi : word.english,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          isHindi ? word.english : word.hindi,
                          style: const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        trailing: AudioRippleEffect(
                          isPlaying: isPlaying,
                          rippleColor: AppTheme.primaryColor,
                          child: BouncingWidget(
                            onTap: () => vm.playWordAudio(word),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isPlaying
                                    ? AppTheme.primaryColor
                                    : AppTheme.primaryColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                color: isPlaying ? Colors.white : AppTheme.primaryColor,
                                size: 20,
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
