import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioService._internal() {
    _init();
  }

  AudioPlayer? _player;
  bool _isPlaying = false;
  String? _currentAsset;
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentAssetNotifier = ValueNotifier<String?>(null);

  bool get isPlaying => _isPlaying;
  String? get currentAsset => _currentAsset;

  void _init() {
    if (!kIsWeb) {
      _player = AudioPlayer();
      _player?.onPlayerStateChanged.listen((state) {
        _isPlaying = (state == PlayerState.playing);
        isPlayingNotifier.value = _isPlaying;
        if (!_isPlaying) {
          _currentAsset = null;
          currentAssetNotifier.value = null;
        }
      });
      _player?.onPlayerComplete.listen((_) {
        _isPlaying = false;
        _currentAsset = null;
        isPlayingNotifier.value = false;
        currentAssetNotifier.value = null;
      });
    }
  }

  Future<void> playAudio(String assetPath) async {
    try {
      await stopAudio();

      _currentAsset = assetPath;
      currentAssetNotifier.value = assetPath;
      _isPlaying = true;
      isPlayingNotifier.value = true;

      if (kIsWeb) {
        // Extract Hindi word from asset path for TTS
        final word = _extractWordFromPath(assetPath);
        _speakWeb(word);
        // Simulate end after 1.5 seconds
        Future.delayed(const Duration(milliseconds: 1500), () {
          _isPlaying = false;
          _currentAsset = null;
          isPlayingNotifier.value = false;
          currentAssetNotifier.value = null;
        });
      } else {
        if (_player == null) _init();
        String cleanPath = assetPath;
        if (cleanPath.startsWith('assets/')) {
          cleanPath = cleanPath.substring('assets/'.length);
        }
        await _player?.play(AssetSource(cleanPath));
      }
    } catch (e, stackTrace) {
      debugPrint('AudioService Error playing asset "$assetPath": $e');
      debugPrint('$stackTrace');
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
    }
  }

  /// Speak a Hindi word using the browser's SpeechSynthesis API via window.speakHindi
  void _speakWeb(String text) {
    try {
      js.context.callMethod('speakHindi', [text]);
    } catch (e) {
      debugPrint('Web TTS fallback failed: $e');
    }
  }

  /// Extract the roman/hindi keyword from asset path
  String _extractWordFromPath(String assetPath) {
    final fileName = assetPath.split('/').last.replaceAll('.mp3', '');
    return fileName;
  }

  Future<void> speakText(String hindiText) async {
    try {
      _isPlaying = true;
      isPlayingNotifier.value = true;
      if (kIsWeb) {
        _speakWeb(hindiText);
        Future.delayed(const Duration(milliseconds: 1500), () {
          _isPlaying = false;
          isPlayingNotifier.value = false;
        });
      }
    } catch (e) {
      debugPrint('AudioService TTS error: $e');
      _isPlaying = false;
      isPlayingNotifier.value = false;
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
    try {
      await _player?.stop();
    } catch (e) {
      debugPrint('AudioService Error stopping: $e');
    } finally {
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
