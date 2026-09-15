import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
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
      appBar: AppBar(
        title: Text(loc.translate('app_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton.icon(
            onPressed: vm.toggleLanguage,
            icon: const Icon(Icons.language, color: Colors.white, size: 18),
            label: Text(
              vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          IconButton(
            onPressed: vm.toggleSound,
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off, color: Colors.white),
            tooltip: vm.soundEnabled ? 'Mute' : 'Unmute',
          ),
          const SizedBox(width: 4),
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
            selectedIcon: const Icon(Icons.home),
            label: loc.translate('home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu_book_outlined),
            selectedIcon: const Icon(Icons.menu_book),
            label: loc.translate('learn'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.edit_note_outlined),
            selectedIcon: const Icon(Icons.edit_note),
            label: loc.translate('practice'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
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
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        loc.translate('subtitle'),
                        style: const TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const Text('✍️', style: TextStyle(fontSize: 48)),
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
            children: [
              _HomeNavCard(
                title: loc.translate('start_learning'),
                emoji: '📛',
                color: Colors.amber.shade50,
                borderColor: Colors.amber.shade200,
                onTap: () => onTabSelected(1),
              ),
              _HomeNavCard(
                title: loc.translate('practice'),
                emoji: '📝',
                color: Colors.cyan.shade50,
                borderColor: Colors.cyan.shade200,
                onTap: () => onTabSelected(2),
              ),
              _HomeNavCard(
                title: loc.translate('progress'),
                emoji: '🌟',
                color: Colors.green.shade50,
                borderColor: Colors.green.shade200,
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
              ),
              _HomeNavCard(
                title: loc.translate('settings'),
                emoji: '⚙️',
                color: Colors.purple.shade50,
                borderColor: Colors.purple.shade200,
                onTap: () => onTabSelected(3),
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
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;

  const _HomeNavCard({
    required this.title,
    required this.emoji,
    required this.color,
    required this.borderColor,
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
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 42)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
