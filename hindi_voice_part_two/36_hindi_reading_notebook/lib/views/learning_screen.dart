import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/reading_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int? initialLevel;
  const LearningScreen({super.key, this.initialLevel});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';

  static const List<Map<String, dynamic>> _levelsMeta = [
    {'level': 1, 'icon': '🔤', 'label': 'स्तर १', 'title': 'वर्णमाला व बारहखड़ी'},
    {'level': 2, 'icon': '📖', 'label': 'स्तर २', 'title': 'दो अक्षर शब्द'},
    {'level': 3, 'icon': '📝', 'label': 'स्तर ३', 'title': 'तीन अक्षर शब्द'},
    {'level': 4, 'icon': '📚', 'label': 'स्तर ४', 'title': 'चार अक्षर व वाक्यांश'},
    {'level': 5, 'icon': '📜', 'label': 'स्तर ५', 'title': 'सरल वाक्य व कहानियाँ'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<AppViewModel>();
      if (widget.initialLevel != null) {
        vm.setLevel(widget.initialLevel!);
      }
      _searchController.addListener(() {
        vm.setSearchQuery(_searchController.text.trim());
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    // Items for current level
    final levelItems = AppData.items.where((i) => i.level == vm.selectedLevel).toList();

    // Unique categories in current level
    final uniqueCats = <String>{'all'};
    for (final item in levelItems) {
      if (item.category.isNotEmpty) uniqueCats.add(item.category);
    }
    final categories = uniqueCats.toList();

    // Filter by search and category
    final query = vm.searchQuery.toLowerCase();
    final filtered = levelItems.where((i) {
      final matchesCat = _selectedCategory == 'all' || i.category == _selectedCategory;
      if (!matchesCat) return false;
      if (query.isEmpty) return true;
      return i.hindi.toLowerCase().contains(query) ||
          i.english.toLowerCase().contains(query) ||
          i.breakdown.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          loc.translate('start_learning'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
            tooltip: loc.translate('sound'),
            onPressed: vm.toggleSound,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${vm.completedIds.length}/${AppData.items.length}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Search Input Box
              Container(
                color: AppTheme.primaryColor,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: loc.translate('search_hint'),
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                      prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                vm.setSearchQuery('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),

              // Level Selector Horizontal Bar
              Container(
                height: 58,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _levelsMeta.length,
                  itemBuilder: (context, idx) {
                    final meta = _levelsMeta[idx];
                    final lvl = meta['level'] as int;
                    final isSel = (vm.selectedLevel == lvl);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: BouncingWidget(
                        onTap: () {
                          vm.setLevel(lvl);
                          setState(() => _selectedCategory = 'all');
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSel ? AppTheme.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSel ? AppTheme.primaryColor : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            boxShadow: isSel
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              Text(meta['icon'] as String, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(
                                meta['label'] as String,
                                style: TextStyle(
                                  color: isSel ? Colors.white : Colors.black87,
                                  fontWeight: isSel ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Subcategory Chips (if level has categories)
              if (categories.length > 2)
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: categories.length,
                    itemBuilder: (context, idx) {
                      final cat = categories[idx];
                      final isSelected = _selectedCategory == cat;

                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(
                            cat == 'all' ? loc.translate('all') : cat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF00796B),
                          backgroundColor: Colors.white,
                          onSelected: (_) => setState(() => _selectedCategory = cat),
                        ),
                      );
                    },
                  ),
                ),

              // Summary Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filtered.length} पाठ उपलब्ध',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      _levelsMeta[vm.selectedLevel - 1]['title'] as String,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Reading Cards List
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🔍', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 12),
                            Text(
                              loc.translate('search_hint'),
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
                        itemCount: filtered.length,
                        itemBuilder: (context, idx) {
                          final item = filtered[idx];
                          final isPlaying = vm.isItemPlaying(item.hindi);
                          final isDone = vm.completedIds.contains(item.hindi);

                          return StaggeredEntrance(
                            index: idx,
                            child: _ReadingCard(
                              item: item,
                              isPlaying: isPlaying,
                              isDone: isDone,
                              onPlayHindi: () => vm.playItem(item, english: false),
                              onPlayEnglish: () => vm.playItem(item, english: true),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),

          // Confetti celebration overlay
          CelebrationConfettiBurst(
            show: vm.showConfetti,
            onFinished: vm.dismissCelebration,
          ),
        ],
      ),
    );
  }
}

class _ReadingCard extends StatelessWidget {
  final ReadingItem item;
  final bool isPlaying;
  final bool isDone;
  final VoidCallback onPlayHindi;
  final VoidCallback onPlayEnglish;

  const _ReadingCard({
    required this.item,
    required this.isPlaying,
    required this.isDone,
    required this.onPlayHindi,
    required this.onPlayEnglish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPlaying
              ? AppTheme.primaryColor
              : (isDone ? const Color(0xFF80CBC4) : Colors.grey.shade200),
          width: isPlaying ? 2.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isPlaying ? AppTheme.primaryColor.withOpacity(0.18) : Colors.black.withOpacity(0.03),
            blurRadius: isPlaying ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Category Tag & Soundwave
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.scaffoldBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.category,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  AudioSoundwaveWave(
                    isPlaying: isPlaying,
                    color: AppTheme.primaryColor,
                    height: 18,
                  ),
                  if (isDone) ...[
                    const SizedBox(width: 6),
                    const Icon(Icons.check_circle, size: 16, color: Color(0xFF2E7D32)),
                  ],
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Center: Large Hindi Text with Floating Emoji
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingAnimation(
                distance: 4,
                child: Text(
                  item.emoji,
                  style: const TextStyle(fontSize: 38),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.hindi,
                      style: TextStyle(
                        fontSize: item.hindi.length > 20 ? 20 : 26,
                        fontWeight: FontWeight.bold,
                        color: isPlaying ? AppTheme.primaryColor : const Color(0xFF1E293B),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.english,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Breakdown Pill (if present)
          if (item.breakdown.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFFECB3)),
              ),
              child: Text(
                'विच्छेद: ${item.breakdown}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF57F17),
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Action Buttons: Listen Hindi & Listen English
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BouncingWidget(
                onTap: onPlayHindi,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.volume_up, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'हिन्दी सुनें',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              BouncingWidget(
                onTap: onPlayEnglish,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFB300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.volume_up, size: 14, color: Colors.black87),
                      SizedBox(width: 4),
                      Text(
                        'English',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
