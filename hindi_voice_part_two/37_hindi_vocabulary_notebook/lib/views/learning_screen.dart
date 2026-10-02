import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/vocab_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final String? initialCategory;
  const LearningScreen({super.key, this.initialCategory});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const Map<String, String> _categoryIcons = {
    'all': '📚',
    'animals': '🦁',
    'fruits': '🍎',
    'vegetables': '🥕',
    'body': '👁️',
    'nature': '🌳',
    'family': '👨‍👩‍👧',
    'colors': '🎨',
    'school': '🎒',
    'house': '🏠',
    'food': '🍲',
    'clothes': '👕',
    'vehicles': '🚗',
    'professions': '👨‍⚕️',
    'numbers': '🔢',
    'actions': '🏃',
    'emotions': '😊',
    'places': '🏛️',
    'flowers': '🌸',
    'festivals': '🪔',
    'opposites': '⚖️',
    'adjectives': '✨',
    'spices': '🌶️',
    'instruments': '🪕',
    'materials': '💎',
    'kitchen': '🍳',
    'sports': '⚽',
    'time': '⏰',
    'tech': '💻',
    'geography': '🏔️',
    'daily': '💬',
    'shopping': '🛍️',
    'health': '🩺',
    'arts': '🎭',
    'office': '🏢',
    'environment': '🌍',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<AppViewModel>();
      if (widget.initialCategory != null) {
        vm.setCategory(widget.initialCategory!);
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
    final isHindi = vm.locale.languageCode == 'hi';

    // Collect all unique categories from data
    final uniqueCats = <String>{'all'};
    for (final item in AppData.items) {
      uniqueCats.add(item.category);
    }
    final categoryList = uniqueCats.toList();

    // Filter items by category and search query
    final query = vm.searchQuery.toLowerCase();
    final filtered = AppData.items.where((i) {
      final matchesCategory = vm.category == 'all' || i.category == vm.category;
      if (!matchesCategory) return false;
      if (query.isEmpty) return true;
      return i.hindi.toLowerCase().contains(query) ||
          i.english.toLowerCase().contains(query) ||
          i.id.toLowerCase().contains(query);
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
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
              // Search Bar
              Container(
                color: AppTheme.primaryColor,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: loc.translate('search_hint'),
                      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              // Categories Horizontal Scroll List
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categoryList.length,
                  itemBuilder: (context, idx) {
                    final cat = categoryList[idx];
                    final isSelected = vm.category == cat;
                    final icon = _categoryIcons[cat] ?? '🏷️';
                    final title = loc.translate(cat);

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: BouncingWidget(
                        onTap: () => vm.setCategory(cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            boxShadow: isSelected
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
                              Text(icon, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(
                                title,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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

              // Active filter summary info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filtered.length} ${loc.translate('words_count')}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    if (vm.category != 'all' || vm.searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          vm.setCategory('all');
                          _searchController.clear();
                          vm.setSearchQuery('');
                        },
                        child: Text(
                          loc.translate('all'),
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Vocab Grid Cards
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
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, idx) {
                          final item = filtered[idx];
                          final isPlaying = vm.isItemPlaying(item.id);
                          final isDone = vm.completedIds.contains(item.id);

                          return StaggeredEntrance(
                            index: idx,
                            child: _VocabCard(
                              item: item,
                              isPlaying: isPlaying,
                              isDone: isDone,
                              isHindi: isHindi,
                              onPlayHindi: () => vm.playVocab(item, english: false),
                              onPlayEnglish: () => vm.playVocab(item, english: true),
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

class _VocabCard extends StatelessWidget {
  final VocabItem item;
  final bool isPlaying;
  final bool isDone;
  final bool isHindi;
  final VoidCallback onPlayHindi;
  final VoidCallback onPlayEnglish;

  const _VocabCard({
    required this.item,
    required this.isPlaying,
    required this.isDone,
    required this.isHindi,
    required this.onPlayHindi,
    required this.onPlayEnglish,
  });

  @override
  Widget build(BuildContext context) {
    final primaryTitle = isHindi ? item.hindi : item.english;
    final secondaryTitle = isHindi ? item.english : item.hindi;

    return TealGlowAura(
      isGlowing: isPlaying,
      glowColor: AppTheme.primaryColor,
      child: BouncingWidget(
        onTap: onPlayHindi,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPlaying
                  ? AppTheme.primaryColor
                  : (isDone ? const Color(0xFF80CBC4) : Colors.grey.shade200),
              width: isPlaying ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top row: Completed Badge & Sound Wave indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isDone)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 14, color: Color(0xFF2E7D32)),
                    )
                  else
                    const SizedBox(width: 22),
                  AudioSoundwaveWave(
                    isPlaying: isPlaying,
                    color: AppTheme.primaryColor,
                    height: 18,
                  ),
                ],
              ),

              // Center Floating Emoji
              FloatingAnimation(
                distance: 3.5,
                duration: Duration(milliseconds: 1600 + (item.id.hashCode % 500)),
                child: Text(
                  item.emoji,
                  style: const TextStyle(fontSize: 44),
                ),
              ),

              // Title and translation
              Column(
                children: [
                  Text(
                    primaryTitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isPlaying ? AppTheme.primaryColor : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    secondaryTitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Dual Audio Buttons: Hindi & English
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hindi audio button
                  InkWell(
                    onTap: onPlayHindi,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.volume_up, size: 14, color: AppTheme.primaryColor),
                          SizedBox(width: 3),
                          Text(
                            'HI',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // English audio button
                  InkWell(
                    onTap: onPlayEnglish,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB300).withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.volume_up, size: 14, color: Color(0xFFE65100)),
                          SizedBox(width: 3),
                          Text(
                            'EN',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE65100),
                            ),
                          ),
                        ],
                      ),
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
