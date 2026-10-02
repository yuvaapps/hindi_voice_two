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
  String _category = 'all';
  String _searchQuery = '';
  String? _activeCardId;
  bool _showConfetti = false;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String get category => _category;
  String get searchQuery => _searchQuery;
  String? get activeCardId => _activeCardId;
  bool get showConfetti => _showConfetti;
  bool get isAudioPlaying => _audioService.isPlaying;

  AppViewModel() {
    _initAudioListeners();
    _load();
  }

  void _initAudioListeners() {
    _audioService.isPlayingNotifier.addListener(() {
      if (!_audioService.isPlaying) {
        _activeCardId = null;
      }
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

  bool isCardPlaying(String id) {
    return _audioService.isPlaying && _activeCardId == id;
  }

  void setCategory(String cat) {
    _category = cat;
    notifyListeners();
  }

  void setSearchQuery(String q) {
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
    if (!_soundEnabled) {
      await _audioService.stopAudio();
      _activeCardId = null;
    }
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(String id) async {
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);

      if (_completedIds.length == 1 || _completedIds.length % 5 == 0) {
        triggerCelebration();
      }
      notifyListeners();
    }
  }

  Future<void> playAudio(FlashCard card, {bool english = false}) async {
    if (!_soundEnabled) return;

    _activeCardId = card.id;
    notifyListeners();

    if (english) {
      await _audioService.playAudio(
        card.englishAudio,
        textFallback: card.english,
        lang: 'en-US',
      );
    } else {
      await _audioService.playAudio(
        card.hindiAudio,
        textFallback: card.hindi,
        lang: 'hi-IN',
      );
    }

    await markCompleted(card.id);
  }

  Future<void> testVoice({bool english = false}) async {
    if (!_soundEnabled) return;
    if (english) {
      _audioService.speakText('Welcome to Hindi Word Cards!', 'en-US');
    } else {
      _audioService.speakText('नमस्ते! हिंदी शब्द कार्ड्स में आपका स्वागत है।', 'hi-IN');
    }
  }

  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    _activeCardId = null;
    notifyListeners();
  }

  void triggerCelebration() {
    _showConfetti = true;
    notifyListeners();
  }

  void dismissCelebration() {
    _showConfetti = false;
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    _activeCardId = null;
    await _audioService.stopAudio();
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.stopAudio();
    super.dispose();
  }
}
