import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar: Language switcher and Sound toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language Switcher
                  InkWell(
                    onTap: () => vm.toggleLanguage(),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppTheme.textColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.swap_horiz, size: 20, color: AppTheme.primaryColor),
                        ],
                      ),
                    ),
                  ),

                  // Sound Toggle
                  IconButton.filledTonal(
                    onPressed: () => vm.toggleSound(),
                    icon: Icon(
                      vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                      color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Hero Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.headerGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.35),
                      blurRadius: 12,
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
                            loc.translate('app_title'),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            loc.translate('subtitle'),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Text('🌈', style: TextStyle(fontSize: 40)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: [
                  _MenuCard(
                    title: loc.translate('start_learning'),
                    emoji: '📖',
                    color: const Color(0xFFFFE082),
                    accentColor: const Color(0xFFFF8F00),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LearningScreen()),
                      );
                    },
                  ),
                  _MenuCard(
                    title: loc.translate('practice'),
                    emoji: '🎯',
                    color: const Color(0xFFB3E5FC),
                    accentColor: const Color(0xFF0288D1),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PracticeScreen()),
                      );
                    },
                  ),
                  _MenuCard(
                    title: loc.translate('progress'),
                    emoji: '🌟',
                    color: const Color(0xFFC8E6C9),
                    accentColor: const Color(0xFF388E3C),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProgressScreen()),
                      );
                    },
                  ),
                  _MenuCard(
                    title: loc.translate('settings'),
                    emoji: '⚙️',
                    color: const Color(0xFFE1BEE7),
                    accentColor: const Color(0xFF8E24AA),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    },
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
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.emoji,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 42)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: accentColor.withOpacity(0.9),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
