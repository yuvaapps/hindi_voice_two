import 'package:flutter/material.dart';
import '../models/word_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  Set<String> _favoriteIds = {};
  int _score = 0;

  String _selectedCategory = 'all';
  String _searchQuery = '';
  String? _currentPlayingId;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  Set<String> get favoriteIds => _favoriteIds;
  int get score => _score;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
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
    final lang = StorageService.getLanguage();
    _locale = Locale(lang);
    _soundEnabled = StorageService.getSoundEnabled();
    _completedIds = StorageService.getCompletedItems().toSet();
    _favoriteIds = StorageService.getFavorites().toSet();
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
    if (!_soundEnabled) {
      await _audioService.stopAudio();
    }
    await StorageService.setSoundEnabled(_soundEnabled);
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    await StorageService.setFavorites(_favoriteIds.toList());
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

  Future<void> addScore(int points) async {
    _score += points;
    await StorageService.setScore(_score);
    notifyListeners();
  }

  Future<void> playWordAudio(WordItem item) async {
    if (!_soundEnabled) return;
    _currentPlayingId = item.id;
    notifyListeners();

    final audioPath = _locale.languageCode == 'en' ? item.englishAudio : item.hindiAudio;
    await _audioService.playAudio(audioPath);
  }

  Future<void> playCustomAudio(String path) async {
    if (!_soundEnabled) return;
    await _audioService.playAudio(path);
  }

  Future<void> stopAudio() async {
    await _audioService.stopAudio();
    _currentPlayingId = null;
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _favoriteIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setFavorites([]);
    await StorageService.setScore(0);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioStateChanged);
    super.dispose();
  }
}
