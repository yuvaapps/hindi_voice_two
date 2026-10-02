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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    final List<Widget> pages = [
      _HomeTabContent(onTabSelected: (index) => setState(() => _currentIndex = index)),
      const LearningScreen(isTab: true),
      const PracticeScreen(isTab: true),
      const SettingsScreen(isTab: true),
    ];

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          loc.translate('app_title'),
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          BouncingWidget(
            onTap: vm.toggleLanguage,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language_rounded, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          BouncingWidget(
            onTap: vm.toggleSound,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: loc.translate('home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu_book_outlined),
            selectedIcon: const Icon(Icons.menu_book_rounded),
            label: loc.translate('learn'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.edit_note_outlined),
            selectedIcon: const Icon(Icons.edit_note_rounded),
            label: loc.translate('practice'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings_rounded),
            label: loc.translate('settings'),
          ),
        ],
      ),
    );
  }
}

class _HomeTabContent extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  const _HomeTabContent({required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final totalNames = AppData.names.length;
    final doneCount = vm.completedIds.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cyan Oceanic Hero Banner
          StaggeredEntrance(
            index: 0,
            child: Container(
              padding: const EdgeInsets.all(22),
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
                            color: Colors.white.withOpacity(0.9),
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
                            '✍️ $doneCount / $totalNames Names Mastered • ⭐ ${vm.score}',
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
                    offset: 6.0,
                    duration: Duration(milliseconds: 2000),
                    child: Text('🖋️', style: TextStyle(fontSize: 60)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Menu Navigation Cards
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
                child: _HomeNavCard(
                  title: loc.translate('start_learning'),
                  emoji: '📛',
                  subtitle: '$totalNames names',
                  bgColor: const Color(0xFFE0F7FA),
                  borderColor: const Color(0xFF80DEEA),
                  textColor: const Color(0xFF006064),
                  onTap: () => onTabSelected(1),
                ),
              ),
              StaggeredEntrance(
                index: 2,
                child: _HomeNavCard(
                  title: loc.translate('practice'),
                  emoji: '📝',
                  subtitle: 'Calligraphy Slate',
                  bgColor: const Color(0xFFE1F5FE),
                  borderColor: const Color(0xFF81D4FA),
                  textColor: const Color(0xFF01579B),
                  onTap: () => onTabSelected(2),
                ),
              ),
              StaggeredEntrance(
                index: 3,
                child: _HomeNavCard(
                  title: loc.translate('progress'),
                  emoji: '🌟',
                  subtitle: '$doneCount / $totalNames done',
                  bgColor: const Color(0xFFE8F5E9),
                  borderColor: const Color(0xFFA5D6A7),
                  textColor: const Color(0xFF1B5E20),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProgressScreen()),
                  ),
                ),
              ),
              StaggeredEntrance(
                index: 4,
                child: _HomeNavCard(
                  title: loc.translate('settings'),
                  emoji: '⚙️',
                  subtitle: 'Preferences',
                  bgColor: const Color(0xFFEDE7F6),
                  borderColor: const Color(0xFFD1C4E9),
                  textColor: const Color(0xFF4A148C),
                  onTap: () => onTabSelected(3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeNavCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String subtitle;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;

  const _HomeNavCard({
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
