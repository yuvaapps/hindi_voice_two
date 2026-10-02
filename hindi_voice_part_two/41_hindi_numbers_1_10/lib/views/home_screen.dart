import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final completedCount = vm.completedIds.length;
    final totalCount = AppData.numbers.length;
    final progressPercent = (completedCount / totalCount).clamp(0.0, 1.0);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with Language and Sound toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BouncingWidget(
                    onTap: vm.toggleLanguage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      BouncingWidget(
                        onTap: vm.testVoice,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.record_voice_over, size: 18, color: AppTheme.secondaryColor),
                              const SizedBox(width: 6),
                              AudioSoundwaveWave(isPlaying: vm.isPlaying, color: AppTheme.secondaryColor, height: 16),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      BouncingWidget(
                        onTap: vm.toggleSound,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            vm.soundEnabled ? Icons.volume_up : Icons.volume_off,
                            color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hero Banner with Animated Floating Emoji & Progress
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0288D1), Color(0xFF01579B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0288D1).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '१ से १० गिनती • 1 to 10 Numbers',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.translate('app_title'),
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            loc.translate('subtitle'),
                            style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9)),
                          ),
                          const SizedBox(height: 14),
                          // Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progressPercent,
                              backgroundColor: Colors.white.withOpacity(0.25),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD54F)),
                              minHeight: 7,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$completedCount / $totalCount ${vm.locale.languageCode == 'hi' ? 'संख्या सीखीं' : 'Learned'} (${(progressPercent * 100).toInt()}%)',
                            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.85), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    const FloatingAnimation(
                      offset: 7.0,
                      child: Text('🔢', style: TextStyle(fontSize: 54)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  vm.locale.languageCode == 'hi' ? 'सीखना शुरू करें' : 'Start Exploring',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF01579B)),
                ),
              ),
              const SizedBox(height: 12),

              // Action Cards Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.15,
                children: [
                  _ActionCard(
                    title: loc.translate('start_learning'),
                    subtitle: '१ - १० Flashcards',
                    emoji: '🎯',
                    gradient: const [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
                    accentColor: const Color(0xFF0288D1),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen())),
                  ),
                  _ActionCard(
                    title: vm.locale.languageCode == 'hi' ? 'संख्या ग्रिड' : 'Numbers Grid',
                    subtitle: 'All 1-10 at once',
                    emoji: '🔟',
                    gradient: const [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
                    accentColor: const Color(0xFFF57F17),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen(initialGridMode: true))),
                  ),
                  _ActionCard(
                    title: loc.translate('progress'),
                    subtitle: '$completedCount / $totalCount Done',
                    emoji: '🌟',
                    gradient: const [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                    accentColor: const Color(0xFF2E7D32),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
                  ),
                  _ActionCard(
                    title: loc.translate('settings'),
                    subtitle: 'Audio & Voice',
                    emoji: '⚙️',
                    gradient: const [Color(0xFFECEFF1), Color(0xFFCFD8DC)],
                    accentColor: const Color(0xFF455A64),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Quick Audio Showcase: Numbers 1 to 5
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vm.locale.languageCode == 'hi' ? 'तुरंत उच्चारण सुनें (१-५)' : 'Quick Voice Preview (1-5)',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0288D1)),
                        ),
                        AudioSoundwaveWave(isPlaying: vm.isPlaying, color: AppTheme.primaryColor, height: 14),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: AppData.numbers.take(5).map((numItem) {
                        final isThisPlaying = vm.activeNumberValue == numItem.value;
                        return BouncingWidget(
                          onTap: () => vm.playItem(numItem),
                          child: NumberPulseAura(
                            active: isThisPlaying,
                            child: Container(
                              width: 56,
                              height: 58,
                              decoration: BoxDecoration(
                                color: isThisPlaying ? const Color(0xFF0288D1) : const Color(0xFFE1F5FE),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isThisPlaying ? const Color(0xFF01579B) : const Color(0xFF81D4FA),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    numItem.devanagari,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isThisPlaying ? Colors.white : const Color(0xFF0288D1),
                                    ),
                                  ),
                                  Text(
                                    numItem.objectEmoji,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  Text(
                                    numItem.transliteration,
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.bold,
                                      color: isThisPlaying ? const Color(0xFFFFD54F) : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> gradient;
  final Color accentColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 32)),
                Icon(Icons.arrow_forward_ios, size: 14, color: accentColor),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: accentColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
