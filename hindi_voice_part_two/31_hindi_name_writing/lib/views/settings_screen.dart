import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  final bool isTab;
  const SettingsScreen({super.key, this.isTab = false});

  void _confirmReset(BuildContext context, AppViewModel vm, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange, size: 28),
            const SizedBox(width: 8),
            Text(loc.translate('reset_progress')),
          ],
        ),
        content: Text(
          vm.locale.languageCode == 'hi'
              ? 'क्या आप सच में अपनी पूरी नाम लेखन प्रगति रीसेट करना चाहते हैं?'
              : 'Are you sure you want to reset all your name writing progress and scores?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(loc.translate('cancel')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              vm.resetProgress();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Progress reset successfully! / प्रगति रीसेट हो गई'),
                  backgroundColor: AppTheme.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final list = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      children: [
        // Language Option
        StaggeredEntrance(
          index: 0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF80DEEA), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.language_rounded, color: AppTheme.primaryColor),
              ),
              title: Text(loc.translate('language'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                isHindi ? 'वर्तमान: हिन्दी (India)' : 'Current: English',
                style: TextStyle(color: AppTheme.subtitleColor.withOpacity(0.85)),
              ),
              trailing: BouncingWidget(
                onTap: vm.toggleLanguage,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppTheme.headerGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    isHindi ? 'English' : 'हिन्दी',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Sound Option
        StaggeredEntrance(
          index: 1,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF80DEEA), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              secondary: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppTheme.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                  color: AppTheme.primaryColor,
                ),
              ),
              title: Text(loc.translate('sound'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(
                vm.soundEnabled ? 'Audio pronunciation ON' : 'Audio pronunciation OFF',
                style: TextStyle(color: AppTheme.subtitleColor.withOpacity(0.85)),
              ),
              activeColor: AppTheme.primaryColor,
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
        ),

        // Reset Progress Option
        StaggeredEntrance(
          index: 2,
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFFFCDD2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.restart_alt_rounded, color: Colors.deepOrange),
              ),
              title: Text(
                loc.translate('reset_progress'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange),
              ),
              subtitle: Text('Clear name writing progress & score', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              onTap: () => _confirmReset(context, vm, loc),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // About Theme Card
        StaggeredEntrance(
          index: 3,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF80DEEA), width: 1.2),
            ),
            child: const Row(
              children: [
                Text('🖋️', style: TextStyle(fontSize: 32)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hindi Name Writing • हिन्दी नाम लेखन',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF006064)),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Cyan & Teal Edition • Calligraphy & Tracing',
                        style: TextStyle(fontSize: 12, color: Color(0xFF00838F)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    if (isTab) return SafeArea(child: list);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(loc.translate('settings'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(child: list),
    );
  }
}
