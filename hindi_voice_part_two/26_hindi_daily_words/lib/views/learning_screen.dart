import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/word_item.dart';
import '../utils/animation_utils.dart';
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
    'food',
    'fruits',
    'animals',
    'body',
    'home',
    'clothes',
    'nature',
    'family',
    'school',
    'vehicles',
    'places',
    'actions',
    'time',
    'general',
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
          BouncingWidget(
            onTap: () {
              setState(() {
                AppData.dailyWords.shuffle();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Text('🔀', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      Text('Daily words shuffled! नए शब्द तैयार हैं'),
                    ],
                  ),
                  backgroundColor: AppTheme.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(Icons.shuffle_rounded, size: 24),
            ),
          ),
          BouncingWidget(
            onTap: () => vm.toggleSound(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: AnimatedRotation(
                turns: vm.soundEnabled ? 0.0 : -0.1,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                ),
              ),
            ),
          ),
          BouncingWidget(
            onTap: () => vm.toggleLanguage(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                vm.locale.languageCode == 'hi' ? '🇮🇳' : '🇬🇧',
                style: const TextStyle(fontSize: 22),
              ),
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
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
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
                      return AnimatedScale(
                        scale: isSelected ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutBack,
                        child: ChoiceChip(
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Progress status bar with animated score pop
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${loc.translate('completed_items')}: ${vm.completedIds.length} / ${AppData.dailyWords.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PulsingScale(
                        minScale: 0.9,
                        maxScale: 1.15,
                        duration: const Duration(milliseconds: 900),
                        child: const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      ),
                      const SizedBox(width: 4),
                      TweenAnimationBuilder<int>(
                        tween: IntTween(begin: 0, end: vm.score),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, val, _) {
                          return Text(
                            '$val',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppTheme.primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cards Grid with Staggered Entrance and Lively Animations
          Expanded(
            child: filteredWords.isEmpty
                ? Center(
                    child: Text(
                      loc.translate('no_favorites'),
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    key: ValueKey('${vm.selectedCategory}_${vm.searchQuery}'),
                    padding: const EdgeInsets.all(14),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: filteredWords.length,
                    itemBuilder: (context, idx) {
                      final word = filteredWords[idx];
                      final isCompleted = vm.completedIds.contains(word.id);
                      final isFav = vm.favoriteIds.contains(word.id);
                      final isPlaying = (vm.currentPlayingId == word.id);

                      return StaggeredEntrance(
                        index: idx,
                        child: _WordCard(
                          word: word,
                          isCompleted: isCompleted,
                          isFav: isFav,
                          isPlaying: isPlaying,
                          onPlay: () {
                            vm.playWordAudio(word);
                            vm.markCompleted(word.id);
                          },
                          onToggleFav: () => vm.toggleFavorite(word.id),
                        ),
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

    return BouncingWidget(
      onTap: onPlay,
      scaleFactor: 0.94,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isPlaying
                ? AppTheme.primaryColor
                : (isCompleted ? AppTheme.accentColor.withOpacity(0.55) : Colors.black.withOpacity(0.08)),
            width: isPlaying ? 2.5 : (isCompleted ? 2.0 : 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: isPlaying
                  ? AppTheme.primaryColor.withOpacity(0.3)
                  : (isCompleted ? AppTheme.accentColor.withOpacity(0.12) : Colors.black.withOpacity(0.06)),
              blurRadius: isPlaying ? 12 : 6,
              spreadRadius: isPlaying ? 2 : 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            // Top Row: Completed check & Favorite button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isCompleted)
                  const ElasticPop(
                    child: Icon(Icons.check_circle_rounded, color: AppTheme.accentColor, size: 20),
                  )
                else
                  const SizedBox(width: 20, height: 20),
                BouncingWidget(
                  onTap: onToggleFav,
                  child: isFav
                    ? const ElasticPop(
                        child: Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                      )
                    : Icon(Icons.star_border_rounded, color: Colors.grey.shade400, size: 22),
                ),
              ],
            ),

            // Emoji / Visual with Sunburst Pulse when playing and Joyful Wobble
            Expanded(
              child: Center(
                child: isPlaying
                    ? SunburstPulse(
                        sunColor: const Color(0xFFFFD600),
                        radius: 36,
                        child: PulsingScale(
                          minScale: 1.0,
                          maxScale: 1.2,
                          duration: const Duration(milliseconds: 400),
                          child: Text(word.emoji, style: const TextStyle(fontSize: 44)),
                        ),
                      )
                    : WobbleAnimation(
                        duration: const Duration(milliseconds: 2200),
                        child: FloatingAnimation(
                          offset: 3.0,
                          duration: const Duration(milliseconds: 1900),
                          child: Text(word.emoji, style: const TextStyle(fontSize: 42)),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 2),

            // Hindi Word (Primary)
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
                fontFamily: 'NotoSansDevanagari',
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  isHindi ? word.hindi : word.english,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),

            // Secondary Word (Translation)
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                isHindi ? word.english : word.hindi,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.subtitleColor,
                ),
                maxLines: 1,
              ),
            ),

            const SizedBox(height: 4),

            // Speaker Icon with Audio Ripple Effect when playing
            AudioRippleEffect(
              isPlaying: isPlaying,
              rippleColor: AppTheme.primaryColor,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight.withOpacity(0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                  size: 17,
                  color: isPlaying ? Colors.white : AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
