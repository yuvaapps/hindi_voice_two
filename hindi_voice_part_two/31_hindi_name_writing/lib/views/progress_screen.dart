import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.names.length;
    final done = vm.completedIds.length;
    final percent = total > 0 ? (done / total) : 0.0;
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(loc.translate('progress'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Progress Card
              StaggeredEntrance(
                index: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? 'नाम लेखन प्रगति' : 'Name Writing Mastery',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$done / $total ${loc.translate('completed_items')}',
                              style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: percent,
                                minHeight: 10,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${(percent * 100).toInt()}% ${isHindi ? 'पूर्ण' : 'Mastered'}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const FloatingAnimation(
                        offset: 6.0,
                        duration: Duration(milliseconds: 1800),
                        child: Text('🌟', style: TextStyle(fontSize: 58)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Stat Boxes Row
              Row(
                children: [
                  Expanded(
                    child: StaggeredEntrance(
                      index: 1,
                      child: _StatCard(
                        title: isHindi ? 'कुल नाम' : 'Total Names',
                        value: '$total',
                        emoji: '📛',
                        color: const Color(0xFFE0F7FA),
                        borderColor: const Color(0xFF80DEEA),
                        textColor: const Color(0xFF006064),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StaggeredEntrance(
                      index: 2,
                      child: _StatCard(
                        title: isHindi ? 'लिखे गए' : 'Written',
                        value: '$done',
                        emoji: '✍️',
                        color: const Color(0xFFE8F5E9),
                        borderColor: const Color(0xFFA5D6A7),
                        textColor: const Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StaggeredEntrance(
                      index: 3,
                      child: _StatCard(
                        title: isHindi ? 'अंक' : 'Score',
                        value: '${vm.score}',
                        emoji: '⭐',
                        color: const Color(0xFFFFF8E1),
                        borderColor: const Color(0xFFFFD54F),
                        textColor: const Color(0xFFFF8F00),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Names Index Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isHindi ? '📜 सभी नाम सूची' : '📜 Names Roster',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  Text(
                    '$done/$total',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // List of names with completion status
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppData.names.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, idx) {
                  final name = AppData.names[idx];
                  final isDone = vm.completedIds.contains(name.id);
                  final isPlaying = vm.currentPlayingId == name.id;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isPlaying
                            ? AppTheme.primaryColor
                            : (isDone ? const Color(0xFF80DEEA) : const Color(0xFFE0E0E0)),
                        width: isPlaying ? 2 : 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text('${idx + 1}.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.hindi,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textColor),
                              ),
                              Text(
                                '${name.english} • ${name.meaning}',
                                style: TextStyle(fontSize: 12, color: AppTheme.subtitleColor.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                        if (isDone)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.check_circle, size: 14, color: Color(0xFF2E7D32)),
                                SizedBox(width: 4),
                                Text(
                                  'Mastered',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                                ),
                              ],
                            ),
                          )
                        else
                          BouncingWidget(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => PracticeScreen(initialIndex: idx)),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F7FA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Write ✍️',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00838F)),
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        BouncingWidget(
                          onTap: () => vm.playNameAudio(name),
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.volume_up_rounded,
                              size: 16,
                              color: isPlaying ? Colors.white : AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String emoji;
  final Color color;
  final Color borderColor;
  final Color textColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.emoji,
    required this.color,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
