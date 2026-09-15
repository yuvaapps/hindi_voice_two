
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => vm.toggleLanguage(),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => vm.toggleSound(),
                    icon: Icon(vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.headerGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('🔤', style: TextStyle(fontSize: 48)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: [
                  _MenuCard(title: loc.translate('start_learning'), emoji: '📚', color: const Color(0xFFEDE7F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _MenuCard(title: loc.translate('practice'), emoji: '🧩', color: const Color(0xFFFCE4EC), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
                  _MenuCard(title: loc.translate('progress'), emoji: '🏆', color: const Color(0xFFE8F5E9), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _MenuCard(title: loc.translate('settings'), emoji: '⚙️', color: const Color(0xFFFFF3E0), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
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
  final VoidCallback onTap;

  const _MenuCard({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2),
          ],
        ),
      ),
    );
  }
}
