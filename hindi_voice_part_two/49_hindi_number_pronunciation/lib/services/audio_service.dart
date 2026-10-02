import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  AudioService._internal() {
    if (!kIsWeb) _init();
  }

  AudioPlayer? _player;
  bool _isPlaying = false;
  String? _currentAsset;
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentAssetNotifier =
      ValueNotifier<String?>(null);

  bool get isPlaying => _isPlaying;
  String? get currentAsset => _currentAsset;

  void _init() {
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

  Future<void> playAudio(String assetPath,
      {String? textFallback, bool slow = false}) async {
    try {
      await stopAudio();

      _currentAsset = assetPath;
      currentAssetNotifier.value = assetPath;
      _isPlaying = true;
      isPlayingNotifier.value = true;

      if (kIsWeb) {
        final fileName = assetPath.split('/').last.replaceAll('.mp3', '');
        final toSpeak = textFallback ?? fileName;

        try {
          js.context.callMethod('speakHindi', [toSpeak, slow]);
        } catch (e) {
          debugPrint('Web TTS speakHindi failed: $e');
        }

        // Live soundwave simulation duration (longer for slow speech)
        final durationMs = slow ? 2400 : 1600;
        await Future.delayed(Duration(milliseconds: durationMs));
        _isPlaying = false;
        isPlayingNotifier.value = false;
        _currentAsset = null;
        currentAssetNotifier.value = null;
      } else {
        if (_player == null) _init();
        String cleanPath = assetPath;
        if (cleanPath.startsWith('assets/')) {
          cleanPath = cleanPath.substring('assets/'.length);
        }
        if (slow) {
          await _player?.setPlaybackRate(0.65);
        } else {
          await _player?.setPlaybackRate(1.0);
        }
        await _player?.play(AssetSource(cleanPath));
      }
    } catch (e) {
      debugPrint('AudioService Error: $e');
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
    }
  }

  Future<void> speakWord(String text, {bool slow = false}) async {
    try {
      await stopAudio();
      _isPlaying = true;
      isPlayingNotifier.value = true;

      if (kIsWeb) {
        try {
          js.context.callMethod('speakHindi', [text, slow]);
        } catch (_) {}
        final durationMs = slow ? 2400 : 1600;
        await Future.delayed(Duration(milliseconds: durationMs));
        _isPlaying = false;
        isPlayingNotifier.value = false;
      }
    } catch (_) {
      _isPlaying = false;
      isPlayingNotifier.value = false;
    }
  }

  Future<void> stopAudio() async {
    try {
      if (!kIsWeb) {
        await _player?.stop();
      } else {
        try {
          js.context.callMethod('stopSpeech');
        } catch (_) {}
      }
    } catch (_) {}
    _isPlaying = false;
    _currentAsset = null;
    isPlayingNotifier.value = false;
    currentAssetNotifier.value = null;
  }

  Future<void> pauseAudio() async {
    try {
      if (!kIsWeb) await _player?.pause();
      _isPlaying = false;
      isPlayingNotifier.value = false;
    } catch (e) {
      debugPrint('AudioService pause error: $e');
    }
  }

  Future<void> resumeAudio() async {
    try {
      if (!kIsWeb) await _player?.resume();
      _isPlaying = true;
      isPlayingNotifier.value = true;
    } catch (e) {
      debugPrint('AudioService resume error: $e');
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
