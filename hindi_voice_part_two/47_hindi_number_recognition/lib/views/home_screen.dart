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
    final total = AppData.allItems.length;
    final completed = vm.completedIds.length;
    final progress = total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top Bar ──────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: vm.toggleLanguage,
                    icon: Text(
                      vm.locale.languageCode == 'hi' ? '🇮🇳' : '🇬🇧',
                      style: const TextStyle(fontSize: 18),
                    ),
                    label: Text(
                      vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        onPressed: vm.toggleSound,
                        icon: Icon(vm.soundEnabled
                            ? Icons.volume_up_rounded
                            : Icons.volume_off_rounded),
                      ),
                      const SizedBox(width: 6),
                      IconButton.filledTonal(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SettingsScreen()),
                        ),
                        icon: const Icon(Icons.settings_rounded),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Hero Banner ──────────────────────────────────────────────
              StaggeredEntrance(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC2185B), Color(0xFFE91E63)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC2185B).withOpacity(0.4),
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
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white70),
                            ),
                            const SizedBox(height: 14),
                            // Progress bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$completed / $total ${loc.translate('done')}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                    ),
                                    Text(
                                      '${(progress * 100).toStringAsFixed(1)}%',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.white24,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      BouncingWidget(
                        amplitude: 6,
                        child: const Text('🎧', style: TextStyle(fontSize: 58)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── 4 Stats Chips ────────────────────────────────────────────
              StaggeredEntrance(
                delayMs: 100,
                child: Row(
                  children: [
                    _StatChip(
                      icon: '🔢',
                      label: '$total',
                      sublabel: loc.translate('total'),
                      color: const Color(0xFFC2185B),
                    ),
                    const SizedBox(width: 8),
                    _StatChip(
                      icon: '✅',
                      label: '$completed',
                      sublabel: loc.translate('done'),
                      color: const Color(0xFF2E7D32),
                    ),
                    const SizedBox(width: 8),
                    _StatChip(
                      icon: '🔥',
                      label: '${vm.streak}',
                      sublabel: loc.translate('streak'),
                      color: const Color(0xFFE65100),
                    ),
                    const SizedBox(width: 8),
                    _StatChip(
                      icon: '⭐',
                      label: '${vm.score}',
                      sublabel: loc.translate('score'),
                      color: const Color(0xFF7B1FA2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Quick Action Cards ───────────────────────────────────────
              StaggeredEntrance(
                delayMs: 200,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _ActionCard(
                        title: loc.translate('start_learning'),
                        emoji: '🎧',
                        subtitle: '1000+ संख्याएँ व शब्द',
                        gradient: const [
                          Color(0xFFC2185B),
                          Color(0xFFE91E63)
                        ],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LearningScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: _ActionCard(
                        title: loc.translate('progress'),
                        emoji: '📊',
                        subtitle: '${(progress * 100).toStringAsFixed(0)}% लक्ष्य',
                        gradient: const [
                          Color(0xFF7B1FA2),
                          Color(0xFFAB47BC)
                        ],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProgressScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Category Grid Header ─────────────────────────────────────
              StaggeredEntrance(
                delayMs: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '📚 श्रेणियाँ  •  All Categories',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF880E4F),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${AppData.categoryNames.length} topics',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.92,
                      ),
                      itemCount: AppData.categoryNames.length,
                      itemBuilder: (ctx, i) {
                        final catTotal = AppData.getCategory(i).length;
                        final catDone = vm.completedIds.where((id) {
                          final n = int.tryParse(id) ?? -1;
                          return AppData.getCategory(i)
                              .any((item) => item.number == n);
                        }).length;

                        return _CategoryCard(
                          emoji: AppData.categoryEmojis[i],
                          name: AppData.categoryNames[i],
                          total: catTotal,
                          done: catDone,
                          categoryIndex: i,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _StatChip
// ─────────────────────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final String sublabel;
  final Color color;
  const _StatChip(
      {required this.icon,
      required this.label,
      required this.sublabel,
      required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.18),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
              Text(
                sublabel,
                style:
                    TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// _ActionCard
// ─────────────────────────────────────────────────────────────────────────────
class _ActionCard extends StatelessWidget {
  final String title;
  final String emoji;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;
  const _ActionCard({
    required this.title,
    required this.emoji,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 34)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// _CategoryCard
// ─────────────────────────────────────────────────────────────────────────────
class _CategoryCard extends StatelessWidget {
  final String emoji;
  final String name;
  final int total;
  final int done;
  final int categoryIndex;
  const _CategoryCard({
    required this.emoji,
    required this.name,
    required this.total,
    required this.done,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (done / total).clamp(0.0, 1.0) : 0.0;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              LearningScreen(initialCategory: categoryIndex),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                  child: CircularProgressIndicator(
                    value: pct,
                    strokeWidth: 4,
                    backgroundColor: Colors.pink.shade50,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFC2185B)),
                  ),
                ),
                Text(emoji, style: const TextStyle(fontSize: 26)),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
            ),
            Text(
              '$done/$total',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
