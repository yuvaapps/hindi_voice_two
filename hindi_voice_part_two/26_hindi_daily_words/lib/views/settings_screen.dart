import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../utils/animation_utils.dart';
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
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Language Card
          StaggeredEntrance(
            index: 0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language_rounded, color: AppTheme.primaryColor),
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
                          child: BouncingWidget(
                            onTap: () => vm.setLanguage('hi'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: vm.locale.languageCode == 'hi'
                                    ? AppTheme.primaryColor.withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: vm.locale.languageCode == 'hi'
                                      ? AppTheme.primaryColor
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '🇮🇳 हिन्दी',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: BouncingWidget(
                            onTap: () => vm.setLanguage('en'),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: vm.locale.languageCode == 'en'
                                    ? AppTheme.primaryColor.withOpacity(0.15)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: vm.locale.languageCode == 'en'
                                      ? AppTheme.primaryColor
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  '🇬🇧 English',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Sound Card
          StaggeredEntrance(
            index: 1,
            child: Card(
              child: SwitchListTile(
                secondary: AnimatedRotation(
                  turns: vm.soundEnabled ? 0.0 : -0.1,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                    color: AppTheme.primaryColor,
                  ),
                ),
                title: Text(
                  loc.translate('sound'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  vm.soundEnabled ? loc.translate('sound_on') : loc.translate('sound_off'),
                ),
                value: vm.soundEnabled,
                activeTrackColor: AppTheme.primaryColor,
                onChanged: (_) => vm.toggleSound(),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Reset Progress Card
          StaggeredEntrance(
            index: 2,
            child: Card(
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
          ),

          const SizedBox(height: 12),

          // About Card
          StaggeredEntrance(
            index: 3,
            child: Card(
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
          ),
        ],
      ),
    );
  }
}
