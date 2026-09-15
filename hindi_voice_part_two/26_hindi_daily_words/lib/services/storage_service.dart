import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyLanguage = 'selected_language';
  static const String _keySound = 'sound_enabled';
  static const String _keyCompleted = 'completed_items';
  static const String _keyScore = 'practice_score';
  static const String _keyFavorites = 'favorite_items';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static String getLanguage() {
    return _prefs?.getString(_keyLanguage) ?? 'hi';
  }

  static Future<void> setLanguage(String lang) async {
    await _prefs?.setString(_keyLanguage, lang);
  }

  static bool getSoundEnabled() {
    return _prefs?.getBool(_keySound) ?? true;
  }

  static Future<void> setSoundEnabled(bool enabled) async {
    await _prefs?.setBool(_keySound, enabled);
  }

  static List<String> getCompletedItems() {
    return _prefs?.getStringList(_keyCompleted) ?? [];
  }

  static Future<void> setCompletedItems(List<String> items) async {
    await _prefs?.setStringList(_keyCompleted, items);
  }

  static int getScore() {
    return _prefs?.getInt(_keyScore) ?? 0;
  }

  static Future<void> setScore(int score) async {
    await _prefs?.setInt(_keyScore, score);
  }

  static List<String> getFavorites() {
    return _prefs?.getStringList(_keyFavorites) ?? [];
  }

  static Future<void> setFavorites(List<String> favorites) async {
    await _prefs?.setStringList(_keyFavorites, favorites);
  }
}
