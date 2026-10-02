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
  final PageController _controller = PageController();
  int _currentIndex = 0;
  int _shuffleSeed = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final words = List.from(AppData.firstWords);
    if (_shuffleSeed > 0) {
      final rnd = Random(_shuffleSeed);
      words.shuffle(rnd);
    }
    final total = words.length;

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
                _currentIndex = 0;
              });
              if (_controller.hasClients) {
                _controller.jumpToPage(0);
              }
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
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.shuffle_rounded),
            ),
          ),
          BouncingWidget(
            onTap: vm.toggleSound,
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / $total',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor, fontSize: 15),
                    ),
                  ),
                  Text(
                    loc.translate('listen_prompt'),
                    style: const TextStyle(color: AppTheme.subtitleColor, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: total,
                onPageChanged: (idx) {
                  setState(() => _currentIndex = idx);
                },
                itemBuilder: (context, idx) {
                  final word = words[idx];
                  final isPlaying = vm.currentPlayingId == word.id;
                  final isCompleted = vm.completedIds.contains(word.id);

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BouncingWidget(
                      scaleFactor: 0.96,
                      onTap: () {
                        vm.playWordAudio(word);
                        vm.markCompleted(word.id);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: isPlaying
                                ? AppTheme.primaryColor
                                : (isCompleted ? AppTheme.accentColor : AppTheme.primaryColor.withOpacity(0.18)),
                            width: isPlaying ? 3.5 : 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isPlaying
                                  ? AppTheme.primaryColor.withOpacity(0.3)
                                  : AppTheme.primaryColor.withOpacity(0.08),
                              blurRadius: isPlaying ? 20 : 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isCompleted)
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: ElasticPop(
                                      child: Icon(Icons.check_circle_rounded, color: AppTheme.accentColor, size: 28),
                                    ),
                                  )
                                else
                                  const SizedBox(height: 28),
                                FloatingAnimation(
                                  offset: 6,
                                  duration: const Duration(milliseconds: 1800),
                                  child: isPlaying
                                      ? PulsingScale(
                                          minScale: 1.0,
                                          maxScale: 1.18,
                                          duration: const Duration(milliseconds: 400),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(word.emoji, style: const TextStyle(fontSize: 105)),
                                          ),
                                        )
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(word.emoji, style: const TextStyle(fontSize: 95)),
                                        ),
                                ),
                                const SizedBox(height: 18),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    isHindi ? word.hindi : word.english,
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    isHindi ? word.english : word.hindi,
                                    style: const TextStyle(fontSize: 22, color: AppTheme.subtitleColor, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                FireSparkleBurst(
                                  burst: isPlaying,
                                  child: AudioRippleEffect(
                                    isPlaying: isPlaying,
                                    rippleColor: AppTheme.primaryColor,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isPlaying ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                                        size: 34,
                                        color: isPlaying ? Colors.white : AppTheme.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: BouncingWidget(
                      onTap: _currentIndex > 0
                          ? () => _controller.previousPage(duration: const Duration(milliseconds: 280), curve: Curves.easeInOut)
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _currentIndex > 0 ? AppTheme.primaryColor.withOpacity(0.4) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_rounded, color: _currentIndex > 0 ? AppTheme.primaryColor : Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _currentIndex > 0 ? AppTheme.primaryColor : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: BouncingWidget(
                      onTap: _currentIndex < total - 1
                          ? () => _controller.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeInOut)
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: _currentIndex < total - 1 ? AppTheme.primaryColor : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _currentIndex < total - 1
                              ? [
                                  BoxShadow(
                                    color: AppTheme.primaryColor.withOpacity(0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded, color: Colors.white),
                          ],
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
    );
  }
}
