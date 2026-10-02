import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  int _streak = 1;
  int _selectedCategoryIndex = 0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
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

  void setCategory(int index) {
    if (index >= 0 && index < AppData.categoryNames.length) {
      _selectedCategoryIndex = index;
      notifyListeners();
    }
  }

  bool isCompleted(int id) => _completedIds.contains('$id');

  int getCategoryCompletionCount(int catIndex) {
    final catItems = AppData.getCategory(catIndex);
    return catItems.where((item) => _completedIds.contains('${item.id}')).length;
  }

  Future<void> markCompleted(int id) async {
    final idStr = '$id';
    if (!_completedIds.contains(idStr)) {
      _completedIds.add(idStr);
      await StorageService.setCompletedItems(_completedIds.toList());
      _score += 15;
      _streak = (_completedIds.length ~/ 5) + 1;
      await StorageService.setScore(_score);
      notifyListeners();
    }
  }

  Future<void> playAudio(String path, {String? textFallback}) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path, textFallback: textFallback);
  }

  Future<void> speakWord(String text) async {
    if (!_soundEnabled) return;
    await _audioService.speakWord(text);
  }

  Future<void> speakCount(int count) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(
      'assets/audio/hi/num_$count.mp3',
      textFallback: '$count',
    );
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
