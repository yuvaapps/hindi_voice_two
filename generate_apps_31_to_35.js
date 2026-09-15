const path = require('path');
const { rootDir, writeFile, setupScaffolding } = require('./generate_app_common');

// ==========================================
// 31. HINDI NAME WRITING
// ==========================================
function buildApp31() {
  const appDir = '31_hindi_name_writing';
  const pkgName = 'app31_hindi_name_writing';
  const appTitle = 'Hindi Name Writing';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'name_item.dart'), `
class NameItem {
  final String id;
  final String hindi;
  final String english;
  final String meaning;
  final String hindiAudio;
  final String englishAudio;

  const NameItem({
    required this.id,
    required this.hindi,
    required this.english,
    required this.meaning,
    required this.hindiAudio,
    required this.englishAudio,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/name_item.dart';

class AppData {
  static const List<NameItem> names = [
    NameItem(id: 'amit', hindi: 'अमित', english: 'Amit', meaning: 'Infinite / Boundless', hindiAudio: 'assets/audio/hi/amit.mp3', englishAudio: 'assets/audio/en/amit.mp3'),
    NameItem(id: 'pooja', hindi: 'पूजा', english: 'Pooja', meaning: 'Worship / Prayer', hindiAudio: 'assets/audio/hi/pooja.mp3', englishAudio: 'assets/audio/en/pooja.mp3'),
    NameItem(id: 'rahul', hindi: 'राहुल', english: 'Rahul', meaning: 'Capable / Efficient', hindiAudio: 'assets/audio/hi/rahul.mp3', englishAudio: 'assets/audio/en/rahul.mp3'),
    NameItem(id: 'neha', hindi: 'नेहा', english: 'Neha', meaning: 'Love / Affection', hindiAudio: 'assets/audio/hi/neha.mp3', englishAudio: 'assets/audio/en/neha.mp3'),
    NameItem(id: 'rohan', hindi: 'रोहन', english: 'Rohan', meaning: 'Ascending / Blossom', hindiAudio: 'assets/audio/hi/rohan.mp3', englishAudio: 'assets/audio/en/rohan.mp3'),
    NameItem(id: 'riya', hindi: 'रिया', english: 'Riya', meaning: 'Graceful Singer', hindiAudio: 'assets/audio/hi/riya.mp3', englishAudio: 'assets/audio/en/riya.mp3'),
    NameItem(id: 'aman', hindi: 'अमन', english: 'Aman', meaning: 'Peace', hindiAudio: 'assets/audio/hi/aman.mp3', englishAudio: 'assets/audio/en/aman.mp3'),
    NameItem(id: 'ananya', hindi: 'अनन्या', english: 'Ananya', meaning: 'Unique / Matchless', hindiAudio: 'assets/audio/hi/ananya.mp3', englishAudio: 'assets/audio/en/ananya.mp3'),
    NameItem(id: 'kabir', hindi: 'कबीर', english: 'Kabir', meaning: 'Great / Famous', hindiAudio: 'assets/audio/hi/kabir.mp3', englishAudio: 'assets/audio/en/kabir.mp3'),
    NameItem(id: 'khushi', hindi: 'खुशी', english: 'Khushi', meaning: 'Happiness / Joy', hindiAudio: 'assets/audio/hi/khushi.mp3', englishAudio: 'assets/audio/en/khushi.mp3'),
    NameItem(id: 'aarav', hindi: 'आरव', english: 'Aarav', meaning: 'Peaceful Wisdom', hindiAudio: 'assets/audio/hi/aarav.mp3', englishAudio: 'assets/audio/en/aarav.mp3'),
    NameItem(id: 'tanvi', hindi: 'तन्वी', english: 'Tanvi', meaning: 'Delicate / Beautiful', hindiAudio: 'assets/audio/hi/tanvi.mp3', englishAudio: 'assets/audio/en/tanvi.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी नाम लेखन',
  'subtitle': 'सुंदर हिंदी नाम लिखना सीखें',
  'start_learning': 'नाम लिखना सीखें',
  'practice': 'नाम लेखन स्लेट',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'clear': 'साफ़ करें',
  'next': 'अगला नाम',
  'retry': 'दोबारा लिखें',
  'completed_items': 'लिखे गए नाम',
  'total_score': 'कुल अंक',
  'great_job': 'शानदार लिखावट! 🎉',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए हिंदी नाम लेखन अभ्यास 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Name Writing',
  'subtitle': 'Learn to write beautiful Hindi names',
  'start_learning': 'Learn Writing Names',
  'practice': 'Name Writing Slate',
  'progress': 'Progress',
  'settings': 'Settings',
  'clear': 'Clear',
  'next': 'Next Name',
  'retry': 'Retry',
  'completed_items': 'Completed Names',
  'total_score': 'Total Score',
  'great_job': 'Great Handwriting! 🎉',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi name writing practice for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00ACC1); // Vibrant Cyan
  static const Color secondaryColor = Color(0xFFFF7043); // Coral
  static const Color scaffoldBg = Color(0xFFE0F7FA);
  static const Color textColor = Color(0xFF006064);

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
import '../models/name_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String? _currentPlayingId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String? get currentPlayingId => _currentPlayingId;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(() {
      if (!_audioService.isPlaying) _currentPlayingId = null;
      notifyListeners();
    });
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

  Future<void> playNameAudio(NameItem name) async {
    if (!_soundEnabled) return;
    _currentPlayingId = name.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? name.englishAudio : name.hindiAudio;
    await _audioService.playAudio(audio);
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
import 'practice_screen.dart';
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
                    const Text('✍️', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📛', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '📝', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
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
import 'practice_screen.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppData.names.length,
        itemBuilder: (context, idx) {
          final item = AppData.names[idx];
          final isPlaying = vm.currentPlayingId == item.id;
          final isDone = vm.completedIds.contains(item.id);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(item.hindi, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              subtitle: Text('\${item.english} • \${item.meaning}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_down, color: AppTheme.primaryColor, size: 28),
                    onPressed: () {
                      vm.playNameAudio(item);
                      vm.markCompleted(item.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => PracticeScreen(initialIndex: idx)));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'practice_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  final int initialIndex;
  const PracticeScreen({super.key, this.initialIndex = 0});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late int _idx;
  final List<Offset?> _strokes = [];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final name = AppData.names[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.hindi, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppTheme.textColor)),
                    Text(name.english, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                IconButton.filled(
                  onPressed: () => vm.playNameAudio(name),
                  icon: const Icon(Icons.volume_up, size: 28),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                ),
                OutlinedButton(
                  onPressed: () => setState(() => _strokes.clear()),
                  child: Text(loc.translate('clear')),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyan.shade200, width: 3),
                ),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() => _strokes.add(details.localPosition));
                  },
                  onPanEnd: (_) => _strokes.add(null),
                  child: CustomPaint(
                    painter: _NameTracePainter(_strokes, name.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(name.id);
                setState(() {
                  _strokes.clear();
                  _idx = (_idx + 1) % AppData.names.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameTracePainter extends CustomPainter {
  final List<Offset?> strokes;
  final String text;
  _NameTracePainter(this.strokes, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    // Dotted guide
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 70, color: Colors.cyan.shade100, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));

    final paint = Paint()
      ..color = Colors.cyan.shade800
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7.0;

    for (int i = 0; i < strokes.length - 1; i++) {
      if (strokes[i] != null && strokes[i + 1] != null) {
        canvas.drawLine(strokes[i]!, strokes[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.names.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
      child: const HindiNameWritingApp(),
    ),
  );
}

class HindiNameWritingApp extends StatelessWidget {
  const HindiNameWritingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Name Writing',
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

  console.log('31_hindi_name_writing complete!');
}

// ==========================================
// 32. HINDI WORD TRACING
// ==========================================
function buildApp32() {
  const appDir = '32_hindi_word_tracing';
  const pkgName = 'app32_hindi_word_tracing';
  const appTitle = 'Hindi Word Tracing';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'tracing_word.dart'), `
class TracingWord {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;

  const TracingWord({
    required this.id,
    required this.hindi,
    required this.english,
    required this.emoji,
    required this.hindiAudio,
    required this.englishAudio,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/tracing_word.dart';

class AppData {
  static const List<TracingWord> words = [
    TracingWord(id: 'kamal', hindi: 'कमल', english: 'Lotus', emoji: '🪷', hindiAudio: 'assets/audio/hi/kamal.mp3', englishAudio: 'assets/audio/en/kamal.mp3'),
    TracingWord(id: 'ghar', hindi: 'घर', english: 'Home', emoji: '🏠', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    TracingWord(id: 'aam', hindi: 'आम', english: 'Mango', emoji: '🥭', hindiAudio: 'assets/audio/hi/aam.mp3', englishAudio: 'assets/audio/en/aam.mp3'),
    TracingWord(id: 'seb', hindi: 'सेब', english: 'Apple', emoji: '🍎', hindiAudio: 'assets/audio/hi/seb.mp3', englishAudio: 'assets/audio/en/seb.mp3'),
    TracingWord(id: 'jal', hindi: 'जल', english: 'Water', emoji: '💧', hindiAudio: 'assets/audio/hi/jal.mp3', englishAudio: 'assets/audio/en/jal.mp3'),
    TracingWord(id: 'matar', hindi: 'मटर', english: 'Peas', emoji: '🫛', hindiAudio: 'assets/audio/hi/matar.mp3', englishAudio: 'assets/audio/en/matar.mp3'),
    TracingWord(id: 'sadak', hindi: 'सड़क', english: 'Road', emoji: '🛣️', hindiAudio: 'assets/audio/hi/sadak.mp3', englishAudio: 'assets/audio/en/sadak.mp3'),
    TracingWord(id: 'ped', hindi: 'पेड़', english: 'Tree', emoji: '🌳', hindiAudio: 'assets/audio/hi/ped.mp3', englishAudio: 'assets/audio/en/ped.mp3'),
    TracingWord(id: 'phool', hindi: 'फूल', english: 'Flower', emoji: '🌸', hindiAudio: 'assets/audio/hi/phool.mp3', englishAudio: 'assets/audio/en/phool.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी शब्द ट्रेसिंग',
  'subtitle': 'अंगुली से शब्द ट्रेस करना सीखें',
  'start_learning': 'ट्रेसिंग सूची',
  'practice': 'ट्रेस करें',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'clear': 'साफ़ करें',
  'next': 'अगला',
  'completed_items': 'ट्रेस किए गए शब्द',
  'great_job': 'बहुत बढ़िया ट्रेस किया! 🌟',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए हिंदी शब्द ट्रेसिंग 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Word Tracing',
  'subtitle': 'Learn to trace Hindi words with fingers',
  'start_learning': 'Word List',
  'practice': 'Trace Word',
  'progress': 'Progress',
  'settings': 'Settings',
  'clear': 'Clear',
  'next': 'Next',
  'completed_items': 'Traced Words',
  'great_job': 'Great Tracing! 🌟',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi word tracing for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF3F51B5); // Indigo
  static const Color secondaryColor = Color(0xFFFF4081);
  static const Color scaffoldBg = Color(0xFFF3F4FB);
  static const Color textColor = Color(0xFF1A237E);

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
import '../models/tracing_word.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String? _currentPlayingId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String? get currentPlayingId => _currentPlayingId;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(() {
      if (!_audioService.isPlaying) _currentPlayingId = null;
      notifyListeners();
    });
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

  Future<void> playWordAudio(TracingWord word) async {
    if (!_soundEnabled) return;
    _currentPlayingId = word.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? word.englishAudio : word.hindiAudio;
    await _audioService.playAudio(audio);
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
import 'practice_screen.dart';
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
                    const Text('🖍️', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📋', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '✏️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
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
import 'practice_screen.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppData.words.length,
        itemBuilder: (context, idx) {
          final item = AppData.words[idx];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Text(item.emoji, style: const TextStyle(fontSize: 32)),
              title: Text(item.hindi, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              subtitle: Text(item.english),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PracticeScreen(initialIndex: idx)));
                },
                child: const Text('ट्रेस करें'),
              ),
            ),
          );
        },
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'practice_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  final int initialIndex;
  const PracticeScreen({super.key, this.initialIndex = 0});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late int _idx;
  final List<Offset?> _points = [];

  @override
  void initState() {
    super.initState();
    _idx = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(word.emoji, style: const TextStyle(fontSize: 40)),
                Text(word.hindi, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playWordAudio(word)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: Text(loc.translate('clear'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.shade200, width: 3),
                ),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _WordTracePainter(_points, word.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(word.id);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.words.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next')),
            ),
          ],
        ),
      ),
    );
  }
}

class _WordTracePainter extends CustomPainter {
  final List<Offset?> points;
  final String word;
  _WordTracePainter(this.points, this.word);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: word, style: TextStyle(fontSize: 84, color: Colors.indigo.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()
      ..color = Colors.indigo
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.words.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
      child: const HindiWordTracingApp(),
    ),
  );
}

class HindiWordTracingApp extends StatelessWidget {
  const HindiWordTracingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Word Tracing',
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

  console.log('32_hindi_word_tracing complete!');
}

// ==========================================
// 33. HINDI ALPHABET NOTEBOOK
// ==========================================
function buildApp33() {
  const appDir = '33_hindi_alphabet_notebook';
  const pkgName = 'app33_hindi_alphabet_notebook';
  const appTitle = 'Hindi Alphabet Notebook';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'alphabet_item.dart'), `
class AlphabetItem {
  final String letter;
  final String word;
  final String englishWord;
  final String emoji;
  final String letterAudio;
  final String wordAudio;

  const AlphabetItem({
    required this.letter,
    required this.word,
    required this.englishWord,
    required this.emoji,
    required this.letterAudio,
    required this.wordAudio,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/alphabet_item.dart';

class AppData {
  static const List<AlphabetItem> letters = [
    AlphabetItem(letter: 'अ', word: 'अनार', englishWord: 'Pomegranate', emoji: '🍎', letterAudio: 'assets/audio/hi/a_letter.mp3', wordAudio: 'assets/audio/hi/anaar.mp3'),
    AlphabetItem(letter: 'आ', word: 'आम', englishWord: 'Mango', emoji: '🥭', letterAudio: 'assets/audio/hi/aa_letter.mp3', wordAudio: 'assets/audio/hi/aam.mp3'),
    AlphabetItem(letter: 'क', word: 'कमल', englishWord: 'Lotus', emoji: '🪷', letterAudio: 'assets/audio/hi/k_letter.mp3', wordAudio: 'assets/audio/hi/kamal.mp3'),
    AlphabetItem(letter: 'ख', word: 'खरगोश', englishWord: 'Rabbit', emoji: '🐰', letterAudio: 'assets/audio/hi/kh_letter.mp3', wordAudio: 'assets/audio/hi/khargosh.mp3'),
    AlphabetItem(letter: 'ग', word: 'गाय', englishWord: 'Cow', emoji: '🐮', letterAudio: 'assets/audio/hi/g_letter.mp3', wordAudio: 'assets/audio/hi/gaay.mp3'),
    AlphabetItem(letter: 'घ', word: 'घर', englishWord: 'Home', emoji: '🏠', letterAudio: 'assets/audio/hi/gh_letter.mp3', wordAudio: 'assets/audio/hi/ghar.mp3'),
    AlphabetItem(letter: 'च', word: 'चम्मच', englishWord: 'Spoon', emoji: '🥄', letterAudio: 'assets/audio/hi/ch_letter.mp3', wordAudio: 'assets/audio/hi/chammach.mp3'),
    AlphabetItem(letter: 'छ', word: 'छतरी', englishWord: 'Umbrella', emoji: '☂️', letterAudio: 'assets/audio/hi/chh_letter.mp3', wordAudio: 'assets/audio/hi/chhatri.mp3'),
    AlphabetItem(letter: 'ज', word: 'जल', englishWord: 'Water', emoji: '💧', letterAudio: 'assets/audio/hi/j_letter.mp3', wordAudio: 'assets/audio/hi/jal.mp3'),
    AlphabetItem(letter: 'प', word: 'पेड़', englishWord: 'Tree', emoji: '🌳', letterAudio: 'assets/audio/hi/pa_letter.mp3', wordAudio: 'assets/audio/hi/ped.mp3'),
    AlphabetItem(letter: 'फ', word: 'फल', englishWord: 'Fruit', emoji: '🍉', letterAudio: 'assets/audio/hi/pha_letter.mp3', wordAudio: 'assets/audio/hi/phal.mp3'),
    AlphabetItem(letter: 'ब', word: 'बिल्ली', englishWord: 'Cat', emoji: '🐱', letterAudio: 'assets/audio/hi/ba_letter.mp3', wordAudio: 'assets/audio/hi/billi.mp3'),
    AlphabetItem(letter: 'म', word: 'मछली', englishWord: 'Fish', emoji: '🐟', letterAudio: 'assets/audio/hi/ma_letter.mp3', wordAudio: 'assets/audio/hi/machhli.mp3'),
    AlphabetItem(letter: 'ह', word: 'हाथी', englishWord: 'Elephant', emoji: '🐘', letterAudio: 'assets/audio/hi/ha_letter.mp3', wordAudio: 'assets/audio/hi/haathi.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी वर्णमाला नोटबुक',
  'subtitle': 'अ से ज्ञ तक वर्णमाला नोटबुक',
  'start_learning': 'वर्णमाला सीखें',
  'practice': 'वर्ण अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'page': 'पृष्ठ',
  'completed_items': 'सीखे गए अक्षर',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'हिंदी वर्णमाला नोटबुक बच्चों के लिए 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Alphabet Notebook',
  'subtitle': 'Hindi Alphabet Varnamala Notebook',
  'start_learning': 'Learn Alphabet',
  'practice': 'Letter Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'page': 'Page',
  'completed_items': 'Learned Letters',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi Alphabet Varnamala Notebook for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFE65100); // Deep Orange
  static const Color secondaryColor = Color(0xFF2E7D32);
  static const Color scaffoldBg = Color(0xFFFFF8E1);
  static const Color textColor = Color(0xFF3E2723);

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
import '../models/alphabet_item.dart';
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

  Future<void> markCompleted(String letter) async {
    if (!_completedIds.contains(letter)) {
      _completedIds.add(letter);
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
import 'practice_screen.dart';
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
                    const Text('🔤', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📓', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '✍️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
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
    final item = AppData.letters[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('\${loc.translate('page')} \${_idx + 1} / \${AppData.letters.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.orange.shade200, width: 2)),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.letter, style: const TextStyle(fontSize: 84, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              const SizedBox(height: 10),
              Text(item.emoji, style: const TextStyle(fontSize: 60)),
              const SizedBox(height: 10),
              Text('\${item.letter} से \${item.word}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Text(item.englishWord, style: const TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => vm.playAudio(item.letterAudio),
                    icon: const Icon(Icons.volume_up),
                    label: Text('अक्षर: \${item.letter}'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      vm.playAudio(item.wordAudio);
                      vm.markCompleted(item.letter);
                    },
                    icon: const Icon(Icons.volume_up),
                    label: Text('शब्द: \${item.word}'),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: _idx > 0 ? () => setState(() => _idx--) : null, child: const Text('पिछला')),
                  ElevatedButton(onPressed: _idx < AppData.letters.length - 1 ? () => setState(() => _idx++) : null, child: const Text('अगला')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'practice_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int _idx = 0;
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final item = AppData.letters[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.letter, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.letterAudio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: const Text('साफ़ करें')),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(painter: _LetterPainter(_points, item.letter), size: Size.infinite),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.letter);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.letters.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला अक्षर'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterPainter extends CustomPainter {
  final List<Offset?> points;
  final String letter;
  _LetterPainter(this.points, this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: letter, style: TextStyle(fontSize: 160, color: Colors.orange.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.deepOrange..strokeCap = StrokeCap.round..strokeWidth = 10.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.letters.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
      child: const HindiAlphabetNotebookApp(),
    ),
  );
}

class HindiAlphabetNotebookApp extends StatelessWidget {
  const HindiAlphabetNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Alphabet Notebook',
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

  console.log('33_hindi_alphabet_notebook complete!');
}

// ==========================================
// 34. HINDI WRITING PAD
// ==========================================
function buildApp34() {
  const appDir = '34_hindi_writing_pad';
  const pkgName = 'app34_hindi_writing_pad';
  const appTitle = 'Hindi Writing Pad';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'prompt_item.dart'), `
class PromptItem {
  final String text;
  final String audio;
  const PromptItem(this.text, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/prompt_item.dart';

class AppData {
  static const List<PromptItem> prompts = [
    PromptItem('अ', 'assets/audio/hi/a_letter.mp3'),
    PromptItem('आ', 'assets/audio/hi/aa_letter.mp3'),
    PromptItem('क', 'assets/audio/hi/k_letter.mp3'),
    PromptItem('ख', 'assets/audio/hi/kh_letter.mp3'),
    PromptItem('ग', 'assets/audio/hi/g_letter.mp3'),
    PromptItem('घर', 'assets/audio/hi/ghar.mp3'),
    PromptItem('जल', 'assets/audio/hi/jal.mp3'),
    PromptItem('फल', 'assets/audio/hi/phal.mp3'),
    PromptItem('कमल', 'assets/audio/hi/kamal.mp3'),
    PromptItem('आम', 'assets/audio/hi/aam.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी लेखन पैड',
  'subtitle': 'रंगीन स्लेट पर मनचाहा लिखें',
  'start_learning': 'स्लेट खोलें',
  'practice': 'मुक्त लेखन',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'clear': 'साफ़ करें',
  'undo': 'वापस',
  'completed_items': 'लिखे गए शब्द',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए हिंदी लेखन पैड और स्लेट 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Writing Pad',
  'subtitle': 'Freehand colorful Hindi writing slate',
  'start_learning': 'Open Slate',
  'practice': 'Free Writing',
  'progress': 'Progress',
  'settings': 'Settings',
  'clear': 'Clear',
  'undo': 'Undo',
  'completed_items': 'Practiced Items',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline freehand Hindi writing pad for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF37474F); // Chalkboard Slate Dark
  static const Color accentColor = Color(0xFFFFEB3B); // Yellow Chalk
  static const Color scaffoldBg = Color(0xFF263238);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(primary: primaryColor, secondary: accentColor),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(ThemeData.dark().textTheme),
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
`);

  writeFile(path.join(appPath, 'lib', 'views', 'learning_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final List<Offset?> _points = [];
  Color _penColor = Colors.white;
  double _strokeWidth = 6.0;
  int _selectedPromptIdx = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final prompt = AppData.prompts[_selectedPromptIdx];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('app_title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () => vm.playAudio(prompt.audio),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => _points.clear()),
          ),
        ],
      ),
      body: Column(
        children: [
          // Prompt horizontal bar
          Container(
            height: 52,
            color: Colors.black26,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppData.prompts.length,
              itemBuilder: (context, idx) {
                final isSel = idx == _selectedPromptIdx;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: ChoiceChip(
                    label: Text(AppData.prompts[idx].text, style: const TextStyle(fontSize: 18)),
                    selected: isSel,
                    onSelected: (_) {
                      setState(() {
                        _selectedPromptIdx = idx;
                        _points.clear();
                      });
                      vm.playAudio(AppData.prompts[idx].audio);
                      vm.markCompleted(AppData.prompts[idx].text);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1B262C),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24, width: 3),
              ),
              child: GestureDetector(
                onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                onPanEnd: (_) => _points.add(null),
                child: CustomPaint(
                  painter: _ChalkPainter(_points, _penColor, _strokeWidth, prompt.text),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          // Chalk controls
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorDot(Colors.white),
                _colorDot(Colors.yellow),
                _colorDot(Colors.cyan),
                _colorDot(Colors.pinkAccent),
                _colorDot(Colors.limeAccent),
                IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: () {
                    if (_points.isNotEmpty) {
                      setState(() {
                        _points.removeLast();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color c) {
    final isSel = _penColor == c;
    return GestureDetector(
      onTap: () => setState(() => _penColor = c),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: Border.all(color: isSel ? Colors.blue : Colors.transparent, width: 3),
        ),
      ),
    );
  }
}

class _ChalkPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double width;
  final String watermark;
  _ChalkPainter(this.points, this.color, this.width, this.watermark);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: watermark, style: TextStyle(fontSize: 120, color: Colors.white.withAlpha(20), fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = color..strokeCap = StrokeCap.round..strokeWidth = width;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
    final total = AppData.prompts.length;
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
      child: const HindiWritingPadApp(),
    ),
  );
}

class HindiWritingPadApp extends StatelessWidget {
  const HindiWritingPadApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Writing Pad',
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

  console.log('34_hindi_writing_pad complete!');
}

// ==========================================
// 35. HINDI PRACTICE BOOK
// ==========================================
function buildApp35() {
  const appDir = '35_hindi_practice_book';
  const pkgName = 'app35_hindi_practice_book';
  const appTitle = 'Hindi Practice Book';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'practice_item.dart'), `
class PracticeItem {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String audio;
  const PracticeItem(this.id, this.hindi, this.english, this.emoji, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/practice_item.dart';

class AppData {
  static const List<PracticeItem> items = [
    PracticeItem('aam', 'आम', 'Mango', '🥭', 'assets/audio/hi/aam.mp3'),
    PracticeItem('ghar', 'घर', 'Home', '🏠', 'assets/audio/hi/ghar.mp3'),
    PracticeItem('kamal', 'कमल', 'Lotus', '🪷', 'assets/audio/hi/kamal.mp3'),
    PracticeItem('jal', 'जल', 'Water', '💧', 'assets/audio/hi/jal.mp3'),
    PracticeItem('seb', 'सेब', 'Apple', '🍎', 'assets/audio/hi/seb.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अभ्यास पुस्तिका',
  'subtitle': 'ट्रेस, लिखें, मिलाएँ और पढ़ें वर्कबुक',
  'start_learning': 'कार्यपुस्तिका खोलें',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'completed_items': 'पूर्ण अभ्यास',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': '100% ऑफ़लाइन हिंदी अभ्यास पुस्तिका बच्चों के लिए।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Practice Book',
  'subtitle': 'Trace, write, match and read workbook',
  'start_learning': 'Open Workbook',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'completed_items': 'Completed Exercises',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi workbook for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFD81B60); // Berry
  static const Color secondaryColor = Color(0xFF8E24AA);
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

  Future<void> markCompleted(String id) async {
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
                    const Text('📕', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '✏️', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _idx = 0;
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final item = AppData.items[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('अभ्यास \${_idx + 1} / \${AppData.items.length}'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.emoji, style: const TextStyle(fontSize: 44)),
                Text(item.hindi, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.audio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: const Text('साफ़ करें')),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(painter: _WorkbookPainter(_points, item.hindi), size: Size.infinite),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.id);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.items.length;
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: const Text('अगला अभ्यास'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkbookPainter extends CustomPainter {
  final List<Offset?> points;
  final String word;
  _WorkbookPainter(this.points, this.word);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: word, style: TextStyle(fontSize: 90, color: Colors.pink.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.pink.shade700..strokeCap = StrokeCap.round..strokeWidth = 8.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) canvas.drawLine(points[i]!, points[i + 1]!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
`);

  writeFile(path.join(appPath, 'lib', 'views', 'progress_screen.dart'), `
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../utils/app_theme.dart';
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
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('settings')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
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
      child: const HindiPracticeBookApp(),
    ),
  );
}

class HindiPracticeBookApp extends StatelessWidget {
  const HindiPracticeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Practice Book',
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

  console.log('35_hindi_practice_book complete!');
}

async function run() {
  buildApp31();
  buildApp32();
  buildApp33();
  buildApp34();
  buildApp35();
  console.log('Group B (Apps 31-35) build finished.');
}

run();
