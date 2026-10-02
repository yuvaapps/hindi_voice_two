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
  String _search = '';
  final TextEditingController _searchController = TextEditingController();
  int _shuffleSeed = 0;

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

    final filtered = AppData.words.where((w) {
      if (vm.filterLetterCount == 2 && w.letterCount != 2) return false;
      if (vm.filterLetterCount == 3 && w.letterCount != 3) return false;
      if (vm.filterLetterCount >= 4 && w.letterCount < 4) return false;
      if (_search.isNotEmpty) {
        final q = _search.toLowerCase().trim();
        return w.hindi.contains(q) || w.english.toLowerCase().contains(q);
      }
      return true;
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
            onTap: () => vm.toggleSound(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _search = v),
              decoration: InputDecoration(
                hintText: isHindi ? 'खोजें (Search word)...' : 'Search word / खोजें...',
                prefixIcon: const Icon(Icons.search, size: 20, color: AppTheme.primaryColor),
                suffixIcon: _search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Row(
              children: [
                BouncingWidget(
                  onTap: () {
                    setState(() {
                      _shuffleSeed = DateTime.now().millisecondsSinceEpoch;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.35)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.shuffle_rounded, size: 16, color: AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          isHindi ? 'शफल' : 'Shuffle',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: '${loc.translate('all')} (${AppData.words.length})',
                  selected: vm.filterLetterCount == 0,
                  onSelected: () => vm.setFilter(0),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: loc.translate('two_letter'),
                  selected: vm.filterLetterCount == 2,
                  onSelected: () => vm.setFilter(2),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: loc.translate('three_letter'),
                  selected: vm.filterLetterCount == 3,
                  onSelected: () => vm.setFilter(3),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: isHindi ? '4+ अक्षर' : '4+ Letters',
                  selected: vm.filterLetterCount == 4,
                  onSelected: () => vm.setFilter(4),
                ),
              ],
            ),
          ),
          // Progress & Star status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${loc.translate('completed_items')}: ${vm.completedIds.length} / ${AppData.words.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(16),
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
                      Text(
                        '${vm.score}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              key: ValueKey('learn_${vm.filterLetterCount}_${_search}_$_shuffleSeed'),
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.80,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isCompleted = vm.completedIds.contains(word.id);

                return StaggeredEntrance(
                  index: idx,
                  child: BouncingWidget(
                    onTap: () {
                      vm.playWordAudio(word);
                      vm.markCompleted(word.id);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isPlaying
                              ? AppTheme.primaryColor
                              : (isCompleted ? AppTheme.accentColor.withOpacity(0.6) : Colors.grey.shade200),
                          width: isPlaying ? 2.5 : (isCompleted ? 2.0 : 1.5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isPlaying
                                ? AppTheme.primaryColor.withOpacity(0.25)
                                : (isCompleted ? AppTheme.accentColor.withOpacity(0.12) : Colors.black.withOpacity(0.05)),
                            blurRadius: isPlaying ? 12 : 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Completed badge indicator
                          Align(
                            alignment: Alignment.topRight,
                            child: isCompleted
                                ? const ElasticPop(
                                    child: Icon(Icons.check_circle_rounded, color: AppTheme.accentColor, size: 20),
                                  )
                                : const SizedBox(height: 20),
                          ),
                          // Emoji with floating or dancing pulse animation
                          Expanded(
                            child: Center(
                              child: isPlaying
                                  ? PulsingScale(
                                      minScale: 1.0,
                                      maxScale: 1.2,
                                      duration: const Duration(milliseconds: 400),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(word.emoji, style: const TextStyle(fontSize: 46)),
                                      ),
                                    )
                                  : FloatingAnimation(
                                      offset: 3.0,
                                      duration: const Duration(milliseconds: 1900),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(word.emoji, style: const TextStyle(fontSize: 42)),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              isHindi ? word.hindi : word.english,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isPlaying ? AppTheme.primaryColor : AppTheme.textColor,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${word.letters.join(" + ")} = ${word.hindi}',
                              style: const TextStyle(fontSize: 12, color: AppTheme.subtitleColor, fontWeight: FontWeight.w600),
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AudioRippleEffect(
                            isPlaying: isPlaying,
                            rippleColor: AppTheme.primaryColor,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                size: 18,
                                color: isPlaying ? Colors.white : AppTheme.primaryColor,
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

  Widget _buildFilterChip({required String label, required bool selected, required VoidCallback onSelected}) {
    return AnimatedScale(
      scale: selected ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 180),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        selectedColor: AppTheme.primaryColor,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppTheme.textColor,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
