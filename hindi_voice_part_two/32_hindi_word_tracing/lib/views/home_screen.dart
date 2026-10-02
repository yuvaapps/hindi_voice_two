import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'practice_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final totalWords = AppData.words.length;
    final doneCount = vm.completedIds.length;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with Language & Sound Toggles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BouncingWidget(
                    onTap: vm.toggleLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.textColor),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.sync_alt, size: 16, color: AppTheme.primaryColor),
                        ],
                      ),
                    ),
                  ),
                  BouncingWidget(
                    onTap: vm.toggleSound,
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: vm.soundEnabled ? AppTheme.primaryLight : Colors.grey.shade200,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                        color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Royal Indigo Hero Banner
              StaggeredEntrance(
                index: 0,
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.4),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
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
                              loc.translate('app_title'),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              loc.translate('subtitle'),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.92),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.22),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '🖍️ $doneCount / $totalWords Traced • ⭐ ${vm.score}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const FloatingAnimation(
                        offset: 7.0,
                        duration: Duration(milliseconds: 2000),
                        child: Text('🖍️', style: TextStyle(fontSize: 60)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // Menu Navigation Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: [
                  StaggeredEntrance(
                    index: 1,
                    child: _MenuCard(
                      title: loc.translate('start_learning'),
                      emoji: '📋',
                      subtitle: '$totalWords words',
                      bgColor: const Color(0xFFE8EAF6),
                      borderColor: const Color(0xFF9FA8DA),
                      textColor: const Color(0xFF1A237E),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 2,
                    child: _MenuCard(
                      title: loc.translate('practice'),
                      emoji: '✏️',
                      subtitle: 'Tracing Slate',
                      bgColor: const Color(0xFFE1F5FE),
                      borderColor: const Color(0xFF81D4FA),
                      textColor: const Color(0xFF01579B),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 3,
                    child: _MenuCard(
                      title: loc.translate('progress'),
                      emoji: '🌟',
                      subtitle: '$doneCount / $totalWords done',
                      bgColor: const Color(0xFFFFF8E1),
                      borderColor: const Color(0xFFFFD54F),
                      textColor: const Color(0xFFFF8F00),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 4,
                    child: _MenuCard(
                      title: loc.translate('settings'),
                      emoji: '⚙️',
                      subtitle: 'Preferences',
                      bgColor: const Color(0xFFF3E5F5),
                      borderColor: const Color(0xFFCE93D8),
                      textColor: const Color(0xFF4A148C),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String subtitle;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.emoji,
    required this.subtitle,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingAnimation(
              offset: 3.0,
              duration: const Duration(milliseconds: 2200),
              child: Text(emoji, style: const TextStyle(fontSize: 42)),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: textColor.withOpacity(0.75)),
            ),
          ],
        ),
      ),
    );
  }
}
