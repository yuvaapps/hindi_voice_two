import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import '../models/num100_item.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioService._internal() {
    _init();
  }

  AudioPlayer? _player;
  bool _isPlaying = false;
  String? _currentAsset;
  int? _activeNumberId;
  Timer? _ttsTimer;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentAssetNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<int?> activeNumberIdNotifier = ValueNotifier<int?>(null);

  bool get isPlaying => _isPlaying;
  String? get currentAsset => _currentAsset;
  int? get activeNumberId => _activeNumberId;

  void _init() {
    _player = AudioPlayer();
    _player?.onPlayerStateChanged.listen((state) {
      _isPlaying = (state == PlayerState.playing);
      isPlayingNotifier.value = _isPlaying;
      if (!_isPlaying) {
        _currentAsset = null;
        _activeNumberId = null;
        currentAssetNotifier.value = null;
        activeNumberIdNotifier.value = null;
      }
    });

    _player?.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _currentAsset = null;
      _activeNumberId = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      activeNumberIdNotifier.value = null;
    });
  }

  /// Primary method to play a number item in Hindi or English
  Future<void> playNumber(Num100Item item, {bool isEnglish = false}) async {
    final langCode = isEnglish ? 'en' : 'hi';
    final assetPath = 'assets/audio/$langCode/${item.audioKey}.mp3';
    final fallbackText = isEnglish ? item.englishName : item.hindiName;
    final fallbackLang = isEnglish ? 'en-US' : 'hi-IN';

    _activeNumberId = item.number;
    activeNumberIdNotifier.value = item.number;

    // Try asset first
    final assetSuccess = await playAsset(assetPath);
    if (!assetSuccess) {
      // Fallback to Web SpeechSynthesis
      speakText(fallbackText, fallbackLang, numberId: item.number);
    }
  }

  /// Plays a local asset audio file with safety guards
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
  void speakText(String text, String lang, {int? numberId}) {
    if (kIsWeb) {
      try {
        stopAudio();
        _currentAsset = text;
        currentAssetNotifier.value = text;
        _isPlaying = true;
        isPlayingNotifier.value = true;
        if (numberId != null) {
          _activeNumberId = numberId;
          activeNumberIdNotifier.value = numberId;
        }

        js.context.callMethod('speakHindi', [text, lang]);

        _ttsTimer?.cancel();
        _ttsTimer = Timer(const Duration(milliseconds: 1400), () {
          _isPlaying = false;
          _currentAsset = null;
          _activeNumberId = null;
          isPlayingNotifier.value = false;
          currentAssetNotifier.value = null;
          activeNumberIdNotifier.value = null;
        });
      } catch (e) {
        debugPrint('AudioService TTS Error: $e');
        _isPlaying = false;
        _activeNumberId = null;
        isPlayingNotifier.value = false;
        activeNumberIdNotifier.value = null;
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
      _activeNumberId = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      activeNumberIdNotifier.value = null;
    }
  }

  void dispose() {
    _ttsTimer?.cancel();
    _player?.dispose();
    _player = null;
  }
}
