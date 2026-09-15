
class ReadingItem {
  final int level; // 1: letters, 2: easy words, 3: 3-letter, 4: phrases, 5: sentences
  final String hindi;
  final String english;
  final String audio;
  const ReadingItem(this.level, this.hindi, this.english, this.audio);
}
