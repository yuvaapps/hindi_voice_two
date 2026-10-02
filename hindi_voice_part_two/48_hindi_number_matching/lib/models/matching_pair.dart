class MatchingPair {
  final int number;
  final String devanagari;
  final String name;
  final String roman;
  final String englishName;
  final String tamil;
  final String emoji;
  final String audio;
  final String category;

  const MatchingPair({
    required this.number,
    required this.devanagari,
    required this.name,
    required this.roman,
    required this.englishName,
    required this.tamil,
    required this.emoji,
    required this.audio,
    this.category = 'Numbers',
  });
}
