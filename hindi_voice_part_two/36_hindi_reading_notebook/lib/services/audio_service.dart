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
  Timer? _ttsTimer;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> currentAssetNotifier = ValueNotifier<String?>(null);

  bool get isPlaying => _isPlaying;
  String? get currentAsset => _currentAsset;

  static const Set<String> _knownHiAssets = {
    'a_letter.mp3', 'aa_letter.mp3', 'aam.mp3', 'aankh.mp3', 'aarav.mp3', 'aath.mp3',
    'ai_letter.mp3', 'am_letter.mp3', 'aman.mp3', 'amit.mp3', 'anaar.mp3', 'ananas.mp3',
    'ananya.mp3', 'angoor.mp3', 'au_letter.mp3', 'ba_letter.mp3', 'baadal.mp3', 'baal.mp3',
    'baarish.mp3', 'baazaar.mp3', 'bachha.mp3', 'bagicha.mp3', 'bandar.mp3', 'basta.mp3',
    'batan.mp3', 'behen.mp3', 'bha_letter.mp3', 'bhai.mp3', 'bhaloo.mp3', 'bhavan.mp3',
    'billi.mp3', 'bistar.mp3', 'bus.mp3', 'ch_letter.mp3', 'chaar.mp3', 'chamak.mp3',
    'chammach.mp3', 'chand.mp3', 'chashma.mp3', 'chh_letter.mp3', 'chhah.mp3', 'chhat.mp3',
    'chhatri.mp3', 'chidiya.mp3', 'cycle.mp3', 'd_letter.mp3', 'da_letter.mp3', 'daant.mp3',
    'dada.mp3', 'dadi.mp3', 'darwaza.mp3', 'das.mp3', 'dh_letter.mp3', 'dha_letter.mp3',
    'dhan.mp3', 'do.mp3', 'doodh.mp3', 'e_letter.mp3', 'ee_letter.mp3', 'ek.mp3',
    'g_letter.mp3', 'gaadi.mp3', 'gaay.mp3', 'gagan.mp3', 'garam.mp3', 'gend.mp3',
    'gh_letter.mp3', 'ghadi.mp3', 'ghar.mp3', 'ghoda.mp3', 'gilaas.mp3', 'ha_letter.mp3',
    'haath.mp3', 'haathi.mp3', 'hiran.mp3', 'i_letter.mp3', 'j_letter.mp3', 'jag.mp3',
    'jal.mp3', 'jh_letter.mp3', 'joota.mp3', 'k_letter.mp3', 'kaan.mp3', 'kabir.mp3',
    'kal.mp3', 'kalam.mp3', 'kamal.mp3', 'kap.mp3', 'katori.mp3', 'kela.mp3',
    'kh_letter.mp3', 'khaana.mp3', 'khargosh.mp3', 'khat.mp3', 'khidki.mp3', 'khushi.mp3',
    'kitaab.mp3', 'kursi.mp3', 'kurta.mp3', 'kutta.mp3', 'la_letter.mp3', 'ma_letter.mp3',
    'maa.mp3', 'machhli.mp3', 'magar.mp3', 'mat.mp3', 'matar.mp3', 'mez.mp3',
    'munh.mp3', 'na_letter.mp3', 'naak.mp3', 'naav.mp3', 'nadi.mp3', 'nal.mp3',
    'naram.mp3', 'nau.mp3', 'nayan.mp3', 'neha.mp3', 'o_letter.mp3', 'oo_letter.mp3',
    'pa_letter.mp3', 'paanch.mp3', 'paani.mp3', 'pair.mp3', 'pankha.mp3', 'papa.mp3',
    'papeeta.mp3', 'pawan.mp3', 'ped.mp3', 'pencil.mp3', 'pha_letter.mp3', 'phal.mp3',
    'phool.mp3', 'pooja.mp3', 'ra_letter.mp3', 'rahul.mp3', 'railgaadi.mp3', 'ri_letter.mp3',
    'riya.mp3', 'rohan.mp3', 'rubber.mp3', 'sa_letter.mp3', 'saat.mp3', 'sach.mp3',
    'sadak.mp3', 'santara.mp3', 'school.mp3', 'seb.mp3', 'sha_letter.mp3', 'shehad.mp3',
    'sher.mp3', 'sir.mp3', 'suraj.mp3', 't_letter.mp3', 'ta_letter.mp3', 'taare.mp3',
    'tanvi.mp3', 'tarbooj.mp3', 'teen.mp3', 'th_letter.mp3', 'tha_letter.mp3', 'thaali.mp3',
    'titli.mp3', 'topi.mp3', 'tota.mp3', 'u_letter.mp3', 'ungli.mp3', 'va_letter.mp3',
    'van.mp3', 'vimaan.mp3', 'ya_letter.mp3'
  };

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

  Future<void> playAudio(String assetPath, {String? textFallback, String lang = 'hi-IN'}) async {
    final fileName = assetPath.split('/').last;
    if (_knownHiAssets.contains(fileName)) {
      final success = await playAsset(assetPath);
      if (success) return;
    }

    if (textFallback != null && textFallback.isNotEmpty) {
      speakText(textFallback, lang);
    }
  }

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

  void speakText(String text, String lang) {
    if (kIsWeb) {
      try {
        stopAudio();
        _currentAsset = text;
        currentAssetNotifier.value = text;
        _isPlaying = true;
        isPlayingNotifier.value = true;

        js.context.callMethod('speakHindi', [text, lang]);

        _ttsTimer?.cancel();
        _ttsTimer = Timer(const Duration(milliseconds: 1400), () {
          _isPlaying = false;
          _currentAsset = null;
          isPlayingNotifier.value = false;
          currentAssetNotifier.value = null;
        });
      } catch (e) {
        debugPrint('AudioService TTS Error: $e');
        _isPlaying = false;
        isPlayingNotifier.value = false;
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
      isPlayingNotifier.value = false;
      currentAssetNotifier.value = null;
    }
  }

  void dispose() {
    _ttsTimer?.cancel();
    _player?.dispose();
    _player = null;
  }
}
