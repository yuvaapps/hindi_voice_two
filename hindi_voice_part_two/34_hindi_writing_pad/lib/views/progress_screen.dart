import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String _filter = 'all'; // 'all', 'completed', 'pending'
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.prompts.length;
    final done = vm.completedIds.length;
    final percent = total > 0 ? (done / total) : 0.0;

    final filteredList = AppData.prompts.where((p) {
      final isDone = vm.completedIds.contains(p.text);
      if (_filter == 'completed' && !isDone) return false;
      if (_filter == 'pending' && isDone) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return p.text.toLowerCase().contains(q) ||
            p.english.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          loc.translate('progress'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Header Stats Card
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      FloatingAnimation(
                        offset: 4,
                        child: Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Text('🌟', style: TextStyle(fontSize: 32)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$done / $total',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${(percent * 100).toStringAsFixed(1)}% ${loc.translate('completed_items')}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars, color: Colors.black87, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${vm.score} pts',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percent.clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filters & Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildFilterChip('all', 'All ($total)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('completed', 'Done ($done)'),
                      const SizedBox(width: 8),
                      _buildFilterChip('pending', 'Pending (${total - done})'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Hindi or English prompt...',
                      prefixIcon: const Icon(Icons.search, color: AppTheme.accentColor),
                      fillColor: AppTheme.cardColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => setState(() => _searchQuery = val),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // Scrollable List of Prompts
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final prompt = filteredList[index];
                  final isDone = vm.completedIds.contains(prompt.text);
                  final originalIndex = AppData.prompts.indexOf(prompt);
                  final isPlaying = vm.isKeyPlaying(prompt.text);

                  return StaggeredEntrance(
                    index: index,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDone ? Colors.green.shade600 : Colors.white12,
                          width: 1.5,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.08),
                          child: Text(prompt.emoji, style: const TextStyle(fontSize: 20)),
                        ),
                        title: Row(
                          children: [
                            Text(
                              prompt.text,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDone ? const Color(0xFF76FF03) : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                prompt.category,
                                style: const TextStyle(fontSize: 10, color: Color(0xFF00E5FF)),
                              ),
                            ),
                          ],
                        ),
                        subtitle: prompt.english.isNotEmpty
                            ? Text(prompt.english, style: const TextStyle(fontSize: 12, color: Colors.white60))
                            : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isDone)
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.check_circle, color: Color(0xFF76FF03), size: 20),
                              ),
                            // Audio Button
                            AudioSoundwaveWave(
                              isPlaying: isPlaying,
                              waveColor: AppTheme.accentColor,
                              child: IconButton(
                                icon: const Icon(Icons.volume_up, color: AppTheme.accentColor, size: 20),
                                onPressed: () => vm.playPrompt(prompt),
                              ),
                            ),
                            // Write Button
                            BouncingWidget(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LearningScreen(
                                      initialIndex: originalIndex >= 0 ? originalIndex : 0,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppTheme.accentColor.withOpacity(0.5)),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, size: 14, color: AppTheme.accentColor),
                                    SizedBox(width: 4),
                                    Text(
                                      'लिखें',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.accentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: filteredList.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final isSelected = _filter == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _filter = key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.accentColor : AppTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.accentColor : Colors.white12,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black87 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
