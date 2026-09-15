
import '../models/reading_item.dart';

class AppData {
  static const List<ReadingItem> items = [
    // Level 1: Letters
    ReadingItem(1, 'अ', 'Letter A', 'assets/audio/hi/a_letter.mp3'),
    ReadingItem(1, 'आ', 'Letter Aa', 'assets/audio/hi/aa_letter.mp3'),
    ReadingItem(1, 'क', 'Letter Ka', 'assets/audio/hi/k_letter.mp3'),
    ReadingItem(1, 'ख', 'Letter Kha', 'assets/audio/hi/kh_letter.mp3'),
    ReadingItem(1, 'ग', 'Letter Ga', 'assets/audio/hi/g_letter.mp3'),
    // Level 2: 2-Letter Words
    ReadingItem(2, 'कल', 'Tomorrow', 'assets/audio/hi/kal.mp3'),
    ReadingItem(2, 'जल', 'Water', 'assets/audio/hi/jal.mp3'),
    ReadingItem(2, 'फल', 'Fruit', 'assets/audio/hi/phal.mp3'),
    ReadingItem(2, 'सच', 'Truth', 'assets/audio/hi/sach.mp3'),
    ReadingItem(2, 'घर', 'Home', 'assets/audio/hi/ghar.mp3'),
    // Level 3: 3-Letter Words
    ReadingItem(3, 'कमल', 'Lotus', 'assets/audio/hi/kamal.mp3'),
    ReadingItem(3, 'मटर', 'Peas', 'assets/audio/hi/matar.mp3'),
    ReadingItem(3, 'सड़क', 'Road', 'assets/audio/hi/sadak.mp3'),
    ReadingItem(3, 'कलम', 'Pen', 'assets/audio/hi/kalam.mp3'),
    ReadingItem(3, 'शहद', 'Honey', 'assets/audio/hi/shehad.mp3'),
    // Level 4: Phrases
    ReadingItem(4, 'मीठा आम', 'Sweet mango', 'assets/audio/hi/aam.mp3'),
    ReadingItem(4, 'शीतल जल', 'Cold water', 'assets/audio/hi/jal.mp3'),
    ReadingItem(4, 'सुंदर कमल', 'Beautiful lotus', 'assets/audio/hi/kamal.mp3'),
    ReadingItem(4, 'बड़ा घर', 'Big home', 'assets/audio/hi/ghar.mp3'),
    // Level 5: Sentences
    ReadingItem(5, 'यह मेरा घर है', 'This is my home', 'assets/audio/hi/s1_ghar.mp3'),
    ReadingItem(5, 'आम बहुत मीठा है', 'The mango is very sweet', 'assets/audio/hi/s2_aam.mp3'),
    ReadingItem(5, 'शीतल जल भर लो', 'Fill cold water', 'assets/audio/hi/s3_jal.mp3'),
    ReadingItem(5, 'कमल खिल गया', 'The lotus has bloomed', 'assets/audio/hi/s4_kamal.mp3'),
    ReadingItem(5, 'सूरज पूर्व से निकलता है', 'The sun rises in the east', 'assets/audio/hi/s5_suraj.mp3'),
  ];
}
