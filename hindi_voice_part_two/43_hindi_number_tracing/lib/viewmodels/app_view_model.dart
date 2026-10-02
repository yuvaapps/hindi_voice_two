import 'package:flutter/material.dart';
import '../models/num_trace.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  bool _showConfetti = false;

  Color _strokeColor = const Color(0xFFE91E63);
  double _strokeWidth = 14.0;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  bool get showConfetti => _showConfetti;
  AudioService get audioService => _audioService;
  Color get strokeColor => _strokeColor;
  double get strokeWidth => _strokeWidth;

  bool get isPlaying => _audioService.isPlaying;
  int? get activeNumber => _audioService.activeNumber;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(_onAudioStateChanged);
    _audioService.activeNumberNotifier.addListener(_onAudioStateChanged);
  }

  void _onAudioStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioStateChanged);
    _audioService.activeNumberNotifier.removeListener(_onAudioStateChanged);
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

  void setStrokeColor(Color color) {
    _strokeColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _strokeWidth = width;
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
      _score += 15;
      await StorageService.setScore(_score);

      // Trigger celebratory confetti on milestones
      if (_completedIds.length % 5 == 0 || _completedIds.length == 10 || _completedIds.length == 20) {
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

  Future<void> playItem(NumTrace num, {bool isEnglish = false}) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: isEnglish);
  }

  Future<void> playHindi(NumTrace num) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: false);
  }

  Future<void> playEnglish(NumTrace num) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(num, isEnglish: true);
  }

  Future<void> playAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAsset(path);
  }

  Future<void> testVoice() async {
    if (!_soundEnabled) return;
    _audioService.speakText('नमस्ते! हिंदी संख्या अनुरेखण का अभ्यास करें।', 'hi-IN');
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
