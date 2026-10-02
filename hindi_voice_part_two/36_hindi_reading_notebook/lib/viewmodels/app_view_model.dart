import 'package:flutter/material.dart';
import '../models/reading_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  int _selectedLevel = 1;
  String? _activeHindi;
  String _searchQuery = '';
  bool _showConfetti = false;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  int get selectedLevel => _selectedLevel;
  String get searchQuery => _searchQuery;
  bool get showConfetti => _showConfetti;
  bool get isAudioPlaying => _audioService.isPlaying;
  String? get activeHindi => _activeHindi;
  ValueNotifier<bool> get isAudioPlayingNotifier => _audioService.isPlayingNotifier;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(_onAudioChanged);
  }

  void _onAudioChanged() {
    if (!_audioService.isPlaying) {
      _activeHindi = null;
    }
    notifyListeners();
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
      _activeHindi = null;
    }
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  Future<void> markCompleted(String text) async {
    if (!_completedIds.contains(text)) {
      _completedIds.add(text);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      await StorageService.setScore(_score);

      if (_completedIds.length == 1 || _completedIds.length % 5 == 0) {
        triggerCelebration();
      }
      notifyListeners();
    }
  }

  Future<void> playItem(ReadingItem item, {bool english = false}) async {
    if (!_soundEnabled) return;
    _activeHindi = item.hindi;
    notifyListeners();

    if (english) {
      await _audioService.playAudio(
        'assets/audio/en/${item.hindi}.mp3',
        textFallback: item.english,
        lang: 'en-US',
      );
    } else {
      await _audioService.playAudio(
        item.audio,
        textFallback: item.hindi,
        lang: 'hi-IN',
      );
    }

    await markCompleted(item.hindi);
  }

  Future<void> playAudio(String path, {String? textFallback, String lang = 'hi-IN'}) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path, textFallback: textFallback, lang: lang);
  }

  Future<void> testVoice({bool english = false}) async {
    if (!_soundEnabled) return;
    if (english) {
      _audioService.speakText('Welcome to Hindi Reading Notebook!', 'en-US');
    } else {
      _audioService.speakText('नमस्ते! हिंदी पठन नोटबुक में आपका स्वागत है।', 'hi-IN');
    }
  }

  bool isItemPlaying(String hindi) {
    return isAudioPlaying && _activeHindi == hindi;
  }

  void triggerCelebration() {
    _showConfetti = true;
    notifyListeners();
  }

  void dismissCelebration() {
    _showConfetti = false;
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    _activeHindi = null;
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    _activeHindi = null;
    await _audioService.stopAudio();
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioChanged);
    _audioService.stopAudio();
    super.dispose();
  }
}
