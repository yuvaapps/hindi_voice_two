
class PracticeItem {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String audio;
  final String category;

  const PracticeItem(
    this.id,
    this.hindi,
    this.english,
    this.emoji,
    this.audio, {
    this.category = 'अभ्यास',
  });
}

