import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'practice_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar: Language switcher and Sound toggle with bounce & micro-animations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language Switcher
                  BouncingWidget(
                    onTap: () => vm.toggleLanguage(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppTheme.textColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.swap_horiz, size: 20, color: AppTheme.primaryColor),
                        ],
                      ),
                    ),
                  ),

                  // Sound Toggle
                  BouncingWidget(
                    onTap: () => vm.toggleSound(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: AnimatedRotation(
                        turns: vm.soundEnabled ? 0.0 : -0.1,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutBack,
                        child: Icon(
                          vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                          color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Hero Banner with Animated Floating Rainbow & Floating Sparkles
              StaggeredEntrance(
                index: 0,
                duration: const Duration(milliseconds: 500),
                slideOffset: 16,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.35),
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
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                loc.translate('app_title'),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.translate('subtitle'),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.95),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Animated floating & pulsing rainbow badge
                      FloatingAnimation(
                        offset: 5,
                        duration: const Duration(milliseconds: 2000),
                        child: PulsingScale(
                          minScale: 0.95,
                          maxScale: 1.08,
                          duration: const Duration(milliseconds: 1400),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.28),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Text('🌈', style: TextStyle(fontSize: 38)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Animated Menu Grid with staggered entry and lively cards
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.98,
                children: [
                  StaggeredEntrance(
                    index: 1,
                    child: _AnimatedMenuCard(
                      title: loc.translate('start_learning'),
                      emoji: '📖',
                      color: const Color(0xFFFFF9C4), // Soft lemon yellow
                      accentColor: const Color(0xFFD97706), // Warm gold
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LearningScreen()),
                        );
                      },
                    ),
                  ),
                  StaggeredEntrance(
                    index: 2,
                    child: _AnimatedMenuCard(
                      title: loc.translate('practice'),
                      emoji: '🎯',
                      color: const Color(0xFFFFECB3), // Golden amber cream
                      accentColor: const Color(0xFFB45309), // Amber bronze
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PracticeScreen()),
                        );
                      },
                    ),
                  ),
                  StaggeredEntrance(
                    index: 3,
                    child: _AnimatedMenuCard(
                      title: loc.translate('progress'),
                      emoji: '🌟',
                      color: const Color(0xFFFEF3C7), // Warm sunshine butter
                      accentColor: const Color(0xFFD97706), // Sun gold
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProgressScreen()),
                        );
                      },
                    ),
                  ),
                  StaggeredEntrance(
                    index: 4,
                    child: _AnimatedMenuCard(
                      title: loc.translate('settings'),
                      emoji: '⚙️',
                      color: const Color(0xFFFDE68A), // Sunburst yellow
                      accentColor: const Color(0xFF92400E), // Rich warm amber
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedMenuCard extends StatefulWidget {
  final String title;
  final String emoji;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const _AnimatedMenuCard({
    required this.title,
    required this.emoji,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_AnimatedMenuCard> createState() => _AnimatedMenuCardState();
}

class _AnimatedMenuCardState extends State<_AnimatedMenuCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.92 : (_isHovered ? 1.05 : 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: widget.accentColor.withOpacity(_isHovered ? 0.7 : 0.35),
                width: _isHovered ? 2.5 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.accentColor.withOpacity(_isHovered ? 0.38 : 0.16),
                  blurRadius: _isHovered ? 16 : 8,
                  offset: Offset(0, _isHovered ? 6 : 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Floating emoji with hover bounce
                FloatingAnimation(
                  offset: 4,
                  duration: const Duration(milliseconds: 1600),
                  child: AnimatedScale(
                    scale: _isHovered ? 1.18 : 1.0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOutBack,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(widget.emoji, style: const TextStyle(fontSize: 38)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.accentColor.withOpacity(0.95),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
