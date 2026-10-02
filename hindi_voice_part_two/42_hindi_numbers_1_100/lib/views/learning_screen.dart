import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/num100_item.dart';
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

  final List<String> _ranges = const ['All', '1-20', '21-40', '41-60', '61-80', '81-100'];

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.numbers.where((n) {
      // Range filter
      if (vm.selectedRange != 'All') {
        if (n.groupTag != vm.selectedRange) return false;
      }
      // Search filter
      final q = vm.searchQuery.toLowerCase().trim();
      if (q.isEmpty) return true;
      return '${n.number}'.contains(q) ||
          n.devanagari.contains(q) ||
          n.hindiName.contains(q) ||
          n.transliteration.toLowerCase().contains(q) ||
          n.tamilName.contains(q) ||
          n.englishName.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('app_title')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Test Audio Voice',
            onPressed: vm.testVoice,
            icon: const Icon(Icons.record_voice_over),
          ),
          IconButton(
            tooltip: vm.soundEnabled ? 'Mute' : 'Unmute',
            onPressed: vm.toggleSound,
            icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: vm.setSearch,
                  decoration: InputDecoration(
                    hintText: isHindi ? 'संख्या या नाम खोजें (उदा. 42, बयालीस)...' : 'Search number or name (e.g. 42, बयालीस)...',
                    prefixIcon: const Icon(Icons.search, color: AppTheme.primaryColor),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchCtrl.clear();
                              vm.setSearch('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Range Filter Pills
              SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  scrollDirection: Axis.horizontal,
                  itemCount: _ranges.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final range = _ranges[i];
                    final isSelected = vm.selectedRange == range;
                    return BouncingWidget(
                      onTap: () => vm.setRange(range),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            range == 'All' ? (isHindi ? 'सभी (१-१००)' : 'All (1-100)') : range,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Info & Count Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filtered.length} ${isHindi ? 'संख्याएं' : 'Numbers'}',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.check_circle, size: 14, color: AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          '${vm.completedIds.length} / ${AppData.numbers.length} ${isHindi ? 'पूर्ण' : 'Completed'}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 1-100 Numbers Grid
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('🔍', style: TextStyle(fontSize: 48)),
                            const SizedBox(height: 10),
                            Text(
                              isHindi ? 'कोई संख्या नहीं मिली' : 'No numbers found',
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, idx) {
                          final item = filtered[idx];
                          final isDone = vm.completedIds.contains('${item.number}');
                          final isPlayingThis = vm.activeNumberId == item.number;

                          return StaggeredEntrance(
                            index: idx,
                            child: BouncingWidget(
                              onTap: () {
                                vm.playItem(item);
                                vm.markCompleted(item.number);
                                _showDetail(context, item);
                              },
                              child: NumberPulseAura(
                                active: isPlayingThis,
                                glowColor: AppTheme.primaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isPlayingThis
                                        ? const Color(0xFFE8F5E9)
                                        : (isDone ? const Color(0xFFF1F8E9) : Colors.white),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isPlayingThis
                                          ? AppTheme.primaryColor
                                          : (isDone ? const Color(0xFFA5D6A7) : Colors.grey.shade200),
                                      width: isPlayingThis ? 2.0 : 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Top-left English number badge
                                      Positioned(
                                        top: 6,
                                        left: 8,
                                        child: Text(
                                          '${item.number}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: isPlayingThis ? AppTheme.primaryColor : Colors.grey.shade600,
                                          ),
                                        ),
                                      ),

                                      // Top-right completion icon or sound wave
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: isPlayingThis
                                            ? AudioSoundwaveWave(
                                                isPlaying: true,
                                                color: AppTheme.primaryColor,
                                                height: 12,
                                              )
                                            : (isDone
                                                ? const Icon(Icons.check_circle, size: 14, color: AppTheme.primaryColor)
                                                : const SizedBox.shrink()),
                                      ),

                                      // Center Devanagari digit & transliteration
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 6),
                                            Text(
                                              item.devanagari,
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                                color: isPlayingThis ? AppTheme.primaryColor : const Color(0xFF1B5E20),
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              item.hindiName,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              item.transliteration,
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.grey.shade600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),

          // Celebration Confetti
          CelebrationConfettiBurst(show: vm.showConfetti),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, Num100Item currentItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _NumberDetailSheet(initialItem: currentItem),
    );
  }
}

class _NumberDetailSheet extends StatefulWidget {
  final Num100Item initialItem;
  const _NumberDetailSheet({required this.initialItem});

  @override
  State<_NumberDetailSheet> createState() => _NumberDetailSheetState();
}

class _NumberDetailSheetState extends State<_NumberDetailSheet> {
  late Num100Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.initialItem;
  }

  void _goTo(int offset) {
    final nextNum = _item.number + offset;
    if (nextNum >= 1 && nextNum <= 100) {
      final nextItem = AppData.numbers[nextNum - 1];
      setState(() => _item = nextItem);
      final vm = context.read<AppViewModel>();
      vm.playItem(nextItem);
      vm.markCompleted(nextItem.number);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final isPlaying = vm.activeNumberId == _item.number;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 14),

          // Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _item.number > 1 ? () => _goTo(-1) : null,
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'संख्या ${_item.number} / 100',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: _item.number < 100 ? () => _goTo(1) : null,
                icon: const Icon(Icons.arrow_forward_ios, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Devanagari & Arabic number hero display
          FloatingAnimation(
            offset: 5.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  _item.devanagari,
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '(${_item.number})',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Hindi Name & Transliteration
          Text(
            _item.hindiName,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Text(
            'Pronunciation: "${_item.transliteration}"',
            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Color(0xFFE65100)),
          ),
          const SizedBox(height: 6),

          // English & Tamil
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('English', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Text(
                      _item.englishName,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(height: 24, width: 1, color: Colors.grey.shade300),
                Column(
                  children: [
                    const Text('தமிழ் (Tamil)', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    Text(
                      _item.tamilName,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Dual Voice Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hindi Voice Button
              BouncingWidget(
                onTap: () => vm.playHindi(_item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E7D32).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'हिन्दी Voice',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      if (isPlaying) ...[
                        const SizedBox(width: 8),
                        const AudioSoundwaveWave(isPlaying: true, color: Color(0xFFFFD54F), height: 16),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // English Voice Button
              BouncingWidget(
                onTap: () => vm.playEnglish(_item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.primaryColor, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.record_voice_over, color: AppTheme.primaryColor, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'English Voice',
                        style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
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
