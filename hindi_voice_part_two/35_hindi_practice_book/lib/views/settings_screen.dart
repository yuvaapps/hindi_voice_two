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
          // Language Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 1,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFCE4EC),
                child: Text('🌐', style: TextStyle(fontSize: 20)),
              ),
              title: Text(loc.translate('language'), style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी (Hindi)' : '🇬🇧 English'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Sound Card with Voice Test
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 1,
            child: Column(
              children: [
                SwitchListTile(
                  secondary: CircleAvatar(
                    backgroundColor: const Color(0xFFFCE4EC),
                    child: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off, color: AppTheme.primaryColor),
                  ),
                  title: Text(loc.translate('sound'), style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('हिंदी उच्चारण एवं ध्वनि प्रभाव (Hindi Audio)'),
                  value: vm.soundEnabled,
                  activeColor: AppTheme.primaryColor,
                  onChanged: (_) => vm.toggleSound(),
                ),
                if (vm.soundEnabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.record_voice_over, color: AppTheme.primaryColor),
                    title: const Text('आवाज़ टेस्ट करें (Test Hindi Voice)', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: const Text('नमूना उच्चारण सुनें'),
                    trailing: BouncingWidget(
                      onTap: () {
                        vm.playAudio('assets/audio/hi/kamal.mp3', textFallback: 'कमल');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCE4EC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.primaryColor),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow, color: AppTheme.primaryColor, size: 20),
                            SizedBox(width: 4),
                            Text('सुने', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Reset Progress Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 1,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFEBEE),
                child: Icon(Icons.refresh, color: Colors.red),
              ),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              subtitle: const Text('सभी पूर्ण किए गए अभ्यासों को रीसेट करें'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('प्रगति रीसेट करें?'),
                    content: const Text('क्या आप सच में अपनी सारी अभ्यास प्रगति और अंक रीसेट करना चाहते हैं?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pop(ctx);
                          vm.resetProgress();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('प्रगति रीसेट हो गई है')),
                          );
                        },
                        child: const Text('रीसेट करें'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // About App Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('📕', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 10),
                      Text(loc.translate('about'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    loc.translate('about_desc'),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '• 1,300+ प्रामाणिक अभ्यास (अक्षर, शब्द, वाक्य)\n• स्वर, व्यंजन, बारहखड़ी, दो/तीन/चार अक्षर वाले शब्द\n• गिनती १ से १००, फल, सब्ज़ी, पशु-पक्षी, रिश्ते\n• बहु-रंगीन पेन, इरेज़र एवं नोटबुक गाइड रेखाएं\n• हिंदी वॉइस सपोर्ट (Web SpeechSynthesis fallback)',
                    style: TextStyle(fontSize: 12, height: 1.5, color: Colors.black87),
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
