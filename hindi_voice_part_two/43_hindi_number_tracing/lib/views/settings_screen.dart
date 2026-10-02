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
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('settings')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Voice & Audio Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.record_voice_over, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        isHindi ? 'ऑडियो एवं आवाज़ (Audio & Voice)' : 'Audio & Speech Engine',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(loc.translate('sound')),
                    subtitle: Text(vm.soundEnabled ? 'Enabled (ध्वनि चालू)' : 'Muted (ध्वनि बंद)'),
                    value: vm.soundEnabled,
                    onChanged: (_) => vm.toggleSound(),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Test Hindi Voice', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('आवाज़ की जांच करें', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        ],
                      ),
                      BouncingWidget(
                        onTap: vm.testVoice,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.play_arrow, color: Colors.white, size: 18),
                              SizedBox(width: 4),
                              Text('Play Sample',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Language Setting Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1.5,
            child: ListTile(
              leading: const Icon(Icons.language, color: AppTheme.secondaryColor),
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी (Hindi)' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // About Tracing Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('✍️', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 8),
                      Text('Hindi Number Tracing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isHindi
                        ? 'इस ऐप में ० से २० तक सभी देवनागरी अंकों का अनुरेखण, बहु-रंगी ब्रश, आवाज़ और तमिल अर्थ शामिल हैं।'
                        : 'Practice tracing numbers 0 to 20 with interactive multi-colored brushes, authentic pronunciation, and Tamil translations.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Reset Progress Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 1.5,
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              subtitle: Text(isHindi ? 'प्रगति और अंक रीसेट करें' : 'Clear all completed numbers & score'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Reset Progress?'),
                    content: const Text('Are you sure you want to reset all your completed numbers and score?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          vm.resetProgress();
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Progress has been reset.')),
                          );
                        },
                        child: const Text('Reset', style: TextStyle(color: Colors.red)),
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
