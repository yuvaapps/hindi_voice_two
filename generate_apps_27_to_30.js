const path = require('path');
const { rootDir, writeFile, setupScaffolding } = require('./generate_app_common');

// ==========================================
// 27. HINDI EASY WORDS
// ==========================================
function buildApp27() {
  const appDir = '27_hindi_easy_words';
  const pkgName = 'app27_hindi_easy_words';
  const appTitle = 'Hindi Easy Words';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  // Model
  writeFile(path.join(appPath, 'lib', 'models', 'easy_word.dart'), `
class EasyWord {
  final String id;
  final String hindi;
  final String english;
  final int letterCount;
  final List<String> letters;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;

  const EasyWord({
    required this.id,
    required this.hindi,
    required this.english,
    required this.letterCount,
    required this.letters,
    required this.emoji,
    required this.hindiAudio,
    required this.englishAudio,
  });
}
`);

  // Data
  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/easy_word.dart';

class AppData {
  static const List<EasyWord> words = [
    // 2-Letter Words
    EasyWord(id: 'kal', hindi: 'कल', english: 'Tomorrow', letterCount: 2, letters: ['क', 'ल'], emoji: '📅', hindiAudio: 'assets/audio/hi/kal.mp3', englishAudio: 'assets/audio/en/kal.mp3'),
    EasyWord(id: 'jal', hindi: 'जल', english: 'Water', letterCount: 2, letters: ['ज', 'ल'], emoji: '💧', hindiAudio: 'assets/audio/hi/jal.mp3', englishAudio: 'assets/audio/en/jal.mp3'),
    EasyWord(id: 'phal', hindi: 'फल', english: 'Fruit', letterCount: 2, letters: ['फ', 'ल'], emoji: '🍎', hindiAudio: 'assets/audio/hi/phal.mp3', englishAudio: 'assets/audio/en/phal.mp3'),
    EasyWord(id: 'sach', hindi: 'सच', english: 'Truth', letterCount: 2, letters: ['स', 'च'], emoji: '✨', hindiAudio: 'assets/audio/hi/sach.mp3', englishAudio: 'assets/audio/en/sach.mp3'),
    EasyWord(id: 'nal', hindi: 'नल', english: 'Tap', letterCount: 2, letters: ['न', 'ल'], emoji: '🚰', hindiAudio: 'assets/audio/hi/nal.mp3', englishAudio: 'assets/audio/en/nal.mp3'),
    EasyWord(id: 'ghar', hindi: 'घर', english: 'Home', letterCount: 2, letters: ['घ', 'र'], emoji: '🏠', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    EasyWord(id: 'jag', hindi: 'जग', english: 'Jug', letterCount: 2, letters: ['ज', 'ग'], emoji: '🫖', hindiAudio: 'assets/audio/hi/jag.mp3', englishAudio: 'assets/audio/en/jag.mp3'),
    EasyWord(id: 'bus', hindi: 'बस', english: 'Bus', letterCount: 2, letters: ['ब', 'स'], emoji: '🚌', hindiAudio: 'assets/audio/hi/bus.mp3', englishAudio: 'assets/audio/en/bus.mp3'),
    EasyWord(id: 'dhan', hindi: 'धन', english: 'Wealth', letterCount: 2, letters: ['ध', 'न'], emoji: '💰', hindiAudio: 'assets/audio/hi/dhan.mp3', englishAudio: 'assets/audio/en/dhan.mp3'),
    EasyWord(id: 'khat', hindi: 'खत', english: 'Letter', letterCount: 2, letters: ['ख', 'त'], emoji: '✉️', hindiAudio: 'assets/audio/hi/khat.mp3', englishAudio: 'assets/audio/en/khat.mp3'),
    EasyWord(id: 'van', hindi: 'वन', english: 'Forest', letterCount: 2, letters: ['व', 'न'], emoji: '🌲', hindiAudio: 'assets/audio/hi/van.mp3', englishAudio: 'assets/audio/en/van.mp3'),
    EasyWord(id: 'kap', hindi: 'कप', english: 'Cup', letterCount: 2, letters: ['क', 'प'], emoji: '☕', hindiAudio: 'assets/audio/hi/kap.mp3', englishAudio: 'assets/audio/en/kap.mp3'),

    // 3-Letter Words
    EasyWord(id: 'kamal', hindi: 'कमल', english: 'Lotus', letterCount: 3, letters: ['क', 'म', 'ल'], emoji: '🪷', hindiAudio: 'assets/audio/hi/kamal.mp3', englishAudio: 'assets/audio/en/kamal.mp3'),
    EasyWord(id: 'matar', hindi: 'मटर', english: 'Peas', letterCount: 3, letters: ['म', 'ट', 'र'], emoji: '🫛', hindiAudio: 'assets/audio/hi/matar.mp3', englishAudio: 'assets/audio/en/matar.mp3'),
    EasyWord(id: 'sadak', hindi: 'सड़क', english: 'Road', letterCount: 3, letters: ['स', 'ड़', 'क'], emoji: '🛣️', hindiAudio: 'assets/audio/hi/sadak.mp3', englishAudio: 'assets/audio/en/sadak.mp3'),
    EasyWord(id: 'kalam', hindi: 'कलम', english: 'Pen', letterCount: 3, letters: ['क', 'ल', 'म'], emoji: '🖊️', hindiAudio: 'assets/audio/hi/kalam.mp3', englishAudio: 'assets/audio/en/kalam.mp3'),
    EasyWord(id: 'gagan', hindi: 'गगन', english: 'Sky', letterCount: 3, letters: ['ग', 'ग', 'न'], emoji: '☁️', hindiAudio: 'assets/audio/hi/gagan.mp3', englishAudio: 'assets/audio/en/gagan.mp3'),
    EasyWord(id: 'magar', hindi: 'मगर', english: 'Crocodile', letterCount: 3, letters: ['म', 'ग', 'र'], emoji: '🐊', hindiAudio: 'assets/audio/hi/magar.mp3', englishAudio: 'assets/audio/en/magar.mp3'),
    EasyWord(id: 'nayan', hindi: 'नयन', english: 'Eye', letterCount: 3, letters: ['न', 'य', 'न'], emoji: '👁️', hindiAudio: 'assets/audio/hi/nayan.mp3', englishAudio: 'assets/audio/en/nayan.mp3'),
    EasyWord(id: 'pawan', hindi: 'पवन', english: 'Wind', letterCount: 3, letters: ['प', 'व', 'न'], emoji: '💨', hindiAudio: 'assets/audio/hi/pawan.mp3', englishAudio: 'assets/audio/en/pawan.mp3'),
    EasyWord(id: 'shehad', hindi: 'शहद', english: 'Honey', letterCount: 3, letters: ['श', 'ह', 'द'], emoji: '🍯', hindiAudio: 'assets/audio/hi/shehad.mp3', englishAudio: 'assets/audio/en/shehad.mp3'),
    EasyWord(id: 'bhavan', hindi: 'भवन', english: 'Building', letterCount: 3, letters: ['भ', 'व', 'न'], emoji: '🏛️', hindiAudio: 'assets/audio/hi/bhavan.mp3', englishAudio: 'assets/audio/en/bhavan.mp3'),
    EasyWord(id: 'batan', hindi: 'बटन', english: 'Button', letterCount: 3, letters: ['ब', 'ट', 'न'], emoji: '🔘', hindiAudio: 'assets/audio/hi/batan.mp3', englishAudio: 'assets/audio/en/batan.mp3'),
  ];
}
`);

  // Localizations
  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी सरल शब्द',
  'subtitle': '2 और 3 अक्षर वाले आसान शब्द सीखें',
  'start_learning': 'शब्द सीखें',
  'practice': 'शब्द बनाओ खेल',
  'progress': 'मेरी प्रगति',
  'settings': 'सेटिंग्स',
  'two_letter': '2 अक्षर वाले',
  'three_letter': '3 अक्षर वाले',
  'all': 'सभी',
  'word_builder': 'अक्षर जोड़कर शब्द बनाओ',
  'breakdown': 'अक्षर जोड़:',
  'completed_items': 'सीखे गए शब्द',
  'total_score': 'कुल अंक',
  'great_job': 'बहुत बढ़िया! 🎉',
  'try_again': 'फिर कोशिश करें 😊',
  'next': 'अगला',
  'replay': 'सुनें',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'sound_on': 'ध्वनि चालू',
  'sound_off': 'ध्वनि बंद',
  'reset_progress': 'प्रगति रीसेट करें',
  'reset_confirm': 'क्या आप वाकई प्रगति रीसेट करना चाहते हैं?',
  'cancel': 'रद्द करें',
  'confirm': 'हाँ',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए 100% ऑफ़लाइन 2 और 3 अक्षर वाले सरल शब्द।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Easy Words',
  'subtitle': 'Learn 2 & 3 Letter Simple Hindi Words',
  'start_learning': 'Learn Words',
  'practice': 'Word Builder Game',
  'progress': 'My Progress',
  'settings': 'Settings',
  'two_letter': '2-Letter Words',
  'three_letter': '3-Letter Words',
  'all': 'All',
  'word_builder': 'Combine letters to build the word',
  'breakdown': 'Breakdown:',
  'completed_items': 'Completed Words',
  'total_score': 'Total Score',
  'great_job': 'Great Job! 🎉',
  'try_again': 'Try Again 😊',
  'next': 'Next',
  'replay': 'Replay',
  'language': 'Language',
  'sound': 'Sound',
  'sound_on': 'Sound On',
  'sound_off': 'Sound Off',
  'reset_progress': 'Reset Progress',
  'reset_confirm': 'Are you sure you want to reset your progress?',
  'cancel': 'Cancel',
  'confirm': 'Yes',
  'about': 'About App',
  'about_desc': '100% Offline 2 & 3 Letter Simple Hindi Words learning for kids.',
};
`);

  // Theme
  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF673AB7);
  static const Color primaryLight = Color(0xFFEDE7F6);
  static const Color secondaryColor = Color(0xFFFF4081);
  static const Color accentColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFF9F7FC);
  static const Color textColor = Color(0xFF212121);
  static const Color subtitleColor = Color(0xFF616161);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF673AB7), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: scaffoldBg,
      ),
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
    );
  }
}
`);

  // ViewModel
  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../models/easy_word.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  int _filterLetterCount = 0;
  String? _currentPlayingId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  int get filterLetterCount => _filterLetterCount;
  String? get currentPlayingId => _currentPlayingId;
  bool get isPlayingAudio => _audioService.isPlaying;

  AppViewModel() {
    _loadSettings();
    _audioService.isPlayingNotifier.addListener(_onAudioStateChanged);
  }

  void _onAudioStateChanged() {
    if (!_audioService.isPlaying) {
      _currentPlayingId = null;
    }
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    _locale = Locale(lang);
    await StorageService.setLanguage(lang);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newLang = _locale.languageCode == 'hi' ? 'en' : 'hi';
    await setLanguage(newLang);
  }

  Future<void> toggleSound() async {
    _soundEnabled = !_soundEnabled;
    if (!_soundEnabled) await _audioService.stopAudio();
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  void setFilter(int count) {
    _filterLetterCount = count;
    notifyListeners();
  }

  Future<void> markCompleted(String id) async {
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      addScore(10);
      notifyListeners();
    }
  }

  Future<void> addScore(int pts) async {
    _score += pts;
    await StorageService.setScore(_score);
    notifyListeners();
  }

  Future<void> playWordAudio(EasyWord word) async {
    if (!_soundEnabled) return;
    _currentPlayingId = word.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? word.englishAudio : word.hindiAudio;
    await _audioService.playAudio(audio);
  }

  Future<void> playCustomAudio(String path) async {
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

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioStateChanged);
    super.dispose();
  }
}
`);

  // Views
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => vm.toggleLanguage(),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 6, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Text(
                        vm.locale.languageCode == 'hi' ? '🇮🇳 हिन्दी' : '🇬🇧 English',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => vm.toggleSound(),
                    icon: Icon(vm.soundEnabled ? Icons.volume_up_rounded : Icons.volume_off_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.headerGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
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
                    const Text('🔤', style: TextStyle(fontSize: 48)),
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
                childAspectRatio: 1.05,
                children: [
                  _MenuCard(title: loc.translate('start_learning'), emoji: '📚', color: const Color(0xFFEDE7F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _MenuCard(title: loc.translate('practice'), emoji: '🧩', color: const Color(0xFFFCE4EC), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
                  _MenuCard(title: loc.translate('progress'), emoji: '🏆', color: const Color(0xFFE8F5E9), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _MenuCard(title: loc.translate('settings'), emoji: '⚙️', color: const Color(0xFFFFF3E0), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({required this.title, required this.emoji, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2),
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
import '../models/easy_word.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final isHindi = vm.locale.languageCode == 'hi';

    final filtered = AppData.words.where((w) {
      if (vm.filterLetterCount == 0) return true;
      return w.letterCount == vm.filterLetterCount;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate('start_learning')),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(loc.translate('all')),
                  selected: vm.filterLetterCount == 0,
                  onSelected: (_) => vm.setFilter(0),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(loc.translate('two_letter')),
                  selected: vm.filterLetterCount == 2,
                  onSelected: (_) => vm.setFilter(2),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: Text(loc.translate('three_letter')),
                  selected: vm.filterLetterCount == 3,
                  onSelected: (_) => vm.setFilter(3),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(14),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isCompleted = vm.completedIds.contains(word.id);

                return InkWell(
                  onTap: () {
                    vm.playWordAudio(word);
                    vm.markCompleted(word.id);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isPlaying ? AppTheme.primaryColor : (isCompleted ? Colors.green : Colors.grey.shade200),
                        width: isPlaying ? 2.5 : 1.5,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(word.emoji, style: const TextStyle(fontSize: 42)),
                        const SizedBox(height: 6),
                        Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('\${word.letters.join(" + ")} = \${word.hindi}', style: const TextStyle(fontSize: 12, color: AppTheme.subtitleColor)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.volume_up_rounded, size: 20, color: isPlaying ? Colors.white : AppTheme.primaryColor),
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

  writeFile(path.join(appPath, 'lib', 'views', 'practice_screen.dart'), `
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/easy_word.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late EasyWord _target;
  late List<String> _shuffledLetters;
  final List<String> _selectedLetters = [];
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _loadWord();
  }

  void _loadWord() {
    _target = AppData.words[_rnd.nextInt(AppData.words.length)];
    _shuffledLetters = List<String>.from(_target.letters)..shuffle(_rnd);
    _selectedLetters.clear();
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _onTapLetter(String letter) {
    if (_isCorrect == true) return;
    setState(() {
      _selectedLetters.add(letter);
      _shuffledLetters.remove(letter);

      if (_selectedLetters.length == _target.letters.length) {
        final formed = _selectedLetters.join('');
        final correct = (formed == _target.hindi);
        _isCorrect = correct;
        final vm = context.read<AppViewModel>();
        if (correct) {
          vm.addScore(15);
          vm.markCompleted(_target.id);
          vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
        } else {
          vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
        }
      }
    });
  }

  void _resetWord() {
    setState(() {
      _shuffledLetters = List<String>.from(_target.letters)..shuffle(_rnd);
      _selectedLetters.clear();
      _isCorrect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('word_builder'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(_target.emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 10),
            IconButton.filled(
              onPressed: () => vm.playWordAudio(_target),
              icon: const Icon(Icons.volume_up_rounded, size: 32),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_target.letters.length, (i) {
                  final letter = i < _selectedLetters.length ? _selectedLetters[i] : '_';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(letter, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 14,
              children: _shuffledLetters.map((l) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryLight,
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () => _onTapLetter(l),
                  child: Text(l, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                );
              }).toList(),
            ),
            const Spacer(),
            if (_isCorrect != null)
              Text(
                _isCorrect! ? loc.translate('great_job') : loc.translate('try_again'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange),
              ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetWord,
                    child: Text(loc.translate('cancel')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(_loadWord),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
                    child: Text(loc.translate('next')),
                  ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  Text('$done / $total', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(loc.translate('completed_items'), style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(value: total > 0 ? done / total : 0, minHeight: 12, color: AppTheme.accentColor),
                  ),
                  const SizedBox(height: 14),
                  Text('\${loc.translate('total_score')}: \${vm.score}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
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
      child: const HindiEasyWordsApp(),
    ),
  );
}

class HindiEasyWordsApp extends StatelessWidget {
  const HindiEasyWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Easy Words',
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

  console.log('27_hindi_easy_words complete!');
}

// ==========================================
// 28. HINDI FIRST WORDS
// ==========================================
function buildApp28() {
  const appDir = '28_hindi_first_words';
  const pkgName = 'app28_hindi_first_words';
  const appTitle = 'Hindi First Words';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'first_word.dart'), `
class FirstWord {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;

  const FirstWord({
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
import '../models/first_word.dart';

class AppData {
  static const List<FirstWord> firstWords = [
    FirstWord(id: 'maa', hindi: 'माँ', english: 'Mother', emoji: '🤱', hindiAudio: 'assets/audio/hi/maa.mp3', englishAudio: 'assets/audio/en/maa.mp3'),
    FirstWord(id: 'papa', hindi: 'पापा', english: 'Father', emoji: '👨‍🍼', hindiAudio: 'assets/audio/hi/papa.mp3', englishAudio: 'assets/audio/en/papa.mp3'),
    FirstWord(id: 'paani', hindi: 'पानी', english: 'Water', emoji: '💧', hindiAudio: 'assets/audio/hi/paani.mp3', englishAudio: 'assets/audio/en/paani.mp3'),
    FirstWord(id: 'doodh', hindi: 'दूध', english: 'Milk', emoji: '🥛', hindiAudio: 'assets/audio/hi/doodh.mp3', englishAudio: 'assets/audio/en/doodh.mp3'),
    FirstWord(id: 'khaana', hindi: 'खाना', english: 'Food', emoji: '🍲', hindiAudio: 'assets/audio/hi/khaana.mp3', englishAudio: 'assets/audio/en/khaana.mp3'),
    FirstWord(id: 'ghar', hindi: 'घर', english: 'Home', emoji: '🏡', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    FirstWord(id: 'gend', hindi: 'गेंद', english: 'Ball', emoji: '⚽', hindiAudio: 'assets/audio/hi/gend.mp3', englishAudio: 'assets/audio/en/gend.mp3'),
    FirstWord(id: 'billi', hindi: 'बिल्ली', english: 'Cat', emoji: '🐱', hindiAudio: 'assets/audio/hi/billi.mp3', englishAudio: 'assets/audio/en/billi.mp3'),
    FirstWord(id: 'kutta', hindi: 'कुत्ता', english: 'Dog', emoji: '🐶', hindiAudio: 'assets/audio/hi/kutta.mp3', englishAudio: 'assets/audio/en/kutta.mp3'),
    FirstWord(id: 'seb', hindi: 'सेब', english: 'Apple', emoji: '🍎', hindiAudio: 'assets/audio/hi/seb.mp3', englishAudio: 'assets/audio/en/seb.mp3'),
    FirstWord(id: 'kela', hindi: 'केला', english: 'Banana', emoji: '🍌', hindiAudio: 'assets/audio/hi/kela.mp3', englishAudio: 'assets/audio/en/kela.mp3'),
    FirstWord(id: 'gaay', hindi: 'गाय', english: 'Cow', emoji: '🐮', hindiAudio: 'assets/audio/hi/gaay.mp3', englishAudio: 'assets/audio/en/gaay.mp3'),
    FirstWord(id: 'haathi', hindi: 'हाथी', english: 'Elephant', emoji: '🐘', hindiAudio: 'assets/audio/hi/haathi.mp3', englishAudio: 'assets/audio/en/haathi.mp3'),
    FirstWord(id: 'chidiya', hindi: 'चिड़िया', english: 'Bird', emoji: '🐦', hindiAudio: 'assets/audio/hi/chidiya.mp3', englishAudio: 'assets/audio/en/chidiya.mp3'),
    FirstWord(id: 'titli', hindi: 'तितली', english: 'Butterfly', emoji: '🦋', hindiAudio: 'assets/audio/hi/titli.mp3', englishAudio: 'assets/audio/en/titli.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी पहले शब्द',
  'subtitle': 'नन्हे बच्चों के पहले प्यारे शब्द',
  'start_learning': 'शब्द सुनें और बोलें',
  'practice': 'पहचानो कौन?',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'completed_items': 'सीखे गए शब्द',
  'total_score': 'कुल अंक',
  'great_job': 'शाबाश! बहुत बढ़िया! 🎉',
  'try_again': 'फिर कोशिश करो 😊',
  'next': 'अगला',
  'listen_prompt': 'चित्र छुओ और आवाज़ सुनो!',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'sound_on': 'ध्वनि चालू',
  'sound_off': 'ध्वनि बंद',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'छोटे बच्चों के पहले हिंदी शब्द 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi First Words',
  'subtitle': 'First Hindi words for toddlers',
  'start_learning': 'Hear & Learn',
  'practice': 'Guess Who?',
  'progress': 'Progress',
  'settings': 'Settings',
  'completed_items': 'Learned Words',
  'total_score': 'Total Score',
  'great_job': 'Great Job! 🎉',
  'try_again': 'Try Again 😊',
  'next': 'Next',
  'listen_prompt': 'Touch the card to hear the word!',
  'language': 'Language',
  'sound': 'Sound',
  'sound_on': 'Sound On',
  'sound_off': 'Sound Off',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline first Hindi words for toddlers.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF4081); // Bright Rose Pink
  static const Color primaryLight = Color(0xFFFCE4EC);
  static const Color secondaryColor = Color(0xFFFF9100); // Orange
  static const Color accentColor = Color(0xFF00E676);
  static const Color scaffoldBg = Color(0xFFFFF9FA);
  static const Color textColor = Color(0xFF37474F);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFFFF4081), Color(0xFFFF6E40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
import '../models/first_word.dart';
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
    _loadSettings();
    _audioService.isPlayingNotifier.addListener(() {
      if (!_audioService.isPlaying) _currentPlayingId = null;
      notifyListeners();
    });
  }

  Future<void> _loadSettings() async {
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

  Future<void> playWordAudio(FirstWord word) async {
    if (!_soundEnabled) return;
    _currentPlayingId = word.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? word.englishAudio : word.hindiAudio;
    await _audioService.playAudio(audio);
  }

  Future<void> playCustomAudio(String path) async {
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
                  IconButton.filledTonal(
                    onPressed: vm.toggleSound,
                    icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(gradient: AppTheme.headerGradient, borderRadius: BorderRadius.circular(24)),
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
                    const Text('🧸', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '👶', color: const Color(0xFFFCE4EC), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '🎈', color: const Color(0xFFFFF3E0), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: const Color(0xFFE8F5E9), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: const Color(0xFFEDE7F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
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

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: PageView.builder(
        itemCount: AppData.firstWords.length,
        itemBuilder: (context, idx) {
          final word = AppData.firstWords[idx];
          final isPlaying = vm.currentPlayingId == word.id;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: InkWell(
              onTap: () {
                vm.playWordAudio(word);
                vm.markCompleted(word.id);
              },
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: isPlaying ? AppTheme.primaryColor : Colors.pink.shade100, width: isPlaying ? 4 : 2),
                  boxShadow: [BoxShadow(color: Colors.pink.withAlpha(25), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(word.emoji, style: const TextStyle(fontSize: 110)),
                    const SizedBox(height: 20),
                    Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
                    const SizedBox(height: 8),
                    Text(isHindi ? word.english : word.hindi, style: const TextStyle(fontSize: 22, color: Colors.grey)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: isPlaying ? AppTheme.primaryColor : AppTheme.primaryLight, shape: BoxShape.circle),
                      child: Icon(Icons.volume_up, size: 40, color: isPlaying ? Colors.white : AppTheme.primaryColor),
                    ),
                    const SizedBox(height: 12),
                    Text(loc.translate('listen_prompt'), style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
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
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/first_word.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late FirstWord _target;
  late List<FirstWord> _choices;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final list = List<FirstWord>.from(AppData.firstWords)..shuffle(_rnd);
    _target = list.first;
    _choices = list.take(3).toList()..shuffle(_rnd);
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _choose(FirstWord w) {
    if (_isCorrect == true) return;
    final correct = (w.id == _target.id);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.markCompleted(_target.id);
      vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
    } else {
      vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(loc.translate('practice'), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            IconButton.filled(
              onPressed: () => vm.playWordAudio(_target),
              icon: const Icon(Icons.volume_up, size: 50),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(20)),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _choices.length,
                itemBuilder: (context, idx) {
                  final w = _choices[idx];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.textColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () => _choose(w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(w.emoji, style: const TextStyle(fontSize: 40)),
                          const SizedBox(width: 16),
                          Text(vm.locale.languageCode == 'hi' ? w.hindi : w.english, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(_next),
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
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final total = AppData.firstWords.length;
    final done = vm.completedIds.length;

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('progress')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🎉', style: TextStyle(fontSize: 72)),
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
      child: const HindiFirstWordsApp(),
    ),
  );
}

class HindiFirstWordsApp extends StatelessWidget {
  const HindiFirstWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi First Words',
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

  console.log('28_hindi_first_words complete!');
}

// ==========================================
// 29. HINDI COMMON WORDS
// ==========================================
function buildApp29() {
  const appDir = '29_hindi_common_words';
  const pkgName = 'app29_hindi_common_words';
  const appTitle = 'Hindi Common Words';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'common_word.dart'), `
class CommonWord {
  final String id;
  final String hindi;
  final String english;
  final String category;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;

  const CommonWord({
    required this.id,
    required this.hindi,
    required this.english,
    required this.category,
    required this.emoji,
    required this.hindiAudio,
    required this.englishAudio,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/common_word.dart';

class AppData {
  static const List<CommonWord> words = [
    CommonWord(id: 'ghar', hindi: 'घर', english: 'Home', category: 'daily', emoji: '🏠', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    CommonWord(id: 'paani', hindi: 'पानी', english: 'Water', category: 'daily', emoji: '💧', hindiAudio: 'assets/audio/hi/paani.mp3', englishAudio: 'assets/audio/en/paani.mp3'),
    CommonWord(id: 'doodh', hindi: 'दूध', english: 'Milk', category: 'daily', emoji: '🥛', hindiAudio: 'assets/audio/hi/doodh.mp3', englishAudio: 'assets/audio/en/doodh.mp3'),
    CommonWord(id: 'khaana', hindi: 'खाना', english: 'Food', category: 'daily', emoji: '🍲', hindiAudio: 'assets/audio/hi/khaana.mp3', englishAudio: 'assets/audio/en/khaana.mp3'),
    CommonWord(id: 'seb', hindi: 'सेब', english: 'Apple', category: 'fruits', emoji: '🍎', hindiAudio: 'assets/audio/hi/seb.mp3', englishAudio: 'assets/audio/en/seb.mp3'),
    CommonWord(id: 'aam', hindi: 'आम', english: 'Mango', category: 'fruits', emoji: '🥭', hindiAudio: 'assets/audio/hi/aam.mp3', englishAudio: 'assets/audio/en/aam.mp3'),
    CommonWord(id: 'kela', hindi: 'केला', english: 'Banana', category: 'fruits', emoji: '🍌', hindiAudio: 'assets/audio/hi/kela.mp3', englishAudio: 'assets/audio/en/kela.mp3'),
    CommonWord(id: 'angoor', hindi: 'अंगूर', english: 'Grapes', category: 'fruits', emoji: '🍇', hindiAudio: 'assets/audio/hi/angoor.mp3', englishAudio: 'assets/audio/en/angoor.mp3'),
    CommonWord(id: 'kutta', hindi: 'कुत्ता', english: 'Dog', category: 'animals', emoji: '🐶', hindiAudio: 'assets/audio/hi/kutta.mp3', englishAudio: 'assets/audio/en/kutta.mp3'),
    CommonWord(id: 'billi', hindi: 'बिल्ली', english: 'Cat', category: 'animals', emoji: '🐱', hindiAudio: 'assets/audio/hi/billi.mp3', englishAudio: 'assets/audio/en/billi.mp3'),
    CommonWord(id: 'haathi', hindi: 'हाथी', english: 'Elephant', category: 'animals', emoji: '🐘', hindiAudio: 'assets/audio/hi/haathi.mp3', englishAudio: 'assets/audio/en/haathi.mp3'),
    CommonWord(id: 'sher', hindi: 'शेर', english: 'Lion', category: 'animals', emoji: '🦁', hindiAudio: 'assets/audio/hi/sher.mp3', englishAudio: 'assets/audio/en/sher.mp3'),
    CommonWord(id: 'kitaab', hindi: 'किताब', english: 'Book', category: 'school', emoji: '📚', hindiAudio: 'assets/audio/hi/kitaab.mp3', englishAudio: 'assets/audio/en/kitaab.mp3'),
    CommonWord(id: 'kalam', hindi: 'कलम', english: 'Pen', category: 'school', emoji: '🖊️', hindiAudio: 'assets/audio/hi/kalam.mp3', englishAudio: 'assets/audio/en/kalam.mp3'),
    CommonWord(id: 'school', hindi: 'स्कूल', english: 'School', category: 'school', emoji: '🏫', hindiAudio: 'assets/audio/hi/school.mp3', englishAudio: 'assets/audio/en/school.mp3'),
    CommonWord(id: 'suraj', hindi: 'सूरज', english: 'Sun', category: 'nature', emoji: '☀️', hindiAudio: 'assets/audio/hi/suraj.mp3', englishAudio: 'assets/audio/en/suraj.mp3'),
    CommonWord(id: 'chand', hindi: 'चाँद', english: 'Moon', category: 'nature', emoji: '🌙', hindiAudio: 'assets/audio/hi/chand.mp3', englishAudio: 'assets/audio/en/chand.mp3'),
    CommonWord(id: 'ped', hindi: 'पेड़', english: 'Tree', category: 'nature', emoji: '🌳', hindiAudio: 'assets/audio/hi/ped.mp3', englishAudio: 'assets/audio/en/ped.mp3'),
    CommonWord(id: 'phool', hindi: 'फूल', english: 'Flower', category: 'nature', emoji: '🌸', hindiAudio: 'assets/audio/hi/phool.mp3', englishAudio: 'assets/audio/en/phool.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी आम शब्द',
  'subtitle': 'रोज़मर्रा के सबसे ज़्यादा इस्तेमाल होने वाले शब्द',
  'start_learning': 'शब्द संग्रह',
  'practice': 'शब्दावली क्विज़',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'all': 'सभी',
  'daily': 'दैनिक',
  'fruits': 'फल',
  'animals': 'जानवर',
  'school': 'स्कूल',
  'nature': 'प्रकृति',
  'favorites': 'पसंदीदा',
  'search_hint': 'खोजें...',
  'completed_items': 'सीखे गए शब्द',
  'total_score': 'कुल अंक',
  'great_job': 'बहुत बढ़िया! 🎉',
  'try_again': 'फिर कोशिश करें 😊',
  'next': 'अगला',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'sound_on': 'ध्वनि चालू',
  'sound_off': 'ध्वनि बंद',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए 100% ऑफ़लाइन सामान्य हिंदी शब्दकोश।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Common Words',
  'subtitle': 'Most frequently used daily Hindi words',
  'start_learning': 'Word Collection',
  'practice': 'Vocabulary Quiz',
  'progress': 'Progress',
  'settings': 'Settings',
  'all': 'All',
  'daily': 'Daily',
  'fruits': 'Fruits',
  'animals': 'Animals',
  'school': 'School',
  'nature': 'Nature',
  'favorites': 'Favorites',
  'search_hint': 'Search words...',
  'completed_items': 'Learned Words',
  'total_score': 'Total Score',
  'great_job': 'Great Job! 🎉',
  'try_again': 'Try Again 😊',
  'next': 'Next',
  'language': 'Language',
  'sound': 'Sound',
  'sound_on': 'Sound On',
  'sound_off': 'Sound Off',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': '100% Offline common Hindi vocabulary for kids.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00897B); // Teal
  static const Color primaryLight = Color(0xFFE0F2F1);
  static const Color secondaryColor = Color(0xFFFFB300);
  static const Color accentColor = Color(0xFF43A047);
  static const Color scaffoldBg = Color(0xFFF4FAF9);
  static const Color textColor = Color(0xFF263238);

  static const LinearGradient headerGradient = LinearGradient(
    colors: [Color(0xFF00897B), Color(0xFF004D40)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
import '../models/common_word.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  Set<String> _favoriteIds = {};
  int _score = 0;
  String _category = 'all';
  String _searchQuery = '';
  String? _currentPlayingId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  Set<String> get favoriteIds => _favoriteIds;
  int get score => _score;
  String get category => _category;
  String get searchQuery => _searchQuery;
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
    _favoriteIds = StorageService.getFavorites().toSet();
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

  void setCategory(String cat) {
    _category = cat;
    notifyListeners();
  }

  void setSearch(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) _favoriteIds.remove(id);
    else _favoriteIds.add(id);
    await StorageService.setFavorites(_favoriteIds.toList());
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

  Future<void> playWordAudio(CommonWord word) async {
    if (!_soundEnabled) return;
    _currentPlayingId = word.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? word.englishAudio : word.hindiAudio;
    await _audioService.playAudio(audio);
  }

  Future<void> playCustomAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _favoriteIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setFavorites([]);
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
                  IconButton.filledTonal(
                    onPressed: vm.toggleSound,
                    icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(gradient: AppTheme.headerGradient, borderRadius: BorderRadius.circular(24)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📚', color: const Color(0xFFE0F2F1), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '🎯', color: const Color(0xFFFFF8E1), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: const Color(0xFFE8F5E9), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: const Color(0xFFEDE7F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
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

    final filtered = AppData.words.where((w) {
      final matchCat = vm.category == 'all' || w.category == vm.category;
      final q = vm.searchQuery.toLowerCase().trim();
      final matchQ = q.isEmpty || w.hindi.contains(q) || w.english.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('start_learning')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: vm.setSearch,
              decoration: InputDecoration(
                hintText: loc.translate('search_hint'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final word = filtered[idx];
                final isPlaying = vm.currentPlayingId == word.id;
                final isFav = vm.favoriteIds.contains(word.id);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  child: ListTile(
                    leading: Text(word.emoji, style: const TextStyle(fontSize: 32)),
                    title: Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text(isHindi ? word.english : word.hindi, style: const TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(isFav ? Icons.star : Icons.star_border, color: Colors.amber),
                          onPressed: () => vm.toggleFavorite(word.id),
                        ),
                        IconButton(
                          icon: Icon(isPlaying ? Icons.volume_up : Icons.volume_down, color: AppTheme.primaryColor),
                          onPressed: () {
                            vm.playWordAudio(word);
                            vm.markCompleted(word.id);
                          },
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

  writeFile(path.join(appPath, 'lib', 'views', 'practice_screen.dart'), `
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../localization/app_localizations.dart';
import '../models/common_word.dart';
import '../utils/app_theme.dart';
import '../viewmodels/app_view_model.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late CommonWord _target;
  late List<CommonWord> _choices;
  bool? _isCorrect;
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final list = List<CommonWord>.from(AppData.words)..shuffle(_rnd);
    _target = list.first;
    _choices = list.take(4).toList()..shuffle(_rnd);
    _isCorrect = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppViewModel>().playWordAudio(_target);
    });
  }

  void _choose(CommonWord w) {
    if (_isCorrect == true) return;
    final correct = (w.id == _target.id);
    setState(() => _isCorrect = correct);
    final vm = context.read<AppViewModel>();
    if (correct) {
      vm.markCompleted(_target.id);
      vm.playCustomAudio('assets/audio/hi/feedback_great.mp3');
    } else {
      vm.playCustomAudio('assets/audio/hi/feedback_try.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('practice')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            IconButton.filled(
              onPressed: () => vm.playWordAudio(_target),
              icon: const Icon(Icons.volume_up, size: 44),
              style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                children: _choices.map((c) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.textColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () => _choose(c),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c.emoji, style: const TextStyle(fontSize: 44)),
                        const SizedBox(height: 8),
                        Text(vm.locale.languageCode == 'hi' ? c.hindi : c.english, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            if (_isCorrect != null)
              Text(_isCorrect! ? loc.translate('great_job') : loc.translate('try_again'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _isCorrect! ? Colors.green : Colors.orange)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(_next),
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
      child: const HindiCommonWordsApp(),
    ),
  );
}

class HindiCommonWordsApp extends StatelessWidget {
  const HindiCommonWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Common Words',
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

  console.log('29_hindi_common_words complete!');
}

// ==========================================
// 30. HINDI WORD NOTEBOOK
// ==========================================
function buildApp30() {
  const appDir = '30_hindi_word_notebook';
  const pkgName = 'app30_hindi_word_notebook';
  const appTitle = 'Hindi Word Notebook';
  const appPath = path.join(rootDir, appDir);

  setupScaffolding(appDir, pkgName, appTitle);

  writeFile(path.join(appPath, 'lib', 'models', 'notebook_word.dart'), `
class NotebookWord {
  final String id;
  final String hindi;
  final String english;
  final String exampleSentence;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;

  const NotebookWord({
    required this.id,
    required this.hindi,
    required this.english,
    required this.exampleSentence,
    required this.emoji,
    required this.hindiAudio,
    required this.englishAudio,
  });
}
`);

  writeFile(path.join(appPath, 'lib', 'data', 'app_data.dart'), `
import '../models/notebook_word.dart';

class AppData {
  static const List<NotebookWord> words = [
    NotebookWord(id: 'ghar', hindi: 'घर', english: 'Home', exampleSentence: 'यह मेरा प्यारा घर है।', emoji: '🏠', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    NotebookWord(id: 'aam', hindi: 'आम', english: 'Mango', exampleSentence: 'आम फलों का राजा है।', emoji: '🥭', hindiAudio: 'assets/audio/hi/aam.mp3', englishAudio: 'assets/audio/en/aam.mp3'),
    NotebookWord(id: 'kitaab', hindi: 'किताब', english: 'Book', exampleSentence: 'किताब से ज्ञान मिलता है।', emoji: '📚', hindiAudio: 'assets/audio/hi/kitaab.mp3', englishAudio: 'assets/audio/en/kitaab.mp3'),
    NotebookWord(id: 'kalam', hindi: 'कलम', english: 'Pen', exampleSentence: 'कलम से सुंदर लिखो।', emoji: '🖊️', hindiAudio: 'assets/audio/hi/kalam.mp3', englishAudio: 'assets/audio/en/kalam.mp3'),
    NotebookWord(id: 'school', hindi: 'स्कूल', english: 'School', exampleSentence: 'हम सब स्कूल जाते हैं।', emoji: '🏫', hindiAudio: 'assets/audio/hi/school.mp3', englishAudio: 'assets/audio/en/school.mp3'),
    NotebookWord(id: 'suraj', hindi: 'सूरज', english: 'Sun', exampleSentence: 'सूरज रोशनी देता है।', emoji: '☀️', hindiAudio: 'assets/audio/hi/suraj.mp3', englishAudio: 'assets/audio/en/suraj.mp3'),
    NotebookWord(id: 'paani', hindi: 'पानी', english: 'Water', exampleSentence: 'पानी ही जीवन है।', emoji: '💧', hindiAudio: 'assets/audio/hi/paani.mp3', englishAudio: 'assets/audio/en/paani.mp3'),
    NotebookWord(id: 'kamal', hindi: 'कमल', english: 'Lotus', exampleSentence: 'कमल हमारा राष्ट्रीय फूल है।', emoji: '🪷', hindiAudio: 'assets/audio/hi/kamal.mp3', englishAudio: 'assets/audio/en/kamal.mp3'),
  ];
}
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'hi.dart'), `
const Map<String, String> hiStrings = {
  'app_title': 'हिंदी शब्द नोटबुक',
  'subtitle': 'अपनी डिजिटल नोटबुक में नए शब्द लिखें',
  'start_learning': 'नोटबुक खोलें',
  'practice': 'नोटबुक अभ्यास',
  'progress': 'प्रगति',
  'settings': 'सेटिंग्स',
  'page': 'पृष्ठ',
  'stamped': 'सीखा गया! 🌟',
  'mark_done': 'सम्पन्न चिह्नित करें',
  'write_word': 'अभ्यास स्लेट',
  'clear': 'साफ़ करें',
  'next_page': 'अगला पृष्ठ',
  'prev_page': 'पिछला पृष्ठ',
  'completed_items': 'नोटबुक में पूर्ण पृष्ठ',
  'great_job': 'अद्भुत काम! 🎉',
  'try_again': 'फिर कोशिश करें 😊',
  'language': 'भाषा',
  'sound': 'ध्वनि',
  'reset_progress': 'प्रगति रीसेट करें',
  'about': 'ऐप के बारे में',
  'about_desc': 'बच्चों के लिए सुंदर डिजिटल नोटबुक 100% ऑफ़लाइन।',
};
`);

  writeFile(path.join(appPath, 'lib', 'localization', 'en.dart'), `
const Map<String, String> enStrings = {
  'app_title': 'Hindi Word Notebook',
  'subtitle': 'Write and practice words in your digital notebook',
  'start_learning': 'Open Notebook',
  'practice': 'Notebook Practice',
  'progress': 'Progress',
  'settings': 'Settings',
  'page': 'Page',
  'stamped': 'Mastered! 🌟',
  'mark_done': 'Mark Completed',
  'write_word': 'Writing Slate',
  'clear': 'Clear',
  'next_page': 'Next Page',
  'prev_page': 'Previous Page',
  'completed_items': 'Mastered Pages',
  'great_job': 'Great Job! 🎉',
  'try_again': 'Try Again 😊',
  'language': 'Language',
  'sound': 'Sound',
  'reset_progress': 'Reset Progress',
  'about': 'About App',
  'about_desc': 'Digital notebook experience for kids 100% offline.',
};
`);

  writeFile(path.join(appPath, 'lib', 'utils', 'app_theme.dart'), `
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF57C00); // Warm Notebook Amber
  static const Color primaryLight = Color(0xFFFFF3E0);
  static const Color secondaryColor = Color(0xFF1976D2);
  static const Color notebookBg = Color(0xFFFFFDE7); // Pale notebook yellow
  static const Color lineMargin = Color(0xFFFFCDD2);
  static const Color textColor = Color(0xFF212121);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, primary: primaryColor, secondary: secondaryColor),
      scaffoldBackgroundColor: notebookBg,
      textTheme: GoogleFonts.notoSansDevanagariTextTheme(),
    );
  }
}
`);

  writeFile(path.join(appPath, 'lib', 'viewmodels', 'app_view_model.dart'), `
import 'package:flutter/material.dart';
import '../models/notebook_word.dart';
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

  Future<void> playWordAudio(NotebookWord word) async {
    if (!_soundEnabled) return;
    _currentPlayingId = word.id;
    notifyListeners();
    final audio = _locale.languageCode == 'en' ? word.englishAudio : word.hindiAudio;
    await _audioService.playAudio(audio);
  }

  Future<void> playCustomAudio(String path) async {
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
                  IconButton.filledTonal(
                    onPressed: vm.toggleSound,
                    icon: Icon(vm.soundEnabled ? Icons.volume_up : Icons.volume_off),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: AppTheme.primaryColor.withAlpha(50), blurRadius: 10, offset: const Offset(0, 4))],
                ),
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
                    const Text('📓', style: TextStyle(fontSize: 50)),
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
                  _Card(title: loc.translate('start_learning'), emoji: '📖', color: const Color(0xFFFFF3E0), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningScreen()))),
                  _Card(title: loc.translate('practice'), emoji: '✏️', color: const Color(0xFFE3F2FD), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PracticeScreen()))),
                  _Card(title: loc.translate('progress'), emoji: '🌟', color: const Color(0xFFE8F5E9), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen()))),
                  _Card(title: loc.translate('settings'), emoji: '⚙️', color: const Color(0xFFEDE7F6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
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
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    final loc = AppLocalizations.of(context);
    final word = AppData.words[_page];
    final isCompleted = vm.completedIds.contains(word.id);
    final isHindi = vm.locale.languageCode == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text('\${loc.translate('page')} \${_page + 1} / \${AppData.words.length}'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Text(loc.translate('stamped'), style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)),
                ),
              const Spacer(),
              Text(word.emoji, style: const TextStyle(fontSize: 72)),
              const SizedBox(height: 16),
              Text(isHindi ? word.hindi : word.english, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Text(isHindi ? word.english : word.hindi, style: const TextStyle(fontSize: 20, color: Colors.grey)),
              const SizedBox(height: 12),
              Text(word.exampleSentence, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              const Spacer(),
              IconButton.filled(
                onPressed: () {
                  vm.playWordAudio(word);
                  vm.markCompleted(word.id);
                },
                icon: const Icon(Icons.volume_up, size: 36),
                style: IconButton.styleFrom(backgroundColor: AppTheme.primaryColor, padding: const EdgeInsets.all(16)),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _page > 0 ? () => setState(() => _page--) : null,
                    child: Text(loc.translate('prev_page')),
                  ),
                  ElevatedButton(
                    onPressed: _page < AppData.words.length - 1 ? () => setState(() => _page++) : null,
                    child: Text(loc.translate('next_page')),
                  ),
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
  final List<Offset?> _points = [];
  int _wordIdx = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final vm = context.watch<AppViewModel>();
    final word = AppData.words[_wordIdx];

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('write_word')), backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(word.hindi, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: AppTheme.primaryColor),
                  onPressed: () => vm.playWordAudio(word),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _points.clear()),
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
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      final renderBox = context.findRenderObject() as RenderBox?;
                      if (renderBox != null) {
                        _points.add(details.localPosition);
                      }
                    });
                  },
                  onPanEnd: (_) => _points.add(null),
                  child: CustomPaint(
                    painter: _SlatePainter(_points, word.hindi),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _points.clear();
                  _wordIdx = (_wordIdx + 1) % AppData.words.length;
                });
                vm.markCompleted(word.id);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48)),
              child: Text(loc.translate('next_page')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlatePainter extends CustomPainter {
  final List<Offset?> points;
  final String guideText;
  _SlatePainter(this.points, this.guideText);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw guide background text
    final textPainter = TextPainter(
      text: TextSpan(
        text: guideText,
        style: TextStyle(fontSize: 90, color: Colors.grey.shade200, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2));

    // Draw user strokes
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6.0;

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
      child: const HindiWordNotebookApp(),
    ),
  );
}

class HindiWordNotebookApp extends StatelessWidget {
  const HindiWordNotebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppViewModel>();
    return MaterialApp(
      title: 'Hindi Word Notebook',
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

  console.log('30_hindi_word_notebook complete!');
}

async function run() {
  buildApp27();
  buildApp28();
  buildApp29();
  buildApp30();
  console.log('Group A (Apps 27-30) build finished.');
}

run();
