import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/word_item.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<String> _categories = [
    'all',
    'home',
    'food',
    'family',
    'school',
    'body',
    'clothes',
    'places',
    'nature',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    // Filter items
    final filteredWords = AppData.dailyWords.where((w) {
      final matchesCat = vm.selectedCategory == 'all' || w.category == vm.selectedCategory;
      final query = vm.searchQuery.toLowerCase().trim();
      final matchesSearch = query.isEmpty ||
          w.hindi.contains(query) ||
          w.english.toLowerCase().contains(query);
      return matchesCat && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('start_learning')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => vm.toggleSound(),
            icon: Icon(
              vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            ),
          ),
          IconButton(
            onPressed: () => vm.toggleLanguage(),
            icon: Text(
              vm.locale.languageCode == 'hi' ? '🇮🇳' : '🇬🇧',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Category Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchCtrl,
                  onChanged: (val) => vm.setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: loc.translate('search_hint'),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              vm.setSearchQuery('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Category Chips
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, idx) {
                      final cat = _categories[idx];
                      final isSelected = (vm.selectedCategory == cat);
                      return ChoiceChip(
                        label: Text(loc.translate(cat)),
                        selected: isSelected,
                        onSelected: (_) => vm.setCategory(cat),
                        selectedColor: AppTheme.primaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppTheme.textColor,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Progress status bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${loc.translate('completed_items')}: ${vm.completedIds.length} / ${AppData.dailyWords.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '${vm.score}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cards Grid
          Expanded(
            child: filteredWords.isEmpty
                ? Center(
                    child: Text(
                      loc.translate('no_favorites'),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(14),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.88,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: filteredWords.length,
                    itemBuilder: (context, idx) {
                      final word = filteredWords[idx];
                      final isCompleted = vm.completedIds.contains(word.id);
                      final isFav = vm.favoriteIds.contains(word.id);
                      final isPlaying = (vm.currentPlayingId == word.id);

                      return _WordCard(
                        word: word,
                        isCompleted: isCompleted,
                        isFav: isFav,
                        isPlaying: isPlaying,
                        onPlay: () {
                          vm.playWordAudio(word);
                          vm.markCompleted(word.id);
                        },
                        onToggleFav: () => vm.toggleFavorite(word.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _WordCard extends StatelessWidget {
  final WordItem word;
  final bool isCompleted;
  final bool isFav;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onToggleFav;

  const _WordCard({
    required this.word,
    required this.isCompleted,
    required this.isFav,
    required this.isPlaying,
    required this.onPlay,
    required this.onToggleFav,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final isHindi = vm.locale.languageCode == 'hi';

    return InkWell(
      onTap: onPlay,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isPlaying
                ? AppTheme.primaryColor
                : (isCompleted ? AppTheme.accentColor.withOpacity(0.5) : Colors.black.withOpacity(0.08)),
            width: isPlaying ? 2.5 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isPlaying
                  ? AppTheme.primaryColor.withOpacity(0.25)
                  : Colors.black.withOpacity(0.06),
              blurRadius: isPlaying ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Top Row: Completed check & Favorite button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isCompleted)
                  const Icon(Icons.check_circle_rounded, color: AppTheme.accentColor, size: 20)
                else
                  const SizedBox(width: 20),
                InkWell(
                  onTap: onToggleFav,
                  child: Icon(
                    isFav ? Icons.star_rounded : Icons.star_border_rounded,
                    color: isFav ? Colors.amber : Colors.grey.shade400,
                    size: 24,
                  ),
                ),
              ],
            ),

            // Emoji / Visual
            Expanded(
              child: Center(
                child: AnimatedScale(
                  scale: isPlaying ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(word.emoji, style: const TextStyle(fontSize: 48)),
                ),
              ),
            ),

            // Hindi Word (Primary)
            Text(
              isHindi ? word.hindi : word.english,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Secondary Word (Translation)
            Text(
              isHindi ? word.english : word.hindi,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.subtitleColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // Speaker Icon
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                size: 20,
                color: isPlaying ? Colors.white : AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
