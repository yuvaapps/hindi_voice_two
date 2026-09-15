const path = require('path');
const { rootDir, writeFile, setupScaffolding } = require('./generate_app_common');

// ==========================================
// 46. HINDI NUMBER READING
// ==========================================
function buildApp46() {
  const appDir = '46_hindi_number_reading';
  const pkgName = 'app46_hindi_number_reading';
  const appTitle = 'Hindi Number Reading';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'reading_num.dart'), `
class ReadingNum {
  final int number;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String audio;
  const ReadingNum(this.number, this.devanagari, this.hindiName, this.englishName, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/reading_num.dart';

class AppData {
  static const List<ReadingNum> items = [
    ReadingNum(1, '१', 'एक', 'One', 'assets/audio/hi/ek.mp3'),
    ReadingNum(2, '२', 'दो', 'Two', 'assets/audio/hi/do.mp3'),
    ReadingNum(3, '३', 'तीन', 'Three', 'assets/audio/hi/teen.mp3'),
    ReadingNum(4, '४', 'चार', 'Four', 'assets/audio/hi/chaar.mp3'),
    ReadingNum(5, '५', 'पाँच', 'Five', 'assets/audio/hi/paanch.mp3'),
    ReadingNum(6, '६', 'छह', 'Six', 'assets/audio/hi/chhah.mp3'),
    ReadingNum(7, '७', 'सात', 'Seven', 'assets/audio/hi/saat.mp3'),
    ReadingNum(8, '८', 'आठ', 'Eight', 'assets/audio/hi/aath.mp3'),
    ReadingNum(9, '९', 'नौ', 'Nine', 'assets/audio/hi/nau.mp3'),
    ReadingNum(10, '१०', 'दस', 'Ten', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अंक पठन',
  'subtitle': 'अंक देखें और सही उच्चारण पढ़ें',
  'start_learning': 'अंक पढ़ें',
  'practice': 'पठन अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'completed_items': 'पढ़े गए अंक',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'हिंदी संख्या पठन अभ्यास 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Reading',
  'subtitle': 'Read and pronounce Hindi numerals',
  'start_learning': 'Read Numbers',
  'practice': 'Reading Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'completed_items': 'Read Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi number reading practice for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6A1B9A); // Purple
  static const Color secondaryColor = Color(0xFFFFB300);
  static const Color scaffoldBg = Color(0xFFF3E5F5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    _locale = Locale(newLang);
    await StorageService.setLanguage(newLang);
    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'home_screen.dart'), `
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(onPressed: vm.toggleSound, icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('📖', style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: [
                  _Card(title: loc.translate('start_learning'), emoji: '७', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  const _Card({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.items[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('\${_idx + 1} / \${AppData.items.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.devanagari, style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 16),
                    Text(item.hindiName, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('\${item.number} • \${item.englishName}', style: const TextStyle(fontSize: 24, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                IconButton.filled(
                  onPressed: () {
                    vm.playAudio(item.audio);
                    vm.markCompleted(item.number);
                  },
                  icon: const Icon(Icons.volume_up, size: 36),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
                ),
                ElevatedButton(onPressed: _idx < AppData.items.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.items.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'settings_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text(loc.translate('sound')),
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                vm.resetProgress();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset completed')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'main.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiNumberReadingApp(),
    ),
  );
}

class HindiNumberReadingApp extends StatelessWidget {
  const HindiNumberReadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Reading',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [AppLocalizations.delegate],
      home: const HomeScreen(),
    );
  }
}
`);

  console.log('46_hindi_number_reading complete!');
}

// ==========================================
// 47. HINDI NUMBER RECOGNITION
// ==========================================
function buildApp47() {
  const appDir = '47_hindi_number_recognition';
  const pkgName = 'app47_hindi_number_recognition';
  const appTitle = 'Hindi Number Recognition';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'recog_num.dart'), `
class RecogNum {
  final int number;
  final String devanagari;
  final String audio;
  const RecogNum(this.number, this.devanagari, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/recog_num.dart';

class AppData {
  static const List<RecogNum> numbers = [
    RecogNum(1, '१', 'assets/audio/hi/ek.mp3'),
    RecogNum(2, '२', 'assets/audio/hi/do.mp3'),
    RecogNum(3, '३', 'assets/audio/hi/teen.mp3'),
    RecogNum(4, '४', 'assets/audio/hi/chaar.mp3'),
    RecogNum(5, '५', 'assets/audio/hi/paanch.mp3'),
    RecogNum(6, '६', 'assets/audio/hi/chhah.mp3'),
    RecogNum(7, '७', 'assets/audio/hi/saat.mp3'),
    RecogNum(8, '८', 'assets/audio/hi/aath.mp3'),
    RecogNum(9, '९', 'assets/audio/hi/nau.mp3'),
    RecogNum(10, '१०', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अंक पहचान',
  'subtitle': 'आवाज़ सुनें और सही अंक पहचानें',
  'start_learning': 'अंक पहचान खेल',
  'practice': 'क्विज़',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'prompt': 'कौन सी संख्या सुनी? चुनो 🎧',
  'great_job': 'बहुत बढ़िया! 🎉',
  'try_again': 'फिर कोशिश करें 😊',
  'next': 'अगला',
  'completed_items': 'पहचाने गए अंक',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'श्रवण आधारित हिंदी अंक पहचान 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Recognition',
  'subtitle': 'Listen and recognize Hindi numbers',
  'start_learning': 'Recognition Game',
  'practice': 'Quiz',
  'progress': 'Progress',
  'settings': 'Settings',
  'prompt': 'Which number did you hear? 🎧',
  'great_job': 'Great! 🎉',
  'try_again': 'Try Again 😊',
  'next': 'Next',
  'completed_items': 'Recognized Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline audio-based Hindi number recognition.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFC2185B); // Maroon Pink
  static const Color secondaryColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFFCE4EC);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    _locale = Locale(newLang);
    await StorageService.setLanguage(newLang);
    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 15;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'home_screen.dart'), `
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(onPressed: vm.toggleSound, icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('👂', style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: [
                  _Card(title: loc.translate('start_learning'), emoji: '🎧', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  const _Card({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/recog_num.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late RecogNum _target;
  late List<RecogNum> _choices;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<RecogNum>.from(AppData.numbers)..shuffle(_rnd);
    _target = list.first;
    _choices = list.take(3).toList()..shuffle(_rnd);
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playAudio(_target.audio);
    });
  }

  void _check(RecogNum choice) {
    if (_isCorrect == true) return;
    final correct = (choice.number == _target.number);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.playAudio('assets/audio/hi/feedback_great.mp3');
      vm.markCompleted(_target.number);
    } else {
      vm.playAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('prompt'), textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            IconButton.filled(
              onPressed: () => vm.playAudio(_target.audio),
              icon: const Icon(Icons.volume_up, size: 54),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _choices.map((c) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () => _check(c),
                  child: Text(c.devanagari, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => setState(_load),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.numbers.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'settings_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text(loc.translate('sound')),
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                vm.resetProgress();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset completed')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'main.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiNumberRecognitionApp(),
    ),
  );
}

class HindiNumberRecognitionApp extends StatelessWidget {
  const HindiNumberRecognitionApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Recognition',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [AppLocalizations.delegate],
      home: const HomeScreen(),
    );
  }
}
`);

  console.log('47_hindi_number_recognition complete!');
}

// ==========================================
// 48. HINDI NUMBER MATCHING
// ==========================================
function buildApp48() {
  const appDir = '48_hindi_number_matching';
  const pkgName = 'app48_hindi_number_matching';
  const appTitle = 'Hindi Number Matching';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'matching_pair.dart'), `
class MatchingPair {
  final int number;
  final String devanagari;
  final String name;
  final String audio;
  const MatchingPair(this.number, this.devanagari, this.name, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/matching_pair.dart';

class AppData {
  static const List<MatchingPair> pairs = [
    MatchingPair(1, '१', 'एक', 'assets/audio/hi/ek.mp3'),
    MatchingPair(2, '२', 'दो', 'assets/audio/hi/do.mp3'),
    MatchingPair(3, '३', 'तीन', 'assets/audio/hi/teen.mp3'),
    MatchingPair(4, '४', 'चार', 'assets/audio/hi/chaar.mp3'),
    MatchingPair(5, '५', 'पाँच', 'assets/audio/hi/paanch.mp3'),
    MatchingPair(6, '६', 'छह', 'assets/audio/hi/chhah.mp3'),
    MatchingPair(7, '७', 'सात', 'assets/audio/hi/saat.mp3'),
    MatchingPair(8, '८', 'आठ', 'assets/audio/hi/aath.mp3'),
    MatchingPair(9, '९', 'नौ', 'assets/audio/hi/nau.mp3'),
    MatchingPair(10, '१०', 'दस', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अंक मिलान',
  'subtitle': 'अंक को सही नाम से मिलाएँ',
  'start_learning': 'मिलान खेल',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'prompt': 'संख्या और नाम को छुएँ',
  'completed_items': 'सफल मिलान',
  'great_job': 'शानदार मिलान! 🎉',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'हिंदी संख्या मिलान खेल 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Matching',
  'subtitle': 'Match numerals with words',
  'start_learning': 'Matching Game',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'prompt': 'Tap numeral and word to match',
  'completed_items': 'Matched Pairs',
  'great_job': 'Great Match! 🎉',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi number matching game.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00897B); // Teal
  static const Color secondaryColor = Color(0xFFFF9800);
  static const Color scaffoldBg = Color(0xFFE0F2F1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    _locale = Locale(newLang);
    await StorageService.setLanguage(newLang);
    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 15;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'home_screen.dart'), `
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(onPressed: vm.toggleSound, icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('↔️', style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: [
                  _Card(title: loc.translate('start_learning'), emoji: '🧩', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  const _Card({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/matching_pair.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late List<MatchingPair> _currentPairs;
  late List<MatchingPair> _shuffledNames;
  int? _selectedNum;
  int? _selectedName;
  final Set<int> _matched = {};
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<MatchingPair>.from(AppData.pairs)..shuffle(_rnd);
    _currentPairs = list.take(3).toList();
    _shuffledNames = List<MatchingPair>.from(_currentPairs)..shuffle(_rnd);
    _selectedNum = null;
    _selectedName = null;
    _matched.clear();
  }

  void _onSelectNum(int n) {
    setState(() => _selectedNum = n);
    _check();
  }

  void _onSelectName(int n) {
    setState(() => _selectedName = n);
    _check();
  }

  void _check() {
    if (_selectedNum != null && _selectedName != null) {
      final vm = context.read<AppViewModel>();
      if (_selectedNum == _selectedName) {
        final pair = _currentPairs.firstWhere((p) => p.number == _selectedNum);
        vm.playAudio(pair.audio);
        vm.markCompleted(pair.number);
        setState(() {
          _matched.add(_selectedNum!);
          _selectedNum = null;
          _selectedName = null;
        });
      } else {
        vm.playAudio('assets/audio/hi/feedback_try.mp3');
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) setState(() { _selectedNum = null; _selectedName = null; });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('prompt'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              children: [
                // Numerals column
                Expanded(
                  child: Column(
                    children: _currentPairs.map((p) {
                      final isM = _matched.contains(p.number);
                      final isS = _selectedNum == p.number;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isM ? Colors.green.shade100 : (isS ? Colors.orange.shade100 : Colors.white),
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: isM ? null : () => _onSelectNum(p.number),
                          child: Text(p.devanagari, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 24),
                // Names column
                Expanded(
                  child: Column(
                    children: _shuffledNames.map((p) {
                      final isM = _matched.contains(p.number);
                      final isS = _selectedName == p.number;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isM ? Colors.green.shade100 : (isS ? Colors.orange.shade100 : Colors.white),
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: isM ? null : () => _onSelectName(p.number),
                          child: Text(p.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (_matched.length == _currentPairs.length)
              Text(loc.translate('great_job'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => setState(_load),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला स्तर'),
            ),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.pairs.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'settings_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text(loc.translate('sound')),
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                vm.resetProgress();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset completed')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'main.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiNumberMatchingApp(),
    ),
  );
}

class HindiNumberMatchingApp extends StatelessWidget {
  const HindiNumberMatchingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Matching',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [AppLocalizations.delegate],
      home: const HomeScreen(),
    );
  }
}
`);

  console.log('48_hindi_number_matching complete!');
}

// ==========================================
// 49. HINDI NUMBER PRONUNCIATION
// ==========================================
function buildApp49() {
  const appDir = '49_hindi_number_pronunciation';
  const pkgName = 'app49_hindi_number_pronunciation';
  const appTitle = 'Hindi Number Pronunciation';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'pronun_num.dart'), `
class PronunNum {
  final int number;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String hindiAudio;
  final String englishAudio;
  const PronunNum(this.number, this.devanagari, this.hindiName, this.englishName, this.hindiAudio, this.englishAudio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/pronun_num.dart';

class AppData {
  static const List<PronunNum> numbers = [
    PronunNum(1, '१', 'एक', 'One', 'assets/audio/hi/ek.mp3', 'assets/audio/en/ek.mp3'),
    PronunNum(2, '२', 'दो', 'Two', 'assets/audio/hi/do.mp3', 'assets/audio/en/do.mp3'),
    PronunNum(3, '३', 'तीन', 'Three', 'assets/audio/hi/teen.mp3', 'assets/audio/en/teen.mp3'),
    PronunNum(4, '४', 'चार', 'Four', 'assets/audio/hi/chaar.mp3', 'assets/audio/en/chaar.mp3'),
    PronunNum(5, '५', 'पाँच', 'Five', 'assets/audio/hi/paanch.mp3', 'assets/audio/en/paanch.mp3'),
    PronunNum(6, '६', 'छह', 'Six', 'assets/audio/hi/chhah.mp3', 'assets/audio/en/chhah.mp3'),
    PronunNum(7, '७', 'सात', 'Seven', 'assets/audio/hi/saat.mp3', 'assets/audio/en/saat.mp3'),
    PronunNum(8, '८', 'आठ', 'Eight', 'assets/audio/hi/aath.mp3', 'assets/audio/en/aath.mp3'),
    PronunNum(9, '९', 'नौ', 'Nine', 'assets/audio/hi/nau.mp3', 'assets/audio/en/nau.mp3'),
    PronunNum(10, '१०', 'दस', 'Ten', 'assets/audio/hi/das.mp3', 'assets/audio/en/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अंक उच्चारण',
  'subtitle': 'स्पष्ट और मधुर अंक उच्चारण स्टूडियो',
  'start_learning': 'उच्चारण सुनें',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'replay': 'पुनः सुनें',
  'completed_items': 'सीखे गए उच्चारण',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'हिंदी संख्या उच्चारण अभ्यास 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Pronunciation',
  'subtitle': 'Clear & natural pronunciation studio',
  'start_learning': 'Pronounce Numbers',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'replay': 'Replay',
  'completed_items': 'Pronounced Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi number pronunciation for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00ACC1); // Cyan
  static const Color secondaryColor = Color(0xFFFF7043);
  static const Color scaffoldBg = Color(0xFFE0F7FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../models/pronun_num.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    _locale = Locale(newLang);
    await StorageService.setLanguage(newLang);
    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(PronunNum item) async {
    if (!_soundEnabled) return;
    final path = _locale.languageCode == 'en' ? item.englishAudio : item.hindiAudio;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'home_screen.dart'), `
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(onPressed: vm.toggleSound, icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('🎙️', style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: [
                  _Card(title: loc.translate('start_learning'), emoji: '🔊', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  const _Card({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.numbers[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('\${_idx + 1} / \${AppData.numbers.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.devanagari, style: const TextStyle(fontSize: 110, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 16),
                    Text(item.hindiName, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text('\${item.number} • \${item.englishName}', style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    const SizedBox(height: 24),
                    IconButton.filled(
                      onPressed: () {
                        vm.playAudio(item);
                        vm.markCompleted(item.number);
                      },
                      icon: const Icon(Icons.volume_up, size: 44),
                      style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
                    ),
                    const SizedBox(height: 10),
                    Text(loc.translate('replay'), style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                ElevatedButton(onPressed: _idx < AppData.numbers.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.numbers.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'settings_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text(loc.translate('sound')),
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                vm.resetProgress();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset completed')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'main.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiNumberPronunciationApp(),
    ),
  );
}

class HindiNumberPronunciationApp extends StatelessWidget {
  const HindiNumberPronunciationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Pronunciation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [AppLocalizations.delegate],
      home: const HomeScreen(),
    );
  }
}
`);

  console.log('49_hindi_number_pronunciation complete!');
}

// ==========================================
// 50. HINDI COUNTING OBJECTS
// ==========================================
function buildApp50() {
  const appDir = '50_hindi_counting_objects';
  const pkgName = 'app50_hindi_counting_objects';
  const appTitle = 'Hindi Counting Objects';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'object_group.dart'), `
class ObjectGroup {
  final int count;
  final String objectHindi;
  final String objectEnglish;
  final String emoji;
  final String numAudio;
  const ObjectGroup(this.count, this.objectHindi, this.objectEnglish, this.emoji, this.numAudio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/object_group.dart';

class AppData {
  static const List<ObjectGroup> items = [
    ObjectGroup(5, 'कुत्ते', 'Dogs', '🐶', 'assets/audio/hi/paanch.mp3'),
    ObjectGroup(3, 'बिल्लियाँ', 'Cats', '🐱', 'assets/audio/hi/teen.mp3'),
    ObjectGroup(4, 'गाड़ियाँ', 'Cars', '🚗', 'assets/audio/hi/chaar.mp3'),
    ObjectGroup(6, 'फूल', 'Flowers', '🌸', 'assets/audio/hi/chhah.mp3'),
    ObjectGroup(7, 'तारे', 'Stars', '⭐️', 'assets/audio/hi/saat.mp3'),
    ObjectGroup(2, 'सेब', 'Apples', '🍎', 'assets/audio/hi/do.mp3'),
    ObjectGroup(8, 'गुब्बारे', 'Balloons', '🎈', 'assets/audio/hi/aath.mp3'),
    ObjectGroup(1, 'सूरज', 'Sun', '☀️', 'assets/audio/hi/ek.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी वस्तु गणना',
  'subtitle': 'चित्रित वस्तुएं गिनें और उत्तर दें',
  'start_learning': 'वस्तुएं गिनें',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'prompt_prefix': 'कितने',
  'prompt_suffix': 'हैं?',
  'great_job': 'बहुत बढ़िया! 🎉',
  'try_again': 'फिर गिनें 😊',
  'next': 'अगला',
  'completed_items': 'सफल वस्तु गणना',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'मनोरंजक वस्तु गणना खेल 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Counting Objects',
  'subtitle': 'Count illustrated objects and answer',
  'start_learning': 'Count Objects',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'prompt_prefix': 'How many',
  'prompt_suffix': 'are there?',
  'great_job': 'Excellent! 🎉',
  'try_again': 'Count again 😊',
  'next': 'Next',
  'completed_items': 'Successful Countings',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline visual object counting game for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFEF6C00); // Orange
  static const Color secondaryColor = Color(0xFF00B0FF);
  static const Color scaffoldBg = Color(0xFFFFF3E0);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    _locale = Locale(newLang);
    await StorageService.setLanguage(newLang);
    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 15;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'home_screen.dart'), `
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: vm.toggleLanguage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                    child: Text(vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  IconButton.filledTonal(onPressed: vm.toggleSound, icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc.translate('app_title'), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(loc.translate('subtitle'), style: const TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                    const Text('🐶', style: TextStyle(fontSize: 50)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                children: [
                  _Card(title: loc.translate('start_learning'), emoji: '⭐', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;
  const _Card({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 44)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/object_group.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late ObjectGroup _target;
  late List<int> _options;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<ObjectGroup>.from(AppData.items)..shuffle(_rnd);
    _target = list.first;

    final opts = {_target.count};
    while (opts.length < 4) {
      opts.add(_rnd.nextInt(8) + 1);
    }
    _options = opts.toList()..shuffle(_rnd);
    _isCorrect = null;
  }

  void _check(int ans) {
    if (_isCorrect == true) return;
    final correct = (ans == _target.count);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.playAudio(_target.numAudio);
      vm.markCompleted(_target.count);
    } else {
      vm.playAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final promptText = isHindi
        ? '\${loc.translate('prompt_prefix')} \${_target.objectHindi} \${loc.translate('prompt_suffix')}'
        : '\${loc.translate('prompt_prefix')} \${_target.objectEnglish.toLowerCase()} \${loc.translate('prompt_suffix')}';

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(promptText, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(_target.count, (i) {
                  return Text(_target.emoji, style: const TextStyle(fontSize: 48));
                }),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _options.map((opt) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => _check(opt),
                  child: Text('$opt', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => setState(_load),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.items.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress'))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌟', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 12),
            Text('$done / $total', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'settings_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(loc.translate('language')),
              subtitle: Text(vm.locale.languageCode == 'hi' ? 'हिन्दी' : 'English'),
              trailing: ElevatedButton(
                onPressed: vm.toggleLanguage,
                child: Text(vm.locale.languageCode == 'hi' ? 'Switch to English' : 'हिन्दी चुनें'),
              ),
            ),
          ),
          Card(
            child: SwitchListTile(
              title: Text(loc.translate('sound')),
              value: vm.soundEnabled,
              onChanged: (_) => vm.toggleSound(),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.refresh, color: Colors.red),
              title: Text(loc.translate('reset_progress'), style: const TextStyle(color: Colors.red)),
              onTap: () {
                vm.resetProgress();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset completed')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'main.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'localization/app_localizations.dart';
import 'utils/app_theme.dart';
import 'viewmodels/app_view_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppViewModel())],
      child: const HindiCountingObjectsApp(),
    ),
  );
}

class HindiCountingObjectsApp extends StatelessWidget {
  const HindiCountingObjectsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Counting Objects',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: vm.locale,
      supportedLocales: const [Locale('hi'), Locale('en')],
      localizationsDelegates: const [AppLocalizations.delegate],
      home: const HomeScreen(),
    );
  }
}
`);

  console.log('50_hindi_counting_objects complete!');
}

async function run() {
  buildApp46();
  buildApp47();
  buildApp48();
  buildApp49();
  buildApp50();
  console.log('Group E (Apps 46-50) build finished.');
}

run();
