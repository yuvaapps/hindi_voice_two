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

  Future<void> playWord({
    required String wordId,
    required String assetPath,
    required String text,
    required String lang,
  }) async {
    final success = await playAudio(assetPath);
    if (!success) {
      speakText(text, lang);
    }
  }

  Future<bool> playAudio(String assetPath) async {
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
      debugPrint('AudioService Error playing asset "$assetPath": $e');
      _isPlaying = false;
      _currentAsset = null;
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
      return false;
    }
  }

  void speakText(String text, String lang) {
    if (kIsWeb) {
      try {
        final sanitized = text.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll('"', r'\"');
        js.context.callMethod('eval', [
          '''
          (function() {
            try {
              if (window.speechSynthesis) {
                if (window.speechSynthesis.paused) {
                  window.speechSynthesis.resume();
                }
                window.speechSynthesis.cancel();
                var u = new SpeechSynthesisUtterance("$sanitized");
                u.lang = "$lang";
                u.rate = 0.85;
                var voices = window.speechSynthesis.getVoices();
                if (voices && voices.length > 0) {
                  var targetPrefix = "$lang".substring(0, 2).toLowerCase();
                  for (var i = 0; i < voices.length; i++) {
                    if (voices[i].lang.toLowerCase().indexOf(targetPrefix) !== -1) {
                      u.voice = voices[i];
                      break;
                    }
                  }
                }
                window.speechSynthesis.speak(u);
              }
            } catch(e) {
              console.warn("Speech synthesis error", e);
            }
          })()
          '''
        ]);

        _isPlaying = true;
        isPlayingNotifier.value = true;
        Timer(const Duration(milliseconds: 1400), () {
          _isPlaying = false;
          _currentAsset = null;
          isPlayingNotifier.value = false;
          currentAssetNotifier.value = null;
        });
      } catch (e) {
        debugPrint('speakText Web error: $e');
        _isPlaying = false;
        isPlayingNotifier.value = false;
      }
    }
  }

  Future<void> stopAudio() async {
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
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
    }
  }

  void dispose() {
    _player?.dispose();
    _player = null;
  }
}
