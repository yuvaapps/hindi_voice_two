
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';
import 'learning_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white24, foregroundColor: Colors.white),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton(icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off, color: Colors.white), onPressed: vm.toggleSound),
                ],
              ),
              const Spacer(),
              const Center(child: Text('🖍️', style: TextStyle(fontSize: 80))),
              const SizedBox(height: 12),
              Text(loc.translate('app_title'), textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(loc.translate('subtitle'), textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white70)),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentColor, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen())),
                icon: const Icon(Icons.brush, size: 28),
                label: Text(loc.translate('start_learning'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
                      child: Text(loc.translate('progress')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                      child: Text(loc.translate('settings')),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
