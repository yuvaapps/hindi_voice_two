import 'package:flutter/material.dart';
import '../models/prompt_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String? _currentPlayingKey;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String? get currentPlayingKey => _currentPlayingKey;
  bool get isAudioPlayingAny => _audioService.isPlaying;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(() {
      if (!_audioService.isPlaying) {
        _currentPlayingKey = null;
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

  bool isKeyPlaying(String key) {
    return _soundEnabled &&
        _audioService.isPlaying &&
        _currentPlayingKey == key;
  }

  Future<void> playPrompt(PromptItem item) async {
    if (!_soundEnabled) return;
    _currentPlayingKey = item.text;
    notifyListeners();

    final isEn = _locale.languageCode == 'en';
    final lang = isEn ? 'en-US' : 'hi-IN';
    final speechText = isEn && item.english.isNotEmpty ? item.english : item.text;

    await _audioService.playAudio(
      item.audio,
      textFallback: speechText,
      lang: lang,
    );
  }

  Future<void> playAudio(String path, {String? textFallback}) async {
    if (!_soundEnabled) return;
    _currentPlayingKey = path;
    notifyListeners();
    final lang = _locale.languageCode == 'en' ? 'en-US' : 'hi-IN';
    await _audioService.playAudio(path, textFallback: textFallback, lang: lang);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
