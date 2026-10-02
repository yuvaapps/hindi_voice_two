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
  bool _showConfetti = false;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  bool get showConfetti => _showConfetti;
  AudioService get audioService => _audioService;

  bool get isPlaying => _audioService.isPlaying;
  int? get activeNumberValue => _audioService.activeNumberValue;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(_onAudioStateChanged);
    _audioService.activeNumberValueNotifier.addListener(_onAudioStateChanged);
  }

  void _onAudioStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioStateChanged);
    _audioService.activeNumberValueNotifier.removeListener(_onAudioStateChanged);
    super.dispose();
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

      // Trigger celebratory confetti when reaching 5 or 10 completed!
      if (_completedIds.length == 5 || _completedIds.length == 10) {
        triggerConfetti();
      }
      notifyListeners();
    }
  }

  void triggerConfetti() {
    _showConfetti = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 1400), () {
      _showConfetti = false;
      notifyListeners();
    });
  }

  Future<void> playItem(NumberItem num, {bool isEnglish = false}) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: isEnglish);
  }

  Future<void> playAudio(NumberItem num) async {
    final isEn = _locale.languageCode == 'en';
    await playItem(num, isEnglish: isEn);
  }

  Future<void> playHindi(NumberItem num) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: false);
  }

  Future<void> playEnglish(NumberItem num) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: true);
  }

  Future<void> testVoice() async {
    if (!_soundEnabled) return;
    _audioService.speakText('नमस्ते! गिनती एक से दस तक सीखें।', 'hi-IN');
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
