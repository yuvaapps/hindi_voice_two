import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(loc.translate('settings')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Card
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F7FA),
                child: Icon(Icons.language, color: AppTheme.primaryColor),
              ),
              title: Text(
                loc.translate('language'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी (Hindi)' : 'English'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: vm.toggleLanguage,
                child: Text(
                  vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // Audio Sound Switch Card
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              secondary: const CircleAvatar(
                backgroundColor: Color(0xFFE0F7FA),
                child: Icon(Icons.volume_up, color: AppTheme.primaryColor),
              ),
              title: Text(
                loc.translate('sound'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(vm.soundEnabled ? 'Enabled (चालू)' : 'Muted (बंद)'),
              value: vm.soundEnabled,
              activeColor: AppTheme.primaryColor,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),

          // Slow Speech Default Toggle
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              secondary: const CircleAvatar(
                backgroundColor: Color(0xFFFFF3E0),
                child: Text('🐢', style: TextStyle(fontSize: 18)),
              ),
              title: Text(
                loc.translate('slow_speed'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('0.6x Slow & Clear Articulation'),
              value: vm.slowSpeed,
              activeColor: const Color(0xFFE65100),
              onChanged: (_) => vm.toggleSlowSpeed(),
            ),
          ),

          // About App Card
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE0F7FA),
                child: Icon(Icons.info_outline, color: AppTheme.primaryColor),
              ),
              title: Text(
                loc.translate('about'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${AppData.allItems.length} Words & Numbers (15 Categories)\nAuthentic Hindi TTS & Audio',
              ),
            ),
          ),

          // Reset Progress Card
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFEBEE),
                child: Icon(Icons.refresh, color: Colors.red),
              ),
              title: Text(
                loc.translate('reset_progress'),
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Clear all pronounced items & points'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(loc.translate('reset_progress')),
                    content: Text(loc.translate('reset_confirm')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(loc.translate('cancel')),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          vm.resetProgress();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(loc.translate('reset_progress'))),
                          );
                        },
                        child: Text(loc.translate('reset')),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
