class PromptItem {
  final String text;
  final String audio;
  final String english;
  final String emoji;
  final String category;

  const PromptItem(
    this.text,
    this.audio, {
    this.english = '',
    this.emoji = '✍️',
    this.category = 'शब्द',
  });
}
