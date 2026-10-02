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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          StaggeredEntrance(
            index: 0,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: ListTile(
                leading: const Icon(Icons.language_rounded, color: AppTheme.primaryColor),
                title: Text(loc.translate('language'), style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English'),
                trailing: BouncingWidget(
                  onTap: vm.toggleLanguage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें',
                      style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          StaggeredEntrance(
            index: 1,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: SwitchListTile(
                secondary: AnimatedRotation(
                  turns: vm.soundEnabled ? 0.0 : -0.1,
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                    color: AppTheme.primaryColor,
                  ),
                ),
                title: Text(loc.translate('sound'), style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(vm.soundEnabled ? loc.translate('sound_on') : loc.translate('sound_off')),
                value: vm.soundEnabled,
                activeTrackColor: AppTheme.primaryColor,
                onChanged: (_) => vm.toggleSound(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          StaggeredEntrance(
            index: 2,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: ListTile(
                leading: const Icon(Icons.refresh_rounded, color: Colors.redAccent),
                title: Text(loc.translate('reset_progress'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
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
                              const SnackBar(content: Text('प्रगति रीसेट हो गई है (Reset completed)')),
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
        ],
      ),
    );
  }
}
