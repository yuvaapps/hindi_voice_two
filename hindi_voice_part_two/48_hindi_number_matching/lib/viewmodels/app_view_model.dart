import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  int _streak = 0;
  int _bestStreak = 0;
  int _totalMatches = 0;
  int _correctMatches = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  int get streak => _streak;
  int get bestStreak => _bestStreak;
  int get totalMatches => _totalMatches;
  int get correctMatches => _correctMatches;

  double get accuracyRate =>
      _totalMatches > 0 ? (_correctMatches / _totalMatches) * 100 : 100.0;

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

  Future<void> recordMatch({required int number, required bool isCorrect}) async {
    _totalMatches++;
    if (isCorrect) {
      _correctMatches++;
      _streak++;
      if (_streak > _bestStreak) _bestStreak = _streak;

      final id = '$number';
      final isNew = !_completedIds.contains(id);
      if (isNew) {
        _completedIds.add(id);
        await StorageService.setCompletedItems(_completedIds.toList());
      }
      _score += 15 + (_streak > 3 ? 5 : 0);
      await StorageService.setScore(_score);
    } else {
      _streak = 0;
    }
    notifyListeners();
  }

  Future<void> markCompleted(int n) async {
    await recordMatch(number: n, isCorrect: true);
  }

  Future<void> playAudio(String path, {String? textFallback}) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path, textFallback: textFallback);
  }

  Future<void> speakWord(String text) async {
    if (!_soundEnabled) return;
    await _audioService.speakWord(text);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    _streak = 0;
    _bestStreak = 0;
    _totalMatches = 0;
    _correctMatches = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
