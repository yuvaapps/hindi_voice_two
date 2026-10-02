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
      body: BlossomFloat(
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with tactile bounce & sound rotation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BouncingWidget(
                    onTap: () => vm.toggleLanguage(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: AppTheme.primaryColor.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.textColor),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.swap_horiz, size: 20, color: AppTheme.primaryColor),
                        ],
                      ),
                    ),
                  ),
                  BouncingWidget(
                    onTap: () => vm.toggleSound(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppTheme.primaryColor.withOpacity(0.12), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3), width: 1.5),
                      ),
                      child: AnimatedRotation(
                        turns: vm.soundEnabled ? 0.0 : -0.1,
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                          color: vm.soundEnabled ? AppTheme.primaryColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hero Banner with Pink Gradient & Animated Floating Alphabet
              StaggeredEntrance(
                index: 0,
                duration: const Duration(milliseconds: 450),
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
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.translate('subtitle'),
                              style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.95)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingAnimation(
                        offset: 5,
                        duration: const Duration(milliseconds: 1900),
                        child: PulsingScale(
                          minScale: 0.95,
                          maxScale: 1.08,
                          duration: const Duration(milliseconds: 1300),
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
                            child: const Text('🔤', style: TextStyle(fontSize: 38)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Animated Menu Grid with Pink-Themed Palette & Staggered Entrance
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
                    child: _MenuCard(
                      title: loc.translate('start_learning'),
                      emoji: '📚',
                      color: const Color(0xFFFCE4EC), // Soft Pastel Pink
                      accentColor: const Color(0xFFE91E63), // Vibrant Pink
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 2,
                    child: _MenuCard(
                      title: loc.translate('practice'),
                      emoji: '🧩',
                      color: const Color(0xFFFFF0F5), // Lavender Blush Pink
                      accentColor: const Color(0xFFC2185B), // Deep Rose Pink
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 3,
                    child: _MenuCard(
                      title: loc.translate('progress'),
                      emoji: '🏆',
                      color: const Color(0xFFFFEBEE), // Coral Blush Pink
                      accentColor: const Color(0xFFD81B60), // Ruby Pink
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
                    ),
                  ),
                  StaggeredEntrance(
                    index: 4,
                    child: _MenuCard(
                      title: loc.translate('settings'),
                      emoji: '⚙️',
                      color: const Color(0xFFF8BBD0), // Sweet Rose Pink
                      accentColor: const Color(0xFF880E4F), // Rich Berry Pink
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _MenuCard extends StatefulWidget {
  final String title;
  final String emoji;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.emoji,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: BouncingWidget(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: widget.accentColor.withOpacity(_isHovered ? 0.7 : 0.3),
              width: _isHovered ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.accentColor.withOpacity(_isHovered ? 0.35 : 0.15),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 6 : 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingAnimation(
                offset: 3.5,
                duration: const Duration(milliseconds: 1700),
                child: AnimatedScale(
                  scale: _isHovered ? 1.15 : 1.0,
                  duration: const Duration(milliseconds: 160),
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
                    color: widget.accentColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
