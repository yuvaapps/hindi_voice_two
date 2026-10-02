import 'package:flutter/material.dart';
import '../models/practice_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String? _activeItemId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  bool get isAudioPlaying => _audioService.isPlaying;
  String? get activeItemId => _activeItemId;
  ValueNotifier<bool> get isAudioPlayingNotifier => _audioService.isPlayingNotifier;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(_onAudioStateChanged);
  }

  void _onAudioStateChanged() {
    if (!_audioService.isPlaying) {
      _activeItemId = null;
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
      _activeItemId = null;
    }
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

  Future<void> playItem(PracticeItem item) async {
    if (!_soundEnabled) return;
    _activeItemId = item.id;
    notifyListeners();
    await _audioService.playAudio(
      item.audio,
      textFallback: item.hindi,
      lang: 'hi-IN',
    );
  }

  Future<void> playAudio(String path, {String? textFallback, String lang = 'hi-IN'}) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path, textFallback: textFallback, lang: lang);
  }

  bool isItemPlaying(String id) {
    return isAudioPlaying && _activeItemId == id;
  }

  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    _activeItemId = null;
    notifyListeners();
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
