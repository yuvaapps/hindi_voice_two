
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final totalWords = AppData.allItems.length;
    final completed = vm.completedIds.length;
    final progress = totalWords > 0 ? completed / totalWords : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: vm.toggleLanguage,
                    icon: Text(vm.locale.languageCode == 'hi' ? '🇮🇳' : '🇬🇧'),
                    label: Text(
                      vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 2,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: vm.toggleSound,
                        icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
                      ),
                      const SizedBox(width: 6),
                      IconButton.filledTonal(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                        icon: const Icon(Icons.settings_rounded),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Hero banner
              StaggeredEntrance(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF009688), Color(0xFF26C6DA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF009688).withOpacity(0.4),
                        blurRadius: 20,
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
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.translate('subtitle'),
                              style: const TextStyle(fontSize: 13, color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
                            // Progress bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$completed / $totalWords words',
                                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.white24,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      BouncingWidget(
                        child: const Text('✍️', style: TextStyle(fontSize: 56)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats row
              StaggeredEntrance(
                delayMs: 100,
                child: Row(
                  children: [
                    _StatChip(icon: '🔤', label: '$totalWords', sublabel: 'Words', color: const Color(0xFF5C6BC0)),
                    const SizedBox(width: 10),
                    _StatChip(icon: '✅', label: '$completed', sublabel: 'Done', color: const Color(0xFF26A69A)),
                    const SizedBox(width: 10),
                    _StatChip(icon: '⭐', label: '${vm.score}', sublabel: 'Points', color: const Color(0xFFF57C00)),
                    const SizedBox(width: 10),
                    _StatChip(icon: '📂', label: '${AppData.categoryNames.length}', sublabel: 'Topics', color: const Color(0xFFAB47BC)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Quick action cards
              StaggeredEntrance(
                delayMs: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        title: loc.translate('start_learning'),
                        emoji: '✍️',
                        gradient: const [Color(0xFF009688), Color(0xFF26C6DA)],
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionCard(
                        title: loc.translate('progress'),
                        emoji: '📊',
                        gradient: const [Color(0xFFFF6584), Color(0xFFFFBE76)],
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Category explorer
              StaggeredEntrance(
                delayMs: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '📚 Categories',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: AppData.categoryNames.length,
                      itemBuilder: (ctx, i) => _CategoryCard(
                        emoji: AppData.categoryEmojis[i],
                        name: AppData.categoryNames[i],
                        count: AppData.getCategory(i).length,
                        categoryIndex: i,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final String sublabel;
  final Color color;
  const _StatChip({required this.icon, required this.label, required this.sublabel, required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          Text(sublabel, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        ],
      ),
    ),
  );
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String emoji;
  final List<Color> gradient;
  final VoidCallback onTap;
  const _ActionCard({required this.title, required this.emoji, required this.gradient, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: gradient[0].withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 5))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 34)),
          const SizedBox(height: 6),
          Text(title, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    ),
  );
}

class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String name;
  final int count;
  final int categoryIndex;
  const _CategoryCard({required this.emoji, required this.name, required this.count, required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LearningScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 4),
            Text(name, textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text('$count', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
          ],
        ),
      ),
    );
  }
}
