class FlashCard {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String hindiAudio;
  final String englishAudio;
  final String category;

  const FlashCard(
    this.id,
    this.hindi,
    this.english,
    this.emoji,
    this.hindiAudio,
    this.englishAudio, [
    this.category = 'general',
  ]);
}
