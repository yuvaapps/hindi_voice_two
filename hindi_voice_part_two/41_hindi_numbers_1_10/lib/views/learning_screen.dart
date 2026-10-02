import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/number_item.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  final bool initialGridMode;
  const LearningScreen({super.key, this.initialGridMode = false});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;
  late bool _isGridMode;

  @override
  void initState() {
    super.initState();
    _isGridMode = widget.initialGridMode;
  }

  void _goTo(int newIndex) {
    if (newIndex >= 0 && newIndex < AppData.numbers.length) {
      setState(() => _idx = newIndex);
      final item = AppData.numbers[newIndex];
      final vm = context.read<AppViewModel>();
      vm.playItem(item);
      vm.markCompleted('${item.value}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';
    final currentItem = AppData.numbers[_idx];
    final isPlaying = vm.activeNumberValue == currentItem.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('app_title')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _isGridMode ? 'Card Mode' : 'Grid Mode',
            onPressed: () => setState(() => _isGridMode = !_isGridMode),
            icon: Icon(_isGridMode ? Icons.view_carousel : Icons.grid_view),
          ),
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
          _isGridMode ? _buildGridMode(context, vm, isHindi) : _buildCardMode(context, vm, isHindi, currentItem, isPlaying),
          CelebrationConfettiBurst(show: vm.showConfetti),
        ],
      ),
    );
  }

  Widget _buildCardMode(
    BuildContext context,
    AppViewModel vm,
    bool isHindi,
    NumberItem num,
    bool isPlaying,
  ) {
    final isDone = vm.completedIds.contains('${num.value}');

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          children: [
            // Top Step Progress Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_idx + 1} / ${AppData.numbers.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0288D1)),
                ),
                Row(
                  children: List.generate(AppData.numbers.length, (i) {
                    final dotDone = vm.completedIds.contains('${i + 1}');
                    final isCurrent = i == _idx;
                    return GestureDetector(
                      onTap: () => _goTo(i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.5),
                        width: isCurrent ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppTheme.primaryColor
                              : (dotDone ? const Color(0xFF81D4FA) : Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
                if (isDone)
                  const Icon(Icons.check_circle, color: Color(0xFF43A047), size: 20)
                else
                  const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 12),

            // Main Interactive Flashcard
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Devanagari & Arabic number
                    FloatingAnimation(
                      offset: 6.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            num.devanagari,
                            style: const TextStyle(
                              fontSize: 84,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Text(
                            '(${num.value})',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Hindi Name & Transliteration
                    Text(
                      num.hindiName,
                      style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Text(
                      'Pronunciation: "${num.transliteration}"',
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Color(0xFFE65100)),
                    ),
                    const SizedBox(height: 10),

                    // English & Tamil Badges
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1F5FE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🇬🇧 ${num.englishName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 14),
                          Container(height: 16, width: 1, color: Colors.grey.shade400),
                          const SizedBox(width: 14),
                          Text('🇮🇳 தமிழ்: ${num.tamilName}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.primaryColor)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Object label & Interactive Tap to Count
                    Text(
                      '${num.objectNameHindi} • ${num.objectNameEnglish}',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 8),

                    // Interactive Counting Object Emojis
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 10,
                            children: List.generate(num.value, (i) {
                              return InteractiveCountingPop(
                                onTap: () {
                                  vm.playItem(num);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    num.objectEmoji,
                                    style: TextStyle(fontSize: num.value > 6 ? 32 : 40),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      isHindi ? '👆 गिनने के लिए छूएँ!' : '👆 Tap objects to count & hear sound!',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Dual Voice Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hindi Voice Button
                BouncingWidget(
                  onTap: () {
                    vm.playHindi(num);
                    vm.markCompleted('${num.value}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0288D1).withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.volume_up, color: Colors.white, size: 22),
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
                  onTap: () {
                    vm.playEnglish(num);
                    vm.markCompleted('${num.value}');
                  },
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
            const SizedBox(height: 12),

            // Previous and Next Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BouncingWidget(
                  onTap: _idx > 0 ? () => _goTo(_idx - 1) : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: _idx > 0 ? Colors.white : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 14, color: _idx > 0 ? AppTheme.primaryColor : Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          isHindi ? 'पिछला' : 'Previous',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _idx > 0 ? AppTheme.primaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BouncingWidget(
                  onTap: _idx < AppData.numbers.length - 1 ? () => _goTo(_idx + 1) : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: _idx < AppData.numbers.length - 1 ? Colors.white : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Text(
                          isHindi ? 'अगला' : 'Next',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _idx < AppData.numbers.length - 1 ? AppTheme.primaryColor : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios,
                            size: 14, color: _idx < AppData.numbers.length - 1 ? AppTheme.primaryColor : Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridMode(BuildContext context, AppViewModel vm, bool isHindi) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.1,
      ),
      itemCount: AppData.numbers.length,
      itemBuilder: (context, i) {
        final item = AppData.numbers[i];
        final isDone = vm.completedIds.contains('${item.value}');
        final isPlayingThis = vm.activeNumberValue == item.value;

        return StaggeredEntrance(
          index: i,
          child: BouncingWidget(
            onTap: () {
              setState(() {
                _idx = i;
                _isGridMode = false;
              });
              vm.playItem(item);
              vm.markCompleted('${item.value}');
            },
            child: NumberPulseAura(
              active: isPlayingThis,
              child: Container(
                decoration: BoxDecoration(
                  color: isPlayingThis ? const Color(0xFFE1F5FE) : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isPlayingThis
                        ? AppTheme.primaryColor
                        : (isDone ? const Color(0xFF81D4FA) : Colors.grey.shade200),
                    width: isPlayingThis ? 2.0 : 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
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
                        Text(
                          '${item.value}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey.shade600),
                        ),
                        if (isPlayingThis)
                          AudioSoundwaveWave(isPlaying: true, color: AppTheme.primaryColor, height: 14)
                        else if (isDone)
                          const Icon(Icons.check_circle, color: Color(0xFF43A047), size: 16),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.devanagari,
                          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                        ),
                        const SizedBox(width: 8),
                        Text(item.objectEmoji, style: const TextStyle(fontSize: 28)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          item.hindiName,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${item.transliteration} • ${item.englishName}',
                          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
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
