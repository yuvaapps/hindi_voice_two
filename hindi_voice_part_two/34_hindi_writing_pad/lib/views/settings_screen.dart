import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
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
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Text(
          loc.translate('settings'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Card
          _buildSettingsCard(
            icon: Icons.language,
            iconColor: AppTheme.accentColor,
            title: loc.translate('language'),
            subtitle: vm.locale.languageCode == 'hi'
                ? 'हिन्दी (Hindi)'
                : 'English (अंग्रेज़ी)',
            trailing: BouncingWidget(
              onTap: vm.toggleLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Sound Card
          _buildSettingsCard(
            icon: vm.soundEnabled ? Icons.volume_up : Icons.volume_off,
            iconColor: vm.soundEnabled ? AppTheme.accentColor : Colors.grey,
            title: loc.translate('sound'),
            subtitle: vm.soundEnabled ? 'ध्वनि चालू है (Voice Audio Enabled)' : 'मौन (Muted)',
            trailing: Switch(
              value: vm.soundEnabled,
              activeColor: AppTheme.accentColor,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          const SizedBox(height: 12),

          // Reset Progress Card with Confirmation Dialog
          _buildSettingsCard(
            icon: Icons.restore,
            iconColor: Colors.redAccent,
            title: loc.translate('reset_progress'),
            subtitle: 'राइटिंग पैड की पूर्ण प्रगति रीसेट करें',
            trailing: BouncingWidget(
              onTap: () => _confirmReset(context, vm),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade900.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                ),
                child: const Text(
                  'रीसेट',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // About App Specifications Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('🖍️', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hindi Writing Pad',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'App #34 • Version 2.0.0',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 24, color: Colors.white12),
                _buildInfoRow('Database Size', '${AppData.prompts.length} Writing Prompts'),
                const SizedBox(height: 8),
                _buildInfoRow('Voice Engine', 'Hindi Voice & Audio Pronunciation'),
                const SizedBox(height: 8),
                _buildInfoRow('Theme', 'Dark Slate Chalkboard & Neon Chalk'),
                const SizedBox(height: 8),
                _buildInfoRow('Chalk Tools', '7 Neon Colors, 3 Sizes, Duster/Eraser'),
                const SizedBox(height: 8),
                _buildInfoRow('Categories', 'Vowels, Consonants, Words, Numbers, Sentences'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.12),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 13)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xFF00E5FF),
          ),
        ),
      ],
    );
  }

  void _confirmReset(BuildContext context, AppViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('प्रगति रीसेट करें?'),
        content: const Text(
          'क्या आप अपनी सभी लिखी गई प्रविष्टियों की प्रगति और अंक रीसेट करना चाहते हैं?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('रद्द करें', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              vm.resetProgress();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('राइटिंग पैड की प्रगति रीसेट कर दी गई है।'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            child: const Text('रीसेट'),
          ),
        ],
      ),
    );
  }
}
