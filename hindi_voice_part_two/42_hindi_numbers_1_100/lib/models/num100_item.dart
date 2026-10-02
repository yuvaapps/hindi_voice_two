class Num100Item {
  final int number;
  final String devanagari;
  final String hindiName;
  final String englishName;
  final String audioKey;
  final String transliteration;
  final String tamilName;

  const Num100Item(
    this.number,
    this.devanagari,
    this.hindiName,
    this.englishName,
    this.audioKey, {
    this.transliteration = '',
    this.tamilName = '',
  });

  /// Group tag for ranges (e.g. "1-20", "21-40", etc.)
  String get groupTag {
    if (number <= 20) return '1-20';
    if (number <= 40) return '21-40';
    if (number <= 60) return '41-60';
    if (number <= 80) return '61-80';
    return '81-100';
  }
}
