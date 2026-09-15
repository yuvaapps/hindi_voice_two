
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
