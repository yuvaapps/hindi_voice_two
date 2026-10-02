import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import '../models/num_trace.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioService._internal() {
    _init();
  }

  AudioPlayer? _player;
  bool _isPlaying = false;
  String? _currentAsset;
  int? _activeNumber;
  Timer? _ttsTimer;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentAssetNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<int?> activeNumberNotifier = ValueNotifier<int?>(null);

  bool get isPlaying => _isPlaying;
  String? get currentAsset => _currentAsset;
  int? get activeNumber => _activeNumber;

  void _init() {
    _player = AudioPlayer();
    _player?.onPlayerStateChanged.listen((state) {
      _isPlaying = (state == PlayerState.playing);
      isPlayingNotifier.value = _isPlaying;
      if (!_isPlaying) {
        _currentAsset = null;
        _activeNumber = null;
        currentAssetNotifier.value = null;
        activeNumberNotifier.value = null;
      }
    });

    _player?.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _currentAsset = null;
      _activeNumber = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      activeNumberNotifier.value = null;
    });
  }

  /// Primary method to play a number item in Hindi or English
  Future<void> playNumber(NumTrace item, {bool isEnglish = false}) async {
    final assetPath = isEnglish ? item.englishAudio : item.audio;
    final fallbackText = isEnglish ? item.englishName : item.name;
    final fallbackLang = isEnglish ? 'en-US' : 'hi-IN';

    _activeNumber = item.number;
    activeNumberNotifier.value = item.number;

    // Try local asset first
    if (assetPath.isNotEmpty) {
      final assetSuccess = await playAsset(assetPath);
      if (assetSuccess) return;
    }

    // Fallback to Web SpeechSynthesis
    speakText(fallbackText, fallbackLang, numberVal: item.number);
  }

  /// Plays a local asset audio file with error safety
  Future<bool> playAsset(String assetPath) async {
    try {
      if (_player == null) {
        _init();
      }

      await stopAudio();

      _currentAsset = assetPath;
      currentAssetNotifier.value = assetPath;
      _isPlaying = true;
      isPlayingNotifier.value = true;

      String cleanPath = assetPath;
      if (cleanPath.startsWith('assets/')) {
        cleanPath = cleanPath.substring('assets/'.length);
      }

      await _player?.play(AssetSource(cleanPath));
      return true;
    } catch (e) {
      debugPrint('AudioService: Local asset failed "$assetPath": $e');
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      return false;
    }
  }

  /// Web SpeechSynthesis with accurate Indian accent fallback
  void speakText(String text, String lang, {int? numberVal}) {
    if (kIsWeb) {
      try {
        stopAudio();
        _currentAsset = text;
        currentAssetNotifier.value = text;
        _isPlaying = true;
        isPlayingNotifier.value = true;
        if (numberVal != null) {
          _activeNumber = numberVal;
          activeNumberNotifier.value = numberVal;
        }

        js.context.callMethod('speakHindi', [text, lang]);

        _ttsTimer?.cancel();
        _ttsTimer = Timer(const Duration(milliseconds: 1400), () {
          _isPlaying = false;
          _currentAsset = null;
          _activeNumber = null;
          isPlayingNotifier.value = false;
          currentAssetNotifier.value = null;
          activeNumberNotifier.value = null;
        });
      } catch (e) {
        debugPrint('AudioService TTS Error: $e');
        _isPlaying = false;
        _activeNumber = null;
        isPlayingNotifier.value = false;
        activeNumberNotifier.value = null;
      }
    }
  }

  Future<void> pauseAudio() async {
    try {
      await _player?.pause();
      _isPlaying = false;
      isPlayingNotifier.value = false;
    } catch (e) {
      debugPrint('AudioService Error pausing: $e');
    }
  }

  Future<void> resumeAudio() async {
    try {
      await _player?.resume();
      _isPlaying = true;
      isPlayingNotifier.value = true;
    } catch (e) {
      debugPrint('AudioService Error resuming: $e');
    }
  }

  Future<void> stopAudio() async {
    _ttsTimer?.cancel();
    try {
      if (kIsWeb) {
        js.context.callMethod('eval', [
          'if (window.speechSynthesis) window.speechSynthesis.cancel();'
        ]);
      }
      await _player?.stop();
    } catch (e) {
      debugPrint('AudioService Error stopping: $e');
    } finally {
      _isPlaying = false;
      _currentAsset = null;
      _activeNumber = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      activeNumberNotifier.value = null;
    }
  }

  void dispose() {
    _ttsTimer?.cancel();
    _player?.dispose();
    _player = null;
  }
}
