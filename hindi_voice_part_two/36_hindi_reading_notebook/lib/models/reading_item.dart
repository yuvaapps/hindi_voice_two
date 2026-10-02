class ReadingItem {
  final int level; // 1: letters, 2: 2-letter, 3: 3-letter, 4: 4-letter & phrases, 5: sentences
  final String hindi;
  final String english;
  final String audio;
  final String emoji;
  final String category;
  final String breakdown;

  const ReadingItem(
    this.level,
    this.hindi,
    this.english,
    this.audio, {
    this.emoji = '📖',
    this.category = 'पठन अभ्यास',
    this.breakdown = '',
  });
}
