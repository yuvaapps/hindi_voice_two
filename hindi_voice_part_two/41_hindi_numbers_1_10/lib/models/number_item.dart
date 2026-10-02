class NumberItem {
  final int value;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String hindiAudio;
  final String englishAudio;
  final String objectEmoji;
  final String objectNameHindi;
  final String objectNameEnglish;
  final String transliteration;
  final String tamilName;

  const NumberItem({
    required this.value,
    required this.devanagari,
    required this.hindiName,
    required this.englishName,
    required this.hindiAudio,
    required this.englishAudio,
    required this.objectEmoji,
    this.objectNameHindi = '',
    this.objectNameEnglish = '',
    this.transliteration = '',
    this.tamilName = '',
  });
}
