const path = require('path');
const { rootDir, writeFile, setupScaffolding } = require('./generate_app_common');

const hindiDigits = ['', '१', '२', '३', '४', '५', '६', '७', '८', '९', '१०'];
const hindiNames10 = ['', 'एक', 'दो', 'तीन', 'चार', 'पाँच', 'छह', 'सात', 'आठ', 'नौ', 'दस'];
const englishNames10 = ['', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
const audioKeys10 = ['', 'ek', 'do', 'teen', 'chaar', 'paanch', 'chhah', 'saat', 'aath', 'nau', 'das'];

// ==========================================
// 41. HINDI NUMBERS 1-10
// ==========================================
function buildApp41() {
  const appDir = '41_hindi_numbers_1_10';
  const pkgName = 'app41_hindi_numbers_1_10';
  const appTitle = 'Hindi Numbers 1-10';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'number_item.dart'), `
class NumberItem {
  final int value;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String hindiAudio;
  final String englishAudio;
  final String objectEmoji;

  const NumberItem({
    required this.value,
    required this.devanagari,
    required this.hindiName,
    required this.englishName,
    required this.hindiAudio,
    required this.englishAudio,
    required this.objectEmoji,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/number_item.dart';

class AppData {
  static const List<NumberItem> numbers = [
    NumberItem(value: 1, devanagari: '१', hindiName: 'एक', englishName: 'One', hindiAudio: 'assets/audio/hi/ek.mp3', englishAudio: 'assets/audio/en/ek.mp3', objectEmoji: '🍎'),
    NumberItem(value: 2, devanagari: '२', hindiName: 'दो', englishName: 'Two', hindiAudio: 'assets/audio/hi/do.mp3', englishAudio: 'assets/audio/en/do.mp3', objectEmoji: '🍌'),
    NumberItem(value: 3, devanagari: '३', hindiName: 'तीन', englishName: 'Three', hindiAudio: 'assets/audio/hi/teen.mp3', englishAudio: 'assets/audio/en/teen.mp3', objectEmoji: '🥭'),
    NumberItem(value: 4, devanagari: '४', hindiName: 'चार', englishName: 'Four', hindiAudio: 'assets/audio/hi/chaar.mp3', englishAudio: 'assets/audio/en/chaar.mp3', objectEmoji: '🚗'),
    NumberItem(value: 5, devanagari: '५', hindiName: 'पाँच', englishName: 'Five', hindiAudio: 'assets/audio/hi/paanch.mp3', englishAudio: 'assets/audio/en/paanch.mp3', objectEmoji: '⭐️'),
    NumberItem(value: 6, devanagari: '६', hindiName: 'छह', englishName: 'Six', hindiAudio: 'assets/audio/hi/chhah.mp3', englishAudio: 'assets/audio/en/chhah.mp3', objectEmoji: '🌸'),
    NumberItem(value: 7, devanagari: '७', hindiName: 'सात', englishName: 'Seven', hindiAudio: 'assets/audio/hi/saat.mp3', englishAudio: 'assets/audio/en/saat.mp3', objectEmoji: '🎈'),
    NumberItem(value: 8, devanagari: '८', hindiName: 'आठ', englishName: 'Eight', hindiAudio: 'assets/audio/hi/aath.mp3', englishAudio: 'assets/audio/en/aath.mp3', objectEmoji: '🍦'),
    NumberItem(value: 9, devanagari: '९', hindiName: 'नौ', englishName: 'Nine', hindiAudio: 'assets/audio/hi/nau.mp3', englishAudio: 'assets/audio/en/nau.mp3', objectEmoji: '⚽'),
    NumberItem(value: 10, devanagari: '१०', hindiName: 'दस', englishName: 'Ten', hindiAudio: 'assets/audio/hi/das.mp3', englishAudio: 'assets/audio/en/das.mp3', objectEmoji: '🐶'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी गिनती १-१०',
  'subtitle': '१ से १० तक हिंदी गिनती सीखें',
  'start_learning': 'गिनती सीखें',
  'practice': 'गिनती अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'completed_items': 'सीखी गई संख्याएँ',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए हिंदी संख्या १ से १० 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Numbers 1-10',
  'subtitle': 'Learn Hindi Counting 1 to 10',
  'start_learning': 'Learn Numbers',
  'practice': 'Counting Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'completed_items': 'Learned Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi numbers 1 to 10 for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0288D1); // Vivid Light Blue
  static const Color secondaryColor = Color(0xFFFFB300);
  static const Color scaffoldBg = Color(0xFFE1F5FE);

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
import '../models/number_item.dart';
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

  Future<void> playAudio(NumberItem num) async {
    if (!_soundEnabled) return;
    final path = _locale.languageCode == 'en' ? num.englishAudio : num.hindiAudio;
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
                    const Text('🔢', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '१', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
    final num = AppData.numbers[_idx];
    final isHindi = vm.locale.languageCode == 'hi';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(num.devanagari, style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                        const SizedBox(width: 24),
                        Text('\${num.value}', style: const TextStyle(fontSize: 50, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(isHindi ? num.hindiName : num.englishName, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    Text(isHindi ? num.englishName : num.hindiName, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                    const SizedBox(height: 20),
                    // Counters
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(num.value, (_) => Text(num.objectEmoji, style: const TextStyle(fontSize: 36))),
                    ),
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
                    vm.playAudio(num);
                    vm.markCompleted('\${num.value}');
                  },
                  icon: const Icon(Icons.volume_up, size: 32),
                  style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
                ),
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
      child: const HindiNumbers1to10App(),
    ),
  );
}

class HindiNumbers1to10App extends StatelessWidget {
  const HindiNumbers1to10App({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Numbers 1-10',
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

  console.log('41_hindi_numbers_1_10 complete!');
}

// ==========================================
// 42. HINDI NUMBERS 1-100
// ==========================================
function buildApp42() {
  const appDir = '42_hindi_numbers_1_100';
  const pkgName = 'app42_hindi_numbers_1_100';
  const appTitle = 'Hindi Numbers 1-100';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'num100_item.dart'), `
class Num100Item {
  final int number;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String audioKey;
  const Num100Item(this.number, this.devanagari, this.hindiName, this.englishName, this.audioKey);
}
`);

  // Generate 1-100 data
  const hindiNumberWords = [
    "", "एक", "दो", "तीन", "चार", "पाँच", "छह", "सात", "आठ", "नौ", "दस",
    "ग्यारह", "बारह", "तेरह", "चौदह", "पंद्रह", "सोलह", "सत्रह", "अठारह", "उन्नीस", "बीस",
    "इक्कीस", "बाईस", "तेईस", "चौबीस", "पच्चीस", "छब्बीस", "सत्ताईस", "अट्ठाईस", "उनतीस", "तीस",
    "इकत्तीस", "बत्तीस", "तैंतीस", "चौंतीस", "पैंतीस", "छत्तीस", "सैंतीस", "अड़तीस", "उनतालीस", "चालीस",
    "इकतालीस", "बयालीस", "तैंतालीस", "चवालीस", "पैंतालीस", "छियालीस", "सैंतालीस", "अड़तालीस", "उनचास", "पचास",
    "इक्यावन", "बावन", "तिरेपन", "चौवन", "पचपन", "छप्पन", "सत्तावन", "अट्ठावन", "उनसठ", "साठ",
    "इकसठ", "बासठ", "तिरसठ", "चौंसठ", "पैंसठ", "छियासठ", "सरसठ", "अड़सठ", "उनहत्तर", "सत्तर",
    "इकहत्तर", "बहत्तर", "तिहत्तर", "चौहत्तर", "पचहत्तर", "छिहत्तर", "सतहत्तर", "अठहत्तर", "उन्यासी", "अस्सी",
    "इक्यासी", "बयासी", "तिरासी", "चौरासी", "पचासी", "छियासी", "सत्तासी", "अट्ठासी", "नवासी", "नब्बे",
    "इक्यानवे", "बानवे", "तिरानवे", "चौरानवे", "पंचानवे", "छियानवे", "सत्तानवे", "अट्ठानवे", "निन्यानवे", "सौ"
  ];
  const englishNumberWords = [
    "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
    "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty",
    "Twenty-one", "Twenty-two", "Twenty-three", "Twenty-four", "Twenty-five", "Twenty-six", "Twenty-seven", "Twenty-eight", "Twenty-nine", "Thirty",
    "Thirty-one", "Thirty-two", "Thirty-three", "Thirty-four", "Thirty-five", "Thirty-six", "Thirty-seven", "Thirty-eight", "Thirty-nine", "Forty",
    "Forty-one", "Forty-two", "Forty-three", "Forty-four", "Forty-five", "Forty-six", "Forty-seven", "Forty-eight", "Forty-nine", "Fifty",
    "Fifty-one", "Fifty-two", "Fifty-three", "Fifty-four", "Fifty-five", "Fifty-six", "Fifty-seven", "Fifty-eight", "Fifty-nine", "Sixty",
    "Sixty-one", "Sixty-two", "Sixty-three", "Sixty-four", "Sixty-five", "Sixty-six", "Sixty-seven", "Sixty-eight", "Sixty-nine", "Seventy",
    "Seventy-one", "Seventy-two", "Seventy-three", "Seventy-four", "Seventy-five", "Seventy-six", "Seventy-seven", "Seventy-eight", "Seventy-nine", "Eighty",
    "Eighty-one", "Eighty-two", "Eighty-three", "Eighty-four", "Eighty-five", "Eighty-six", "Eighty-seven", "Eighty-eight", "Eighty-nine", "Ninety",
    "Ninety-one", "Ninety-two", "Ninety-three", "Ninety-four", "Ninety-five", "Ninety-six", "Ninety-seven", "Ninety-eight", "Ninety-nine", "One Hundred"
  ];
  const devDigitsMap = {'0':'०','1':'१','2':'२','3':'३','4':'४','5':'५','6':'६','7':'७','8':'८','9':'९'};
  function toDev(n) { return n.toString().split('').map(d => devDigitsMap[d]).join(''); }

  let itemsStr = '';
  for (let i = 1; i <= 100; i++) {
    const aKey = i <= 10 ? audioKeys10[i] : `num_${i}`;
    itemsStr += `    Num100Item(${i}, '${toDev(i)}', '${hindiNumberWords[i]}', '${englishNumberWords[i]}', '${aKey}'),\n`;
  }

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/num100_item.dart';

class AppData {
  static const List<Num100Item> numbers = [
${itemsStr}  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी गिनती १-१००',
  'subtitle': '१ से १०० तक संपूर्ण गिनती तालिका',
  'start_learning': '१-१०० ग्रिड',
  'practice': 'गिनती खोजें',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'search_hint': 'संख्या या नाम खोजें...',
  'completed_items': 'सीखी गई संख्याएँ',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'संपूर्ण १ से १०० हिंदी संख्या चार्ट बच्चों के लिए 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Numbers 1-100',
  'subtitle': 'Complete 1 to 100 Hindi numbers grid',
  'start_learning': '1-100 Grid',
  'practice': 'Search Number',
  'progress': 'Progress',
  'settings': 'Settings',
  'search_hint': 'Search number or name...',
  'completed_items': 'Learned Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline 1 to 100 Hindi numbers matrix for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2E7D32); // Emerald Forest
  static const Color secondaryColor = Color(0xFFFF6F00);
  static const Color scaffoldBg = Color(0xFFE8F5E9);

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
import '../models/num100_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String _searchQuery = '';

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String get searchQuery => _searchQuery;

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

  void setSearch(String q) {
    _searchQuery = q;
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

  Future<void> markCompleted(int num) async {
    final id = '$num';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 5;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(Num100Item item) async {
    if (!_soundEnabled) return;
    final path = _locale.languageCode == 'en' ? 'assets/audio/en/\${item.audioKey}.mp3' : 'assets/audio/hi/\${item.audioKey}.mp3';
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
                    const Text('💯', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '💯', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
import '../models/num100_item.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.numbers.where((n) {
      final q = vm.searchQuery.toLowerCase().trim();
      if (q.isEmpty) return true;
      return '\${n.number}'.contains(q) || n.devanagari.contains(q) || n.hindiName.contains(q) || n.englishName.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('app_title')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: vm.setSearch,
              decoration: InputDecoration(
                hintText: loc.translate('search_hint'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final item = filtered[idx];
                final isDone = vm.completedIds.contains('\${item.number}');

                return InkWell(
                  onTap: () {
                    vm.playAudio(item);
                    vm.markCompleted(item.number);
                    _showDetail(context, item, isHindi, vm);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDone ? Colors.green.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Center(
                      child: Text(item.devanagari, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
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

  void _showDetail(BuildContext context, Num100Item item, bool isHindi, AppViewModel vm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.devanagari, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                const SizedBox(width: 20),
                Text('(\${item.number})', style: const TextStyle(fontSize: 32, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Text(isHindi ? item.hindiName : item.englishName, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
            Text(isHindi ? item.englishName : item.hindiName, style: const TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 16),
            IconButton.filled(
              onPressed: () => vm.playAudio(item),
              icon: const Icon(Icons.volume_up, size: 36),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
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
      child: const HindiNumbers1to100App(),
    ),
  );
}

class HindiNumbers1to100App extends StatelessWidget {
  const HindiNumbers1to100App({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Numbers 1-100',
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

  console.log('42_hindi_numbers_1_100 complete!');
}

// ==========================================
// 43. HINDI NUMBER TRACING
// ==========================================
function buildApp43() {
  const appDir = '43_hindi_number_tracing';
  const pkgName = 'app43_hindi_number_tracing';
  const appTitle = 'Hindi Number Tracing';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'num_trace.dart'), `
class NumTrace {
  final int number;
  final String devanagari;
  final String name;
  final String audio;
  const NumTrace(this.number, this.devanagari, this.name, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/num_trace.dart';

class AppData {
  static const List<NumTrace> numbers = [
    NumTrace(1, '१', 'एक', 'assets/audio/hi/ek.mp3'),
    NumTrace(2, '२', 'दो', 'assets/audio/hi/do.mp3'),
    NumTrace(3, '३', 'तीन', 'assets/audio/hi/teen.mp3'),
    NumTrace(4, '४', 'चार', 'assets/audio/hi/chaar.mp3'),
    NumTrace(5, '५', 'पाँच', 'assets/audio/hi/paanch.mp3'),
    NumTrace(6, '६', 'छह', 'assets/audio/hi/chhah.mp3'),
    NumTrace(7, '७', 'सात', 'assets/audio/hi/saat.mp3'),
    NumTrace(8, '८', 'आठ', 'assets/audio/hi/aath.mp3'),
    NumTrace(9, '९', 'नौ', 'assets/audio/hi/nau.mp3'),
    NumTrace(10, '१०', 'दस', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी संख्या ट्रेसिंग',
  'subtitle': '१ से १० तक अंक ट्रेस करना सीखें',
  'start_learning': 'अंक सूची',
  'practice': 'संख्या ट्रेस करें',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'clear': 'साफ़ करें',
  'next': 'अगला अंक',
  'completed_items': 'ट्रेस किए गए अंक',
  'great_job': 'शानदार ट्रेस किया! 🌟',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'हिंदी संख्या ट्रेसिंग बच्चों के लिए 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Tracing',
  'subtitle': 'Learn to trace Hindi numbers 1 to 10',
  'start_learning': 'Number List',
  'practice': 'Trace Number',
  'progress': 'Progress',
  'settings': 'Settings',
  'clear': 'Clear',
  'next': 'Next Number',
  'completed_items': 'Traced Numbers',
  'great_job': 'Great Tracing! 🌟',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi number tracing for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFE91E63); // Pink/Rose
  static const Color secondaryColor = Color(0xFF00B0FF);
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
                    const Text('✏️', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '५', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.numbers[_idx];

    return Scaffold(
      appBar: AppBar(title: Text('\${item.name} (\${item.devanagari})'), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\${item.devanagari} = \${item.name}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 30, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.audio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: Text(loc.translate('clear'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.pink.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _NumTracePainter(_points, item.devanagari),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.number);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.numbers.length;
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

class _NumTracePainter extends CustomPainter {
  final List<Offset?> points;
  final String devanagari;
  _NumTracePainter(this.points, this.devanagari);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: devanagari, style: TextStyle(fontSize: 200, color: Colors.pink.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.pink..strokeCap = StrokeCap.round..strokeWidth = 12.0;
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
      child: const HindiNumberTracingApp(),
    ),
  );
}

class HindiNumberTracingApp extends StatelessWidget {
  const HindiNumberTracingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Tracing',
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

  console.log('43_hindi_number_tracing complete!');
}

// ==========================================
// 44. HINDI COUNTING PRACTICE
// ==========================================
function buildApp44() {
  const appDir = '44_hindi_counting_practice';
  const pkgName = 'app44_hindi_counting_practice';
  const appTitle = 'Hindi Counting Practice';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'counting_item.dart'), `
class CountingItem {
  final int count;
  final String emoji;
  final String devanagari;
  final String audio;
  const CountingItem(this.count, this.emoji, this.devanagari, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/counting_item.dart';

class AppData {
  static const List<CountingItem> items = [
    CountingItem(1, '🍎', '१', 'assets/audio/hi/ek.mp3'),
    CountingItem(2, '🍌', '२', 'assets/audio/hi/do.mp3'),
    CountingItem(3, '🥭', '३', 'assets/audio/hi/teen.mp3'),
    CountingItem(4, '🚗', '४', 'assets/audio/hi/chaar.mp3'),
    CountingItem(5, '⭐️', '५', 'assets/audio/hi/paanch.mp3'),
    CountingItem(6, '🌸', '६', 'assets/audio/hi/chhah.mp3'),
    CountingItem(7, '🎈', '७', 'assets/audio/hi/saat.mp3'),
    CountingItem(8, '🍦', '८', 'assets/audio/hi/aath.mp3'),
    CountingItem(9, '⚽', '९', 'assets/audio/hi/nau.mp3'),
    CountingItem(10, '🐶', '१०', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी गिनती अभ्यास',
  'subtitle': 'चित्र गिनें और सही संख्या बताएं',
  'start_learning': 'गिनो और चुनो',
  'practice': 'अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'question': 'कितने हैं? गिनें 👆',
  'great_job': 'शाबाश! सही गिनती! 🎉',
  'try_again': 'फिर से गिनें 😊',
  'next': 'अगला सवाल',
  'completed_items': 'सफल गिनती अभ्यास',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए हिंदी गिनती अभ्यास 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Counting Practice',
  'subtitle': 'Count items and choose the number',
  'start_learning': 'Count & Choose',
  'practice': 'Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'question': 'How many? Count them 👆',
  'great_job': 'Great! Correct count! 🎉',
  'try_again': 'Try counting again 😊',
  'next': 'Next Question',
  'completed_items': 'Successful Countings',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Hindi counting practice for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF6F00); // Amber
  static const Color secondaryColor = Color(0xFF00C853);
  static const Color scaffoldBg = Color(0xFFFFF8E1);

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

  Future<void> markCompleted(int c) async {
    final id = '$c';
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
                    const Text('🧮', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '🧮', color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
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
import '../models/counting_item.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late CountingItem _target;
  late List<int> _options;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final list = List<CountingItem>.from(AppData.items)..shuffle(_rnd);
    _target = list.first;

    final opts = {_target.count};
    while (opts.length < 4) {
      opts.add(_rnd.nextInt(10) + 1);
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
      vm.playAudio(_target.audio);
      vm.markCompleted(_target.count);
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
            Text(loc.translate('question'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: List.generate(_target.count, (i) {
                  return Text(_target.emoji, style: const TextStyle(fontSize: 44));
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      child: const HindiCountingPracticeApp(),
    ),
  );
}

class HindiCountingPracticeApp extends StatelessWidget {
  const HindiCountingPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Counting Practice',
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

  console.log('44_hindi_counting_practice complete!');
}

// ==========================================
// 45. HINDI NUMBER WRITING
// ==========================================
function buildApp45() {
  const appDir = '45_hindi_number_writing';
  const pkgName = 'app45_hindi_number_writing';
  const appTitle = 'Hindi Number Writing';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'num_write.dart'), `
class NumWrite {
  final int number;
  final String devanagari;
  final String audio;
  const NumWrite(this.number, this.devanagari, this.audio);
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/num_write.dart';

class AppData {
  static const List<NumWrite> items = [
    NumWrite(1, '१', 'assets/audio/hi/ek.mp3'),
    NumWrite(2, '२', 'assets/audio/hi/do.mp3'),
    NumWrite(3, '३', 'assets/audio/hi/teen.mp3'),
    NumWrite(4, '४', 'assets/audio/hi/chaar.mp3'),
    NumWrite(5, '५', 'assets/audio/hi/paanch.mp3'),
    NumWrite(6, '६', 'assets/audio/hi/chhah.mp3'),
    NumWrite(7, '७', 'assets/audio/hi/saat.mp3'),
    NumWrite(8, '८', 'assets/audio/hi/aath.mp3'),
    NumWrite(9, '९', 'assets/audio/hi/nau.mp3'),
    NumWrite(10, '१०', 'assets/audio/hi/das.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी अंक लेखन',
  'subtitle': 'देवनागरी अंक लिखने का अभ्यास',
  'start_learning': 'अंक लेखन',
  'practice': 'स्लेट',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'clear': 'साफ़ करें',
  'next': 'अगला अंक',
  'completed_items': 'लिखे गए अंक',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'देवनागरी अंक लेखन अभ्यास 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Number Writing',
  'subtitle': 'Learn to write Devanagari numerals',
  'start_learning': 'Number Writing',
  'practice': 'Slate',
  'progress': 'Progress',
  'settings': 'Settings',
  'clear': 'Clear',
  'next': 'Next Number',
  'completed_items': 'Written Numbers',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline Devanagari numeral writing practice for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF009688); // Teal
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
  final List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final item = AppData.items[_idx];

    return Scaffold(
      appBar: AppBar(title: Text(item.devanagari), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.devanagari, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                IconButton(icon: const Icon(Icons.volume_up, size: 32, color: AppTheme.primaryColor), onPressed: () => vm.playAudio(item.audio)),
                ElevatedButton(onPressed: () => setState(() => _points.clear()), child: Text(loc.translate('clear'))),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.teal.shade200, width: 3)),
                child: GestureDetector(
                  onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _WritePainter(_points, item.devanagari),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                vm.markCompleted(item.number);
                setState(() {
                  _points.clear();
                  _idx = (_idx + 1) % AppData.items.length;
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

class _WritePainter extends CustomPainter {
  final List<Offset?> points;
  final String devanagari;
  _WritePainter(this.points, this.devanagari);

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: devanagari, style: TextStyle(fontSize: 180, color: Colors.teal.shade100, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2));

    final paint = Paint()..color = Colors.teal.shade800..strokeCap = StrokeCap.round..strokeWidth = 10.0;
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
      child: const HindiNumberWritingApp(),
    ),
  );
}

class HindiNumberWritingApp extends StatelessWidget {
  const HindiNumberWritingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Number Writing',
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

  console.log('45_hindi_number_writing complete!');
}

async function run() {
  buildApp41();
  buildApp42();
  buildApp43();
  buildApp44();
  buildApp45();
  console.log('Group D (Apps 41-45) build finished.');
}

run();
