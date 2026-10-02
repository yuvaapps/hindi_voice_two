import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'practice_screen.dart';

class LearningScreen extends StatefulWidget {
  final int initialIndex;
  const LearningScreen({super.key, this.initialIndex = 0});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late int _idx;
  bool _celebrating = false;

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex.clamp(0, AppData.letters.length - 1);
  }

  void _shuffle() {
    setState(() {
      AppData.letters.shuffle();
      _idx = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🔀 वर्णमाला के ${AppData.letters.length} पृष्ठ शफल हो गए!'),
        duration: const Duration(seconds: 1),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _nextPage(AppViewModel vm) {
    final item = AppData.letters[_idx];
    vm.markCompleted('${item.letter}-${item.word}');
    setState(() {
      _celebrating = true;
      _idx = (_idx + 1) % AppData.letters.length;
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _celebrating = false);
    });
  }

  void _prevPage() {
    setState(() {
      _idx = (_idx - 1 + AppData.letters.length) % AppData.letters.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.letters[_idx];
    final isDone = vm.completedIds.contains('${item.letter}-${item.word}');

    final isLetterAudioPlaying = vm.isKeyPlaying('letter-${item.letter}');
    final isWordAudioPlaying = vm.isKeyPlaying('word-${item.letter}-${item.word}');

    return StarStampCelebration(
      celebrate: _celebrating,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F9F4),
        appBar: AppBar(
          title: Text(
            '${loc.translate('page')} ${_idx + 1} / ${AppData.letters.length}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              tooltip: 'Shuffle Notebook',
              icon: const Icon(Icons.shuffle),
              onPressed: _shuffle,
            ),
            IconButton(
              tooltip: 'Jump to Letter',
              icon: const Icon(Icons.grid_view),
              onPressed: () => _showAlphabetJumpModal(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                // Notebook Page Container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.green.shade200, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: NotebookRuledBackground(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Top indicator row: Letter type tag & Status
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.green.shade200),
                                    ),
                                    child: Text(
                                      'वर्ण: ${item.letter}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (isDone)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                                          SizedBox(width: 4),
                                          Text(
                                            'सीखा गया',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),

                              // Central Large Letter with Glow Aura
                              ChalkGlowAura(
                                child: Text(
                                  item.letter,
                                  style: TextStyle(
                                    fontSize: 96,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.primaryColor,
                                    shadows: [
                                      Shadow(
                                        color: Colors.green.shade200,
                                        blurRadius: 12,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Emoji Presentation
                              FloatingAnimation(
                                offset: 4,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F8E9),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.green.shade100, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.08),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Text(item.emoji, style: const TextStyle(fontSize: 48)),
                                ),
                              ),

                              // Word Association & Meaning
                              Column(
                                children: [
                                  Text(
                                    '${item.letter} से ${item.word}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.englishWord,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              // Audio Playback Actions
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Letter Audio
                                  AudioSoundwaveWave(
                                    isPlaying: isLetterAudioPlaying,
                                    child: BouncingWidget(
                                      onTap: () => vm.playLetter(item),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE8F5E9),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: Colors.green.shade300),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.volume_up, size: 20, color: AppTheme.primaryColor),
                                            const SizedBox(width: 6),
                                            Text(
                                              'अक्षर: ${item.letter}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Word Audio
                                  AudioSoundwaveWave(
                                    isPlaying: isWordAudioPlaying,
                                    child: BouncingWidget(
                                      onTap: () {
                                        vm.playWord(item);
                                        vm.markCompleted('${item.letter}-${item.word}');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.green.withOpacity(0.3),
                                              blurRadius: 6,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.volume_up, size: 20, color: Colors.white),
                                            const SizedBox(width: 6),
                                            Text(
                                              'शब्द: ${item.word}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Quick Trace Link
                              BouncingWidget(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PracticeScreen(initialIndex: _idx),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade50,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.amber.shade300),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.edit, size: 16, color: Colors.brown),
                                      SizedBox(width: 6),
                                      Text(
                                        'नोटबुक में लिखें / Trace Now',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Bottom Page Navigation Bar
                Row(
                  children: [
                    // Prev Button
                    BouncingWidget(
                      onTap: _idx > 0 ? _prevPage : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                        decoration: BoxDecoration(
                          color: _idx > 0 ? Colors.white : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _idx > 0 ? Colors.green.shade200 : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new,
                              size: 16,
                              color: _idx > 0 ? AppTheme.primaryColor : Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'पिछला',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _idx > 0 ? AppTheme.primaryColor : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Next Button
                    Expanded(
                      child: BouncingWidget(
                        onTap: () => _nextPage(vm),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'अगला पृष्ठ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlphabetJumpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'सीधे अक्षर पर जाएं (${AppData.letters.length} प्रविष्टियां)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: AppData.letters.length > 100 ? 100 : AppData.letters.length,
                  itemBuilder: (context, i) {
                    final l = AppData.letters[i];
                    final isCurrent = i == _idx;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _idx = i);
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isCurrent ? AppTheme.primaryColor : const Color(0xFFF1F8E9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCurrent ? AppTheme.primaryColor : Colors.green.shade200,
                          ),
                        ),
                        child: Text(
                          l.letter,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCurrent ? Colors.white : AppTheme.primaryColor,
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
      },
    );
  }
}
