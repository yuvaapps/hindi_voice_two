import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/picture_word.dart';
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
  int _currentIndex = 0;
  bool _revealed = false;
  bool _isGridMode = false;

  static const Map<String, String> _categoryIcons = {
    'all': '🖼️',
    'animals': '🦁',
    'fruits': '🍎',
    'vegetables': '🥕',
    'body': '👁️',
    'nature': '🌳',
    'house': '🏠',
    'food': '🍲',
    'clothes': '👕',
    'vehicles': '🚗',
    'professions': '👨‍⚕️',
    'numbers': '🔢',
    'colors': '🎨',
    'actions': '🏃',
    'emotions': '😊',
    'school': '🎒',
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
    'tools': '🔨',
    'astronomy': '🪐',
    'places': '🏛️',
    'aquatic': '🐬',
    'toys': '🧸',
    'herbs': '🌿',
    'signs': '🚦',
    'grooming': '🪮',
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

  void _shuffleWords(List<PictureWord> items) {
    if (items.isEmpty) return;
    final random = Random();
    setState(() {
      _currentIndex = random.nextInt(items.length);
      _revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    // Collect all unique categories
    final uniqueCats = <String>{'all'};
    for (final item in AppData.items) {
      uniqueCats.add(item.category);
    }
    final categoryList = uniqueCats.toList();

    // Filter items
    final query = vm.searchQuery.toLowerCase();
    final filtered = AppData.items.where((i) {
      final matchesCategory = vm.category == 'all' || i.category == vm.category;
      if (!matchesCategory) return false;
      if (query.isEmpty) return true;
      return i.hindi.toLowerCase().contains(query) ||
          i.english.toLowerCase().contains(query) ||
          i.id.toLowerCase().contains(query);
    }).toList();

    // Bounds check
    if (_currentIndex >= filtered.length && filtered.isNotEmpty) {
      _currentIndex = 0;
    }

    final currentItem = filtered.isNotEmpty ? filtered[_currentIndex] : null;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          filtered.isNotEmpty
              ? '${_currentIndex + 1} / ${filtered.length}'
              : loc.translate('start_learning'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGridMode ? Icons.view_carousel : Icons.grid_view),
            tooltip: _isGridMode ? loc.translate('deck_mode') : loc.translate('grid_mode'),
            onPressed: () => setState(() => _isGridMode = !_isGridMode),
          ),
          IconButton(
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
            tooltip: loc.translate('sound'),
            onPressed: vm.toggleSound,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Search Header
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

              // Categories Horizontal Scroll List
              Container(
                height: 54,
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
                        onTap: () {
                          vm.setCategory(cat);
                          setState(() {
                            _currentIndex = 0;
                            _revealed = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(icon, style: const TextStyle(fontSize: 15)),
                              const SizedBox(width: 5),
                              Text(
                                title,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 12,
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

              // Main Body: Picture Card Reveal Mode OR Picture Grid Gallery Mode
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
                    : _isGridMode
                        ? _buildGridView(filtered, vm, loc)
                        : _buildCardView(currentItem!, filtered, vm, loc),
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

  Widget _buildCardView(
    PictureWord item,
    List<PictureWord> allFiltered,
    AppViewModel vm,
    AppLocalizations loc,
  ) {
    final isPlaying = vm.isItemPlaying(item.id);
    final isDone = vm.completedIds.contains(item.id);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        children: [
          // Picture Card with Tap to Reveal
          Expanded(
            child: Center(
              child: CyanGlowAura(
                isGlowing: isPlaying,
                child: BouncingWidget(
                  onTap: () {
                    setState(() => _revealed = true);
                    vm.playPictureWord(item, english: false);
                  },
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 380, maxHeight: 440),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: _revealed ? AppTheme.primaryColor : const Color(0xFFFF8A65),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0F7FA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                loc.translate(item.category).toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                AudioSoundwaveWave(
                                  isPlaying: isPlaying,
                                  color: AppTheme.primaryColor,
                                ),
                                if (isDone) ...[
                                  const SizedBox(width: 6),
                                  const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
                                ],
                              ],
                            ),
                          ],
                        ),

                        // Center Floating Picture / Emoji
                        FloatingAnimation(
                          distance: 6,
                          child: Text(
                            item.emoji,
                            style: const TextStyle(fontSize: 96),
                          ),
                        ),

                        // Revealed text OR Tap prompt
                        PictureRevealAnimation(
                          isRevealed: _revealed,
                          revealedChild: Column(
                            key: const ValueKey('revealed'),
                            children: [
                              Text(
                                item.hindi,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.english,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          hiddenChild: Container(
                            key: const ValueKey('hidden'),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8A65).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('👆', style: TextStyle(fontSize: 18)),
                                const SizedBox(width: 6),
                                Text(
                                  loc.translate('tap_to_reveal'),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD84315),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Dual Voice Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BouncingWidget(
                              onTap: () {
                                setState(() => _revealed = true);
                                vm.playPictureWord(item, english: false);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.volume_up, color: Colors.white, size: 16),
                                    SizedBox(width: 4),
                                    Text('हिन्दी', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            BouncingWidget(
                              onTap: () {
                                setState(() => _revealed = true);
                                vm.playPictureWord(item, english: true);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF8A65),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.volume_up, color: Colors.white, size: 16),
                                    SizedBox(width: 4),
                                    Text('English', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
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
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Controls Bar (Previous, Shuffle, Next)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous Card
              BouncingWidget(
                onTap: _currentIndex > 0
                    ? () {
                        setState(() {
                          _currentIndex--;
                          _revealed = false;
                        });
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _currentIndex > 0 ? Colors.white : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 18, color: _currentIndex > 0 ? AppTheme.primaryColor : Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        loc.translate('previous'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _currentIndex > 0 ? AppTheme.primaryColor : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Shuffle Button
              BouncingWidget(
                onTap: () => _shuffleWords(allFiltered),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8A65),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF8A65).withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shuffle, color: Colors.white, size: 22),
                ),
              ),

              // Next Card
              BouncingWidget(
                onTap: _currentIndex < allFiltered.length - 1
                    ? () {
                        setState(() {
                          _currentIndex++;
                          _revealed = false;
                        });
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _currentIndex < allFiltered.length - 1 ? AppTheme.primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        loc.translate('next'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _currentIndex < allFiltered.length - 1 ? Colors.white : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: _currentIndex < allFiltered.length - 1 ? Colors.white : Colors.grey,
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

  Widget _buildGridView(
    List<PictureWord> items,
    AppViewModel vm,
    AppLocalizations loc,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, idx) {
        final item = items[idx];
        final isPlaying = vm.isItemPlaying(item.id);
        final isDone = vm.completedIds.contains(item.id);

        return StaggeredEntrance(
          index: idx,
          child: CyanGlowAura(
            isGlowing: isPlaying,
            child: BouncingWidget(
              onTap: () {
                setState(() {
                  _currentIndex = idx;
                  _isGridMode = false;
                  _revealed = true;
                });
                vm.playPictureWord(item);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isPlaying ? AppTheme.primaryColor : Colors.grey.shade200,
                    width: isPlaying ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isDone)
                          const Icon(Icons.check_circle, size: 16, color: Color(0xFF2E7D32))
                        else
                          const SizedBox(width: 16),
                        AudioSoundwaveWave(isPlaying: isPlaying),
                      ],
                    ),
                    Text(item.emoji, style: const TextStyle(fontSize: 46)),
                    Column(
                      children: [
                        Text(
                          item.hindi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          item.english,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.touch_app, size: 14, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
