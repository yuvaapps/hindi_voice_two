class PronunNum {
  final int number;
  final String devanagari;
  final String hindiName;
  final String roman;
  final String englishName;
  final String tamil;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;
  final String category;

  const PronunNum({
    required this.number,
    required this.devanagari,
    required this.hindiName,
    required this.roman,
    required this.englishName,
    required this.tamil,
    required this.emoji,
    required this.hindiAudio,
    this.englishAudio = '',
    this.category = 'Numbers',
  });

  String get audio => hindiAudio;
}
