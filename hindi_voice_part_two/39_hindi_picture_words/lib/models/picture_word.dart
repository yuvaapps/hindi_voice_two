class PictureWord {
  final String id;
  final String hindi;
  final String english;
  final String emoji;
  final String audio;
  final String englishAudio;
  final String category;

  const PictureWord(
    this.id,
    this.hindi,
    this.english,
    this.emoji,
    this.audio, [
    this.englishAudio = '',
    this.category = 'general',
  ]);
}
