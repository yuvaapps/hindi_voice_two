import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

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

  Future<void> playAudio(String assetPath) async {
    try {
      if (_player == null) {
        _init();
      }

      // Stop previous audio
      await stopAudio();

      _currentAsset = assetPath;
      currentAssetNotifier.value = assetPath;
      _isPlaying = true;
      isPlayingNotifier.value = true;

      // Clean asset path if it contains assets/ prefix
      String cleanPath = assetPath;
      if (cleanPath.startsWith('assets/')) {
        cleanPath = cleanPath.substring('assets/'.length);
      }

      await _player?.play(AssetSource(cleanPath));
    } catch (e, stackTrace) {
      debugPrint('AudioService Error playing asset "$assetPath": $e');
      debugPrint('$stackTrace');
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
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
