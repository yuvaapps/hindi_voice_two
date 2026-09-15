import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      appBar: AppBar(
        title: Text(loc.translate('settings')),
        backgroundColor: const Color(0xFF8E24AA),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Language Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.language_rounded, color: Color(0xFF8E24AA)),
                      const SizedBox(width: 8),
                      Text(
                        loc.translate('language'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: vm.locale.languageCode == 'hi'
                                ? const Color(0xFF8E24AA).withOpacity(0.15)
                                : null,
                            side: BorderSide(
                              color: vm.locale.languageCode == 'hi'
                                  ? const Color(0xFF8E24AA)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          onPressed: () => vm.setLanguage('hi'),
                          child: const Text('🇮🇳 हिन्दी', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: vm.locale.languageCode == 'en'
                                ? const Color(0xFF8E24AA).withOpacity(0.15)
                                : null,
                            side: BorderSide(
                              color: vm.locale.languageCode == 'en'
                                  ? const Color(0xFF8E24AA)
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          onPressed: () => vm.setLanguage('en'),
                          child: const Text('🇬🇧 English', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Sound Card
          Card(
            child: SwitchListTile(
              secondary: Icon(
                vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                color: const Color(0xFF8E24AA),
              ),
              title: Text(
                loc.translate('sound'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                vm.soundEnabled ? loc.translate('sound_on') : loc.translate('sound_off'),
              ),
              value: vm.soundEnabled,
              activeTrackColor: const Color(0xFF8E24AA),
              onChanged: (_) => vm.toggleSound(),
            ),
          ),

          const SizedBox(height: 12),

          // Reset Progress Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh_rounded, color: Colors.redAccent),
              title: Text(
                loc.translate('reset_progress'),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
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
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () {
                          vm.resetProgress();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('प्रगति रीसेट हो गई है')),
                          );
                        },
                        child: Text(loc.translate('confirm'), style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // About Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline_rounded, color: AppTheme.subtitleColor),
                      const SizedBox(width: 8),
                      Text(
                        loc.translate('about'),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.translate('about_desc'),
                    style: const TextStyle(fontSize: 14, color: AppTheme.subtitleColor),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Version 1.0.0 • 100% Offline • Made for Kids',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
