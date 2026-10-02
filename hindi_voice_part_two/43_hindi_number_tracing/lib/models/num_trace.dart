class NumTrace {
  final int number;
  final String devanagari;
  final String name; // Hindi Name (e.g. "एक")
  final String englishName; // English Name (e.g. "One")
  final String transliteration; // Transliteration (e.g. "Ek")
  final String tamilName; // Tamil Name (e.g. "ஒன்று")
  final String audio;
  final String englishAudio;
  final String emoji;
  final String objectLabel;

  const NumTrace({
    required this.number,
    required this.devanagari,
    required this.name,
    required this.englishName,
    required this.audio,
    this.englishAudio = '',
    this.transliteration = '',
    this.tamilName = '',
    this.emoji = '🔢',
    this.objectLabel = '',
  });
}
