import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/pronun_num.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final int initialCategoryIndex;
  const LearningScreen({super.key, this.initialCategoryIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late int _categoryIdx;
  int _itemIdx = 0;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();
    _categoryIdx = widget.initialCategoryIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoPlayCurrent();
    });
  }

  List<PronunNum> get _currentList => AppData.getCategory(_categoryIdx);
  PronunNum get _currentItem => _currentList[_itemIdx];

  void _autoPlayCurrent() {
    final vm = context.read<AppViewModel>();
    if (vm.soundEnabled) {
      vm.playAudio(_currentItem);
      vm.markCompleted(_currentItem.number);
    }
  }

  void _onCategorySelected(int index) {
    if (_categoryIdx == index) return;
    setState(() {
      _categoryIdx = index;
      _itemIdx = 0;
    });
    final vm = context.read<AppViewModel>();
    vm.setCategory(index);
    _autoPlayCurrent();
  }

  void _prevItem() {
    if (_itemIdx > 0) {
      setState(() => _itemIdx--);
      _autoPlayCurrent();
    }
  }

  void _nextItem() {
    if (_itemIdx < _currentList.length - 1) {
      setState(() => _itemIdx++);
      _autoPlayCurrent();
      if ((_itemIdx + 1) % 10 == 0 || _itemIdx == _currentList.length - 1) {
        _triggerConfetti();
      }
    }
  }

  void _randomItem() {
    final rand = math.Random().nextInt(_currentList.length);
    setState(() => _itemIdx = rand);
    _autoPlayCurrent();
  }

  void _triggerConfetti() {
    setState(() => _showConfetti = true);
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => _showConfetti = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = _currentItem;
    final isDone = vm.isCompleted(item.number);
    final catName = AppData.categoryNames[_categoryIdx];

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('app_title'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$catName (${_itemIdx + 1}/${_currentList.length})',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: loc.translate('sound'),
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
            onPressed: vm.toggleSound,
          ),
          IconButton(
            tooltip: vm.locale.languageCode == 'hi' ? 'English' : 'हिन्दी',
            icon: const Icon(Icons.translate),
            onPressed: vm.toggleLanguage,
          ),
        ],
      ),
      body: CelebrationConfettiBurst(
        active: _showConfetti,
        child: SafeArea(
          child: Column(
              children: [
                // ── Category Selector Tabs ──────────────────────────────────
                Container(
                  color: Colors.white,
                  height: 52,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    itemCount: AppData.categoryNames.length,
                    itemBuilder: (context, idx) {
                      final isSelected = _categoryIdx == idx;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          avatar: Text(AppData.categoryEmojis[idx]),
                          label: Text(
                            AppData.categoryNames[idx],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: AppTheme.primaryColor,
                          backgroundColor: const Color(0xFFF1F5F9),
                          onSelected: (_) => _onCategorySelected(idx),
                          showCheckmark: false,
                        ),
                      );
                    },
                  ),
                ),

                // ── Progress indicator bar across current category ──────────
                LinearProgressIndicator(
                  value: (_itemIdx + 1) / _currentList.length,
                  backgroundColor: const Color(0xFFB2EBF2),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                  minHeight: 4,
                ),

                // ── Main Pronunciation Studio Card ──────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: StaggeredEntrance(
                      key: ValueKey('${item.number}_$_categoryIdx'),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(alpha: 0.12),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header tags: Category & Status Badge
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(item.emoji, style: const TextStyle(fontSize: 16)),
                                      const SizedBox(width: 6),
                                      Text(
                                        '#${item.number}',
                                        style: const TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isDone)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.check_circle, size: 14, color: Color(0xFF2E7D32)),
                                        const SizedBox(width: 4),
                                        Text(
                                          loc.translate('pronounced'),
                                          style: const TextStyle(
                                            color: Color(0xFF2E7D32),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Pulsing / Bouncing Hero Devanagari Character
                            NumberPulseAura(
                              color: AppTheme.primaryColor,
                              child: BouncingWidget(
                                amplitude: 6,
                                child: Text(
                                  item.devanagari,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: item.devanagari.length > 3 ? 56 : 84,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Hindi Name
                            Text(
                              item.hindiName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Phonetic Roman Transliteration
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3E0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '/ ${item.roman} /',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFE65100),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Multilingual Chips: English & Tamil
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('🇬🇧', style: TextStyle(fontSize: 14)),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.englishName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFF334155),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('🇮🇳', style: TextStyle(fontSize: 14)),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.tamil,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Color(0xFF334155),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // Soundwave Visualizer (Active during speech playback)
                            ValueListenableBuilder<bool>(
                              valueListenable: vm.audioService.isPlayingNotifier,
                              builder: (context, isPlaying, _) {
                                return AudioSoundwaveWave(
                                  isPlaying: isPlaying,
                                  color: isPlaying ? AppTheme.primaryColor : const Color(0xFFCBD5E1),
                                  barCount: 7,
                                  height: 38,
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Main Pronunciation Action Button
                            GestureDetector(
                              onTap: () {
                                vm.playAudio(item, slow: false);
                                vm.markCompleted(item.number);
                              },
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF00ACC1), Color(0xFF00838F)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withValues(alpha: 0.4),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(Icons.volume_up, size: 38, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              loc.translate('listen'),
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Secondary Audio Actions: Normal vs Slow Pronunciation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    vm.playAudio(item, slow: false);
                                    vm.markCompleted(item.number);
                                  },
                                  icon: const Icon(Icons.replay, size: 16),
                                  label: Text(loc.translate('replay')),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppTheme.primaryColor,
                                    side: const BorderSide(color: AppTheme.primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    vm.playAudio(item, slow: true);
                                    vm.markCompleted(item.number);
                                  },
                                  icon: const Text('🐢', style: TextStyle(fontSize: 14)),
                                  label: Text(loc.translate('slow_speed')),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFF3E0),
                                    foregroundColor: const Color(0xFFE65100),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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

                // ── Bottom Navigation Controls ──────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Previous button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _itemIdx > 0 ? _prevItem : null,
                          icon: const Icon(Icons.arrow_back_ios, size: 14),
                          label: Text(loc.translate('previous')),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Shuffle / Random Button
                      IconButton.filledTonal(
                        onPressed: _randomItem,
                        tooltip: loc.translate('random'),
                        icon: const Icon(Icons.shuffle, color: AppTheme.primaryColor),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.12),
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Next button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _itemIdx < _currentList.length - 1 ? _nextItem : null,
                          icon: const Icon(Icons.arrow_forward_ios, size: 14),
                          label: Text(loc.translate('next')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
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
