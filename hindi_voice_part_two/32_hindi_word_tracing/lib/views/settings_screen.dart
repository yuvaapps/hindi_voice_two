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
      backgroundColor: const Color(0xFFF0F3FA),
      appBar: AppBar(
        title: Text(
          loc.translate('settings'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Card
          _buildSettingsCard(
            icon: Icons.language,
            iconColor: const Color(0xFF3F51B5),
            title: loc.translate('language'),
            subtitle: vm.locale.languageCode == 'hi'
                ? 'हिन्दी (Hindi)'
                : 'English (अंग्रेज़ी)',
            trailing: BouncingWidget(
              onTap: vm.toggleLanguage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें',
                  style: const TextStyle(
                    color: Colors.white,
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
            iconColor: vm.soundEnabled ? const Color(0xFF3F51B5) : Colors.grey,
            title: loc.translate('sound'),
            subtitle: vm.soundEnabled ? 'Audio voice enabled' : 'Muted',
            trailing: Switch(
              value: vm.soundEnabled,
              activeColor: const Color(0xFF3F51B5),
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          const SizedBox(height: 12),

          // Reset Progress Card with Confirmation Dialog
          _buildSettingsCard(
            icon: Icons.restore,
            iconColor: Colors.redAccent,
            title: loc.translate('reset_progress'),
            subtitle: 'Clear all completed word tracing data',
            trailing: BouncingWidget(
              onTap: () => _confirmReset(context, vm),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // About App Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo.shade50),
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3F51B5).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('🖍️', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hindi Word Tracing',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F51B5),
                          ),
                        ),
                        Text(
                          'App #32 • Version 2.0.0',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 24),
                _buildInfoRow('Database Size', '${AppData.words.length}+ Tracing Words'),
                const SizedBox(height: 8),
                _buildInfoRow('Theme', 'Royal Indigo & Electric Violet'),
                const SizedBox(height: 8),
                _buildInfoRow('Animations', 'Guide Shimmer, Indigo Halo, Confetti'),
                const SizedBox(height: 8),
                _buildInfoRow('Features', 'Watermark Tracing, 6 Color Pens, Audio Ripple'),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.indigo.shade50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _confirmReset(BuildContext context, AppViewModel vm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Reset Progress?'),
        content: const Text(
          'Are you sure you want to reset all your completed word tracing progress and points?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
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
                  content: Text('All tracing progress has been reset.'),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
