const path = require('path');
const { rootDir, writeFile, setupScaffolding } = require('./generate_app_common');

// ==========================================
// 36. HINDI READING NOTEBOOK
// ==========================================
function buildApp36() {
  const appDir = '36_hindi_reading_notebook';
  const pkgName = 'app36_hindi_reading_notebook';
  const appTitle = 'Hindi Reading Notebook';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'reading_item.dart'), `
class ReadingItem {
  final int level; // 1: letters, 2: easy words, 3: 3-letter, 4: phrases, 5: sentences
  final String hindi;
  final String english;
  final String audio;
  const ReadingItem(this.level, this.hindi, this.english, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/reading_item.dart';

class AppData {
  static const List<ReadingItem> items = [
    // Level 1: Letters
    ReadingItem(1, 'अ', 'Letter A', 'assets/audio/hi/a_letter.mp3'),
    ReadingItem(1, 'आ', 'Letter Aa', 'assets/audio/hi/aa_letter.mp3'),
    ReadingItem(1, 'क', 'Letter Ka', 'assets/audio/hi/k_letter.mp3'),
    ReadingItem(1, 'ख', 'Letter Kha', 'assets/audio/hi/kh_letter.mp3'),
    ReadingItem(1, 'ग', 'Letter Ga', 'assets/audio/hi/g_letter.mp3'),
    // Level 2: 2-Letter Words
    ReadingItem(2, 'कल', 'Tomorrow', 'assets/audio/hi/kal.mp3'),
    ReadingItem(2, 'जल', 'Water', 'assets/audio/hi/jal.mp3'),
    ReadingItem(2, 'फल', 'Fruit', 'assets/audio/hi/phal.mp3'),
    ReadingItem(2, 'सच', 'Truth', 'assets/audio/hi/sach.mp3'),
    ReadingItem(2, 'घर', 'Home', 'assets/audio/hi/ghar.mp3'),
    // Level 3: 3-Letter Words
    ReadingItem(3, 'कमल', 'Lotus', 'assets/audio/hi/kamal.mp3'),
    ReadingItem(3, 'मटर', 'Peas', 'assets/audio/hi/matar.mp3'),
    ReadingItem(3, 'सड़क', 'Road', 'assets/audio/hi/sadak.mp3'),
    ReadingItem(3, 'कलम', 'Pen', 'assets/audio/hi/kalam.mp3'),
    ReadingItem(3, 'शहद', 'Honey', 'assets/audio/hi/shehad.mp3'),
    // Level 4: Phrases
    ReadingItem(4, 'मीठा आम', 'Sweet mango', 'assets/audio/hi/aam.mp3'),
    ReadingItem(4, 'शीतल जल', 'Cold water', 'assets/audio/hi/jal.mp3'),
    ReadingItem(4, 'सुंदर कमल', 'Beautiful lotus', 'assets/audio/hi/kamal.mp3'),
    ReadingItem(4, 'बड़ा घर', 'Big home', 'assets/audio/hi/ghar.mp3'),
    // Level 5: Sentences
    ReadingItem(5, 'यह मेरा घर है', 'This is my home', 'assets/audio/hi/s1_ghar.mp3'),
    ReadingItem(5, 'आम बहुत मीठा है', 'The mango is very sweet', 'assets/audio/hi/s2_aam.mp3'),
    ReadingItem(5, 'शीतल जल भर लो', 'Fill cold water', 'assets/audio/hi/s3_jal.mp3'),
    ReadingItem(5, 'कमल खिल गया', 'The lotus has bloomed', 'assets/audio/hi/s4_kamal.mp3'),
    ReadingItem(5, 'सूरज पूर्व से निकलता है', 'The sun rises in the east', 'assets/audio/hi/s5_suraj.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी पठन नोटबुक',
  'subtitle': 'अक्षर से वाक्य तक पढ़ने का सफर',
  'start_learning': 'पढ़ना सीखें',
  'practice': 'पठन अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'level': 'स्तर',
  'completed_items': 'पढ़े गए पाठ',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'क्रमिक स्तरों में हिंदी पढ़ना सिखाने वाली नोटबुक 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Reading Notebook',
  'subtitle': 'Progressive reading ladder from letters to sentences',
  'start_learning': 'Learn Reading',
  'practice': 'Reading Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'level': 'Level',
  'completed_items': 'Completed Lessons',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': 'Progressive Hindi reading notebook 100% offline.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1565C0); // Royal Blue
  static const Color secondaryColor = Color(0xFFFF9800);
  static const Color scaffoldBg = Color(0xFFF4F7FC);

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
  int _selectedLevel = 1;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  int get selectedLevel => _selectedLevel;

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

  void setLevel(int lvl) {
    _selectedLevel = lvl;
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

  Future<void> markCompleted(String text) async {
    if (!_completedIds.contains(text)) {
      _completedIds.add(text);
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
                  _Card(title: loc.translate('start_learning'), emoji: '📚', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final items = AppData.items.where((i) => i.level == vm.selectedLevel).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          // Level selector tabs
          SizedBox(
            height: 54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: 5,
              itemBuilder: (context, idx) {
                final lvl = idx + 1;
                final isSel = (vm.selectedLevel == lvl);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('\${loc.translate('level')} \$lvl'),
                    selected: isSel,
                    onSelected: (_) => vm.setLevel(lvl),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, idx) {
                final item = items[idx];
                final isDone = vm.completedIds.contains(item.hindi);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.hindi, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(item.english, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () {
                            vm.playAudio(item.audio);
                            vm.markCompleted(item.hindi);
                          },
                          icon: const Icon(Icons.volume_up),
                          style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                        ),
                      ],
                    ),
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
      child: const HindiReadingNotebookApp(),
    ),
  );
}

class HindiReadingNotebookApp extends StatelessWidget {
  const HindiReadingNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Reading Notebook',
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

  console.log('36_hindi_reading_notebook complete!');
}

// ==========================================
// 37. HINDI VOCABULARY NOTEBOOK
// ==========================================
function buildApp37() {
  const appDir = '37_hindi_vocabulary_notebook';
  const pkgName = 'app37_hindi_vocabulary_notebook';
  const appTitle = 'Hindi Vocabulary Notebook';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'vocab_item.dart'), `
class VocabItem {
  final String id;
  final String category;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;
  const VocabItem(this.id, this.category, this.hindi, this.english, this.emoji, this.hindiAudio, this.englishAudio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/vocab_item.dart';

class AppData {
  static const List<VocabItem> items = [
    VocabItem('sher', 'animals', 'शेर', 'Lion', '🦁', 'assets/audio/hi/sher.mp3', 'assets/audio/en/sher.mp3'),
    VocabItem('haathi', 'animals', 'हाथी', 'Elephant', '🐘', 'assets/audio/hi/haathi.mp3', 'assets/audio/en/haathi.mp3'),
    VocabItem('gaay', 'animals', 'गाय', 'Cow', '🐮', 'assets/audio/hi/gaay.mp3', 'assets/audio/en/gaay.mp3'),
    VocabItem('seb', 'fruits', 'सेब', 'Apple', '🍎', 'assets/audio/hi/seb.mp3', 'assets/audio/en/seb.mp3'),
    VocabItem('aam', 'fruits', 'आम', 'Mango', '🥭', 'assets/audio/hi/aam.mp3', 'assets/audio/en/aam.mp3'),
    VocabItem('kela', 'fruits', 'केला', 'Banana', '🍌', 'assets/audio/hi/kela.mp3', 'assets/audio/en/kela.mp3'),
    VocabItem('matar', 'vegetables', 'मटर', 'Peas', '🫛', 'assets/audio/hi/matar.mp3', 'assets/audio/en/matar.mp3'),
    VocabItem('aankh', 'body', 'आँख', 'Eye', '👁️', 'assets/audio/hi/aankh.mp3', 'assets/audio/en/aankh.mp3'),
    VocabItem('kaan', 'body', 'कान', 'Ear', '👂', 'assets/audio/hi/kaan.mp3', 'assets/audio/en/kaan.mp3'),
    VocabItem('haath', 'body', 'हाथ', 'Hand', '✋', 'assets/audio/hi/haath.mp3', 'assets/audio/en/haath.mp3'),
    VocabItem('suraj', 'nature', 'सूरज', 'Sun', '☀️', 'assets/audio/hi/suraj.mp3', 'assets/audio/en/suraj.mp3'),
    VocabItem('chand', 'nature', 'चाँद', 'Moon', '🌙', 'assets/audio/hi/chand.mp3', 'assets/audio/en/chand.mp3'),
    VocabItem('ped', 'nature', 'पेड़', 'Tree', '🌳', 'assets/audio/hi/ped.mp3', 'assets/audio/en/ped.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी शब्दकोश नोटबुक',
  'subtitle': 'श्रेणी अनुसार 10+ विषयों के शब्द',
  'start_learning': 'शब्दावली सीखें',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'all': 'सभी',
  'animals': 'जानवर',
  'fruits': 'फल',
  'vegetables': 'सब्जियाँ',
  'body': 'शरीर',
  'nature': 'प्रकृति',
  'completed_items': 'सीखे गए शब्द',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'थीम आधारित हिंदी शब्दावली नोटबुक 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Vocabulary Notebook',
  'subtitle': 'Thematic vocabulary notebook for kids',
  'start_learning': 'Learn Vocabulary',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'all': 'All',
  'animals': 'Animals',
  'fruits': 'Fruits',
  'vegetables': 'Vegetables',
  'body': 'Body Parts',
  'nature': 'Nature',
  'completed_items': 'Learned Words',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline thematic Hindi vocabulary notebook.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00796B); // Deep Teal
  static const Color secondaryColor = Color(0xFFFFB300);
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
import '../models/vocab_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String _category = 'all';

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String get category => _category;

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

  void setCategory(String cat) {
    _category = cat;
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

  Future<void> markCompleted(String id) async {
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(VocabItem item) async {
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
                    const Text('🗂️', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📚', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final categories = ['all', 'animals', 'fruits', 'vegetables', 'body', 'nature'];
    final filtered = AppData.items.where((i) => vm.category == 'all' || i.category == vm.category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, idx) {
                final c = categories[idx];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(loc.translate(c)),
                    selected: vm.category == c,
                    onSelected: (_) => vm.setCategory(c),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final item = filtered[idx];
                return InkWell(
                  onTap: () {
                    vm.playAudio(item);
                    vm.markCompleted(item.id);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.emoji, style: const TextStyle(fontSize: 48)),
                        const SizedBox(height: 6),
                        Text(isHindi ? item.hindi : item.english, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(isHindi ? item.english : item.hindi, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 6),
                        const Icon(Icons.volume_up, color: AppTheme.primaryColor),
                      ],
                    ),
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
      child: const HindiVocabNotebookApp(),
    ),
  );
}

class HindiVocabNotebookApp extends StatelessWidget {
  const HindiVocabNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Vocabulary Notebook',
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

  console.log('37_hindi_vocabulary_notebook complete!');
}

// ==========================================
// 38. HINDI WORD CARDS
// ==========================================
function buildApp38() {
  const appDir = '38_hindi_word_cards';
  const pkgName = 'app38_hindi_word_cards';
  const appTitle = 'Hindi Word Cards';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'flash_card.dart'), `
class FlashCard {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;
  const FlashCard(this.id, this.hindi, this.english, this.emoji, this.hindiAudio, this.englishAudio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/flash_card.dart';

class AppData {
  static const List<FlashCard> cards = [
    FlashCard('aam', 'आम', 'Mango', '🥭', 'assets/audio/hi/aam.mp3', 'assets/audio/en/aam.mp3'),
    FlashCard('seb', 'सेब', 'Apple', '🍎', 'assets/audio/hi/seb.mp3', 'assets/audio/en/seb.mp3'),
    FlashCard('ghar', 'घर', 'Home', '🏠', 'assets/audio/hi/ghar.mp3', 'assets/audio/en/ghar.mp3'),
    FlashCard('billi', 'बिल्ली', 'Cat', '🐱', 'assets/audio/hi/billi.mp3', 'assets/audio/en/billi.mp3'),
    FlashCard('kutta', 'कुत्ता', 'Dog', '🐶', 'assets/audio/hi/kutta.mp3', 'assets/audio/en/kutta.mp3'),
    FlashCard('paani', 'पानी', 'Water', '💧', 'assets/audio/hi/paani.mp3', 'assets/audio/en/paani.mp3'),
    FlashCard('doodh', 'दूध', 'Milk', '🥛', 'assets/audio/hi/doodh.mp3', 'assets/audio/en/doodh.mp3'),
    FlashCard('suraj', 'सूरज', 'Sun', '☀️', 'assets/audio/hi/suraj.mp3', 'assets/audio/en/suraj.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी शब्द कार्ड्स',
  'subtitle': 'फ्लैश कार्ड्स पलटें और शब्द सीखें',
  'start_learning': 'फ्लैश कार्ड्स',
  'practice': 'कार्ड अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'tap_to_flip': 'कार्ड पलटने के लिए छुएँ 👆',
  'completed_items': 'सीखे गए कार्ड्स',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': '3D फ्लिप कार्ड्स के साथ हिंदी शब्द सीखें 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Word Cards',
  'subtitle': 'Flip flashcards to reveal words',
  'start_learning': 'Flashcards',
  'practice': 'Practice Cards',
  'progress': 'Progress',
  'settings': 'Settings',
  'tap_to_flip': 'Tap to flip card 👆',
  'completed_items': 'Completed Cards',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline 3D flip flashcards for Hindi words.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6A1B9A); // Purple
  static const Color secondaryColor = Color(0xFFFFD600);
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
import '../models/flash_card.dart';
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

  Future<void> markCompleted(String id) async {
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(FlashCard card) async {
    if (!_soundEnabled) return;
    final path = _locale.languageCode == 'en' ? card.englishAudio : card.hindiAudio;
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
                    const Text('🃏', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '🎴', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
  bool _showBack = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final card = AppData.cards[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('\${_idx + 1} / \${AppData.cards.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _showBack = !_showBack);
                  vm.playAudio(card);
                  vm.markCompleted(card.id);
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_showBack),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppTheme.primaryColor.withAlpha(50), width: 3),
                      boxShadow: [BoxShadow(color: Colors.purple.withAlpha(30), blurRadius: 16, offset: const Offset(0, 8))],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(card.emoji, style: const TextStyle(fontSize: 90)),
                        const SizedBox(height: 20),
                        Text(_showBack ? card.english : card.hindi, style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: _showBack ? Colors.deepOrange : AppTheme.primaryColor)),
                        const SizedBox(height: 8),
                        Text(_showBack ? card.hindi : card.english, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                        const SizedBox(height: 24),
                        Text(loc.translate('tap_to_flip'), style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _idx > 0 ? () => setState(() { _idx--; _showBack = false; }) : null,
                  child: const Text('पिछला'),
                ),
                IconButton.filled(
                  onPressed: () => vm.playAudio(card),
                  icon: const Icon(Icons.volume_up, size: 30),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                ElevatedButton(
                  onPressed: _idx < AppData.cards.length - 1 ? () => setState(() { _idx++; _showBack = false; }) : null,
                  child: const Text('अगला'),
                ),
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
    final total = AppData.cards.length;
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
      child: const HindiWordCardsApp(),
    ),
  );
}

class HindiWordCardsApp extends StatelessWidget {
  const HindiWordCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Word Cards',
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

  console.log('38_hindi_word_cards complete!');
}

// ==========================================
// 39. HINDI PICTURE WORDS
// ==========================================
function buildApp39() {
  const appDir = '39_hindi_picture_words';
  const pkgName = 'app39_hindi_picture_words';
  const appTitle = 'Hindi Picture Words';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'picture_word.dart'), `
class PictureWord {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String audio;
  const PictureWord(this.id, this.hindi, this.english, this.emoji, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/picture_word.dart';

class AppData {
  static const List<PictureWord> items = [
    PictureWord('aam', 'आम', 'Mango', '🥭', 'assets/audio/hi/aam.mp3'),
    PictureWord('seb', 'सेब', 'Apple', '🍎', 'assets/audio/hi/seb.mp3'),
    PictureWord('kela', 'केला', 'Banana', '🍌', 'assets/audio/hi/kela.mp3'),
    PictureWord('haathi', 'हाथी', 'Elephant', '🐘', 'assets/audio/hi/haathi.mp3'),
    PictureWord('sher', 'शेर', 'Lion', '🦁', 'assets/audio/hi/sher.mp3'),
    PictureWord('gaay', 'गाय', 'Cow', '🐮', 'assets/audio/hi/gaay.mp3'),
    PictureWord('ghar', 'घर', 'Home', '🏠', 'assets/audio/hi/ghar.mp3'),
    PictureWord('kitaab', 'किताब', 'Book', '📚', 'assets/audio/hi/kitaab.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी चित्र शब्द',
  'subtitle': 'चित्र पहचानें और नाम जानें',
  'start_learning': 'चित्र देखो',
  'practice': 'पहचानो खेल',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'tap_to_reveal': 'नाम जानने के लिए चित्र छुएँ',
  'completed_items': 'पहचाने गए चित्र',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'चित्र देखकर हिंदी शब्द सीखने का ऐप 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Picture Words',
  'subtitle': 'Identify pictures and learn Hindi names',
  'start_learning': 'View Pictures',
  'practice': 'Guessing Game',
  'progress': 'Progress',
  'settings': 'Settings',
  'tap_to_reveal': 'Tap picture to reveal name',
  'completed_items': 'Identified Pictures',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline picture-first Hindi word learning for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00838F); // Dark Cyan
  static const Color secondaryColor = Color(0xFFFF8A65);
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

  Future<void> markCompleted(String id) async {
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
                    const Text('🖼️', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '🖼️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
  bool _revealed = false;

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
              child: GestureDetector(
                onTap: () {
                  setState(() => _revealed = true);
                  vm.playAudio(item.audio);
                  vm.markCompleted(item.id);
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 110)),
                      const SizedBox(height: 24),
                      if (_revealed) ...[
                        Text(item.hindi, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        Text(item.english, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20)),
                          child: Text(loc.translate('tap_to_reveal'), style: const TextStyle(fontSize: 16, color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _idx > 0 ? () => setState(() { _idx--; _revealed = false; }) : null,
                  child: const Text('पिछला'),
                ),
                IconButton.filled(
                  onPressed: () {
                    setState(() => _revealed = true);
                    vm.playAudio(item.audio);
                  },
                  icon: const Icon(Icons.volume_up, size: 30),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                ElevatedButton(
                  onPressed: _idx < AppData.items.length - 1 ? () => setState(() { _idx++; _revealed = false; }) : null,
                  child: const Text('अगला'),
                ),
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
      child: const HindiPictureWordsApp(),
    ),
  );
}

class HindiPictureWordsApp extends StatelessWidget {
  const HindiPictureWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Picture Words',
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

  console.log('39_hindi_picture_words complete!');
}

// ==========================================
// 40. HINDI AUDIO WORDS
// ==========================================
function buildApp40() {
  const appDir = '40_hindi_audio_words';
  const pkgName = 'app40_hindi_audio_words';
  const appTitle = 'Hindi Audio Words';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'audio_word_quiz.dart'), `
class AudioWordQuiz {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;
  const AudioWordQuiz(this.id, this.hindi, this.english, this.emoji, this.hindiAudio, this.englishAudio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/audio_word_quiz.dart';

class AppData {
  static const List<AudioWordQuiz> items = [
    AudioWordQuiz('aam', 'आम', 'Mango', '🥭', 'assets/audio/hi/aam.mp3', 'assets/audio/en/aam.mp3'),
    AudioWordQuiz('seb', 'सेब', 'Apple', '🍎', 'assets/audio/hi/seb.mp3', 'assets/audio/en/seb.mp3'),
    AudioWordQuiz('kutta', 'कुत्ता', 'Dog', '🐶', 'assets/audio/hi/kutta.mp3', 'assets/audio/en/kutta.mp3'),
    AudioWordQuiz('billi', 'बिल्ली', 'Cat', '🐱', 'assets/audio/hi/billi.mp3', 'assets/audio/en/billi.mp3'),
    AudioWordQuiz('ghar', 'घर', 'Home', '🏠', 'assets/audio/hi/ghar.mp3', 'assets/audio/en/ghar.mp3'),
    AudioWordQuiz('paani', 'पानी', 'Water', '💧', 'assets/audio/hi/paani.mp3', 'assets/audio/en/paani.mp3'),
    AudioWordQuiz('haathi', 'हाथी', 'Elephant', '🐘', 'assets/audio/hi/haathi.mp3', 'assets/audio/en/haathi.mp3'),
    AudioWordQuiz('suraj', 'सूरज', 'Sun', '☀️', 'assets/audio/hi/suraj.mp3', 'assets/audio/en/suraj.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी ध्वनि शब्द',
  'subtitle': 'आवाज़ सुनें और सही चित्र चुनें',
  'start_learning': 'सुनो और पहचानो',
  'practice': 'क्विज़',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'listen_prompt': 'आवाज़ सुनो और सही चित्र चुनो 🎧',
  'great_job': 'शाबाश! सही उत्तर! 🎉',
  'try_again': 'फिर कोशिश करो 😊',
  'next': 'अगला सवाल',
  'completed_items': 'सही पहचाने गए शब्द',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'आवाज़ पर आधारित हिंदी शब्द खेल 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Audio Words',
  'subtitle': 'Listen to voice and pick correct picture',
  'start_learning': 'Listen & Identify',
  'practice': 'Quiz',
  'progress': 'Progress',
  'settings': 'Settings',
  'listen_prompt': 'Listen to voice and choose the picture 🎧',
  'great_job': 'Great! Correct answer! 🎉',
  'try_again': 'Try Again 😊',
  'next': 'Next Question',
  'completed_items': 'Correct Identified Words',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline audio-first Hindi word game for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5E35B1); // Deep Violet
  static const Color secondaryColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFEDE7F6);

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
import '../models/audio_word_quiz.dart';
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

  Future<void> markCompleted(String id) async {
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 15;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(AudioWordQuiz item) async {
    if (!_soundEnabled) return;
    final path = _locale.languageCode == 'en' ? item.englishAudio : item.hindiAudio;
    await _audioService.playAudio(path);
  }

  Future<void> playFeedback(bool correct) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(correct ? 'assets/audio/hi/feedback_great.mp3' : 'assets/audio/hi/feedback_try.mp3');
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
                    const Text('🎧', style: TextStyle(fontSize: 50)),
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
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/audio_word_quiz.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late AudioWordQuiz _target;
  late List<AudioWordQuiz> _options;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<AudioWordQuiz>.from(AppData.items)..shuffle(_rnd);
    _target = list.first;
    _options = list.take(4).toList()..shuffle(_rnd);
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playAudio(_target);
    });
  }

  void _check(AudioWordQuiz choice) {
    if (_isCorrect == true) return;
    final correct = choice.id == _target.id;
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    vm.playFeedback(correct);
    if (correct) {
      vm.markCompleted(_target.id);
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
            Text(loc.translate('listen_prompt'), textAlign: TextAlign.center, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            IconButton.filled(
              onPressed: () => vm.playAudio(_target),
              icon: const Icon(Icons.volume_up, size: 54),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: _options.map((opt) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    onPressed: () => _check(opt),
                    child: Text(opt.emoji, style: const TextStyle(fontSize: 54)),
                  );
                }).toList(),
              ),
            ),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 10),
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
      child: const HindiAudioWordsApp(),
    ),
  );
}

class HindiAudioWordsApp extends StatelessWidget {
  const HindiAudioWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Audio Words',
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

  console.log('40_hindi_audio_words complete!');
}

async function run() {
  buildApp36();
  buildApp37();
  buildApp38();
  buildApp39();
  buildApp40();
  console.log('Group C (Apps 36-40) build finished.');
}

run();
