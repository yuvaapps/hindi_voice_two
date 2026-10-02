import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _shuffleSeed = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.words.where((w) {
      final matchCat = vm.category == 'all' || w.category == vm.category;
      final q = vm.searchQuery.toLowerCase().trim();
      final matchQ = q.isEmpty || w.hindi.contains(q) || w.english.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();

    if (_shuffleSeed > 0) {
      final rnd = Random(_shuffleSeed);
      filtered.shuffle(rnd);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('start_learning')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          BouncingWidget(
            onTap: () {
              setState(() {
                _shuffleSeed = DateTime.now().millisecondsSinceEpoch;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isHindi ? '🔀 शब्द शफल हो गए!' : '🔀 Words shuffled!'),
                  duration: const Duration(milliseconds: 900),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(Icons.shuffle_rounded),
            ),
          ),
          BouncingWidget(
            onTap: vm.toggleSound,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedRotation(
                turns: vm.soundEnabled ? 0.0 : -0.1,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: TextField(
              onChanged: vm.setSearch,
              decoration: InputDecoration(
                hintText: loc.translate('search_hint'),
                prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                'all', 'food', 'fruits', 'animals', 'body', 'nature', 'family', 'home', 'clothes', 'vehicles', 'school', 'actions', 'places', 'time', 'general'
              ].map((cat) {
                final isSelected = vm.category == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 180),
                    child: ChoiceChip(
                      label: Text(loc.translate(cat)),
                      selected: isSelected,
                      onSelected: (_) => vm.setCategory(cat),
                      selectedColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.textColor,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              key: ValueKey('list_${vm.category}_${vm.searchQuery}_$_shuffleSeed'),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isFav = vm.favoriteIds.contains(word.id);
                final isCompleted = vm.completedIds.contains(word.id);

                return StaggeredEntrance(
                  index: idx,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: isPlaying
                            ? AppTheme.primaryColor
                            : (isCompleted ? AppTheme.accentColor.withOpacity(0.5) : Colors.transparent),
                        width: isPlaying ? 2.0 : 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: isPlaying
                          ? GalaxyOrbitSpin(
                              radius: 22,
                              child: Text(word.emoji, style: const TextStyle(fontSize: 32)),
                            )
                          : FloatingAnimation(
                              offset: 2.5,
                              duration: const Duration(milliseconds: 1800),
                              child: Text(word.emoji, style: const TextStyle(fontSize: 32)),
                            ),
                      title: Text(
                        isHindi ? word.hindi : word.english,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
                        ),
                      ),
                      subtitle: Text(
                        isHindi ? word.english : word.hindi,
                        style: const TextStyle(color: AppTheme.subtitleColor),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BouncingWidget(
                            onTap: () => vm.toggleFavorite(word.id),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: isFav
                                  ? const ElasticPop(child: Icon(Icons.star_rounded, color: Colors.amber, size: 26))
                                  : Icon(Icons.star_border_rounded, color: Colors.grey.shade400, size: 26),
                            ),
                          ),
                          const SizedBox(width: 4),
                          NebulaPulseAura(
                            child: AudioRippleEffect(
                              isPlaying: isPlaying,
                              rippleColor: AppTheme.primaryColor,
                              child: BouncingWidget(
                                onTap: () {
                                  vm.playWordAudio(word);
                                  vm.markCompleted(word.id);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                    color: isPlaying ? Colors.white : AppTheme.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
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
        ],
      ),
    );
  }
}
