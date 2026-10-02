
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
    final total = AppData.items.length;
    final completed = vm.completedIds.length;
    final progress = total > 0 ? completed / total : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
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
                      colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF6F00).withOpacity(0.4),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$completed / $total numbers',
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
                        child: const Text('🧮', style: TextStyle(fontSize: 56)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats
              StaggeredEntrance(
                delayMs: 100,
                child: Row(
                  children: [
                    _StatChip(icon: '🔢', label: '$total', sublabel: 'Numbers', color: const Color(0xFFFF6F00)),
                    const SizedBox(width: 10),
                    _StatChip(icon: '✅', label: '$completed', sublabel: 'Done', color: Colors.green.shade600),
                    const SizedBox(width: 10),
                    _StatChip(icon: '⭐', label: '${vm.score}', sublabel: 'Points', color: Colors.amber.shade700),
                    const SizedBox(width: 10),
                    _StatChip(icon: '🎯', label: '${(progress * 100).toStringAsFixed(0)}%', sublabel: 'Progress', color: const Color(0xFF5C6BC0)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Number showcase
              StaggeredEntrance(
                delayMs: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '🔢 Numbers',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF263238)),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: AppData.items.map((item) {
                        final isDone = vm.completedIds.contains('${item.count}');
                        return GestureDetector(
                          onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const LearningScreen())),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: isDone ? const Color(0xFFFF6F00) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: isDone
                                      ? const Color(0xFFFF6F00).withOpacity(0.35)
                                      : Colors.black12,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.devanagari,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDone ? Colors.white : const Color(0xFFFF6F00),
                                  ),
                                ),
                                Text(
                                  item.emoji,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Main action buttons
              StaggeredEntrance(
                delayMs: 300,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _ActionBtn(
                        label: loc.translate('start_learning'),
                        icon: Icons.school_rounded,
                        gradient: const [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LearningScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionBtn(
                        label: loc.translate('progress'),
                        icon: Icons.bar_chart_rounded,
                        gradient: const [Color(0xFF43E97B), Color(0xFF38F9D7)],
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ProgressScreen())),
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

class _ActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;
  const _ActionBtn({required this.label, required this.icon, required this.gradient, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: gradient[0].withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}
