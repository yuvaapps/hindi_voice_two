import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/pronun_num.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  bool _slowSpeed = false;
  Set<String> _completedIds = {};
  int _score = 0;
  int _streak = 1;
  int _selectedCategoryIndex = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  bool get slowSpeed => _slowSpeed;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  int get streak => _streak;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  AudioService get audioService => _audioService;

  AppViewModel() {
    _load();
  }

  Future<void> _load() async {
    await StorageService.init();
    _locale = Locale(StorageService.getLanguage());
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _score = StorageService.getScore();
    _streak = _completedIds.isEmpty ? 1 : (_completedIds.length ~/ 5) + 1;
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

  void toggleSlowSpeed() {
    _slowSpeed = !_slowSpeed;
    notifyListeners();
  }

  void setCategory(int index) {
    if (index >= 0 && index < AppData.categoryNames.length) {
      _selectedCategoryIndex = index;
      notifyListeners();
    }
  }

  bool isCompleted(int number) => _completedIds.contains('$number');

  int getCategoryCompletionCount(int catIndex) {
    final catItems = AppData.getCategory(catIndex);
    return catItems.where((item) => _completedIds.contains('${item.number}')).length;
  }

  Future<void> markCompleted(int n) async {
    final id = '$n';
    if (!_completedIds.contains(id)) {
      _completedIds.add(id);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 10;
      _streak = (_completedIds.length ~/ 5) + 1;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(PronunNum item, {bool? slow}) async {
    if (!_soundEnabled) return;
    final isSlow = slow ?? _slowSpeed;
    final path = _locale.languageCode == 'en' ? item.englishAudio : item.hindiAudio;
    final fallback = _locale.languageCode == 'en' ? item.englishName : item.hindiName;
    await _audioService.playAudio(path, textFallback: fallback, slow: isSlow);
  }

  Future<void> playAudioPath(String path, {String? textFallback, bool? slow}) async {
    if (!_soundEnabled) return;
    final isSlow = slow ?? _slowSpeed;
    await _audioService.playAudio(path, textFallback: textFallback, slow: isSlow);
  }

  Future<void> speakText(String text, {bool? slow}) async {
    if (!_soundEnabled) return;
    final isSlow = slow ?? _slowSpeed;
    await _audioService.speakWord(text, slow: isSlow);
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    _streak = 1;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
