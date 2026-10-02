import 'package:flutter/material.dart';
import '../models/num100_item.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';

class AppViewModel extends ChangeNotifier {
  final AudioService _audioService = AudioService();

  Locale _locale = const Locale('hi');
  bool _soundEnabled = true;
  Set<String> _completedIds = {};
  int _score = 0;
  String _searchQuery = '';
  String _selectedRange = 'All';
  bool _showConfetti = false;
  Num100Item? _selectedItem;

  Locale get locale => _locale;
  bool get soundEnabled => _soundEnabled;
  Set<String> get completedIds => _completedIds;
  int get score => _score;
  String get searchQuery => _searchQuery;
  String get selectedRange => _selectedRange;
  bool get showConfetti => _showConfetti;
  Num100Item? get selectedItem => _selectedItem;
  AudioService get audioService => _audioService;

  bool get isPlaying => _audioService.isPlaying;
  int? get activeNumberId => _audioService.activeNumberId;

  AppViewModel() {
    _load();
    _audioService.isPlayingNotifier.addListener(_onAudioStateChanged);
    _audioService.activeNumberIdNotifier.addListener(_onAudioStateChanged);
  }

  void _onAudioStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.isPlayingNotifier.removeListener(_onAudioStateChanged);
    _audioService.activeNumberIdNotifier.removeListener(_onAudioStateChanged);
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

  void setSearch(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  void setRange(String range) {
    _selectedRange = range;
    notifyListeners();
  }

  void selectItem(Num100Item? item) {
    _selectedItem = item;
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
      _score += 10;
      await StorageService.setScore(_score);

      // Trigger celebratory confetti on milestones (e.g. 10, 20, 50, 100) or every 5
      if (_completedIds.length % 5 == 0 || _completedIds.length == 100) {
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

  Future<void> playItem(Num100Item item, {bool isEnglish = false}) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(item, isEnglish: isEnglish);
  }

  Future<void> playAudio(Num100Item item) async {
    final isEn = _locale.languageCode == 'en';
    await playItem(item, isEnglish: isEn);
  }

  Future<void> playHindi(Num100Item item) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(item, isEnglish: false);
  }

  Future<void> playEnglish(Num100Item item) async {
    if (!_soundEnabled) return;
    await _audioService.playNumber(item, isEnglish: true);
  }

  Future<void> testVoice() async {
    if (!_soundEnabled) return;
    _audioService.speakText('नमस्ते! गिनती एक से सौ तक सीखें।', 'hi-IN');
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    _score = 0;
    await StorageService.setCompletedItems([]);
    await StorageService.setScore(0);
    notifyListeners();
  }
}
