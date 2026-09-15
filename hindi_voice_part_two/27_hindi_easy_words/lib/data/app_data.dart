
import '../models/easy_word.dart';

class AppData {
  static const List<EasyWord> words = [
    // 2-Letter Words
    EasyWord(id: 'kal', hindi: 'कल', english: 'Tomorrow', letterCount: 2, letters: ['क', 'ल'], emoji: '📅', hindiAudio: 'assets/audio/hi/kal.mp3', englishAudio: 'assets/audio/en/kal.mp3'),
    EasyWord(id: 'jal', hindi: 'जल', english: 'Water', letterCount: 2, letters: ['ज', 'ल'], emoji: '💧', hindiAudio: 'assets/audio/hi/jal.mp3', englishAudio: 'assets/audio/en/jal.mp3'),
    EasyWord(id: 'phal', hindi: 'फल', english: 'Fruit', letterCount: 2, letters: ['फ', 'ल'], emoji: '🍎', hindiAudio: 'assets/audio/hi/phal.mp3', englishAudio: 'assets/audio/en/phal.mp3'),
    EasyWord(id: 'sach', hindi: 'सच', english: 'Truth', letterCount: 2, letters: ['स', 'च'], emoji: '✨', hindiAudio: 'assets/audio/hi/sach.mp3', englishAudio: 'assets/audio/en/sach.mp3'),
    EasyWord(id: 'nal', hindi: 'नल', english: 'Tap', letterCount: 2, letters: ['न', 'ल'], emoji: '🚰', hindiAudio: 'assets/audio/hi/nal.mp3', englishAudio: 'assets/audio/en/nal.mp3'),
    EasyWord(id: 'ghar', hindi: 'घर', english: 'Home', letterCount: 2, letters: ['घ', 'र'], emoji: '🏠', hindiAudio: 'assets/audio/hi/ghar.mp3', englishAudio: 'assets/audio/en/ghar.mp3'),
    EasyWord(id: 'jag', hindi: 'जग', english: 'Jug', letterCount: 2, letters: ['ज', 'ग'], emoji: '🫖', hindiAudio: 'assets/audio/hi/jag.mp3', englishAudio: 'assets/audio/en/jag.mp3'),
    EasyWord(id: 'bus', hindi: 'बस', english: 'Bus', letterCount: 2, letters: ['ब', 'स'], emoji: '🚌', hindiAudio: 'assets/audio/hi/bus.mp3', englishAudio: 'assets/audio/en/bus.mp3'),
    EasyWord(id: 'dhan', hindi: 'धन', english: 'Wealth', letterCount: 2, letters: ['ध', 'न'], emoji: '💰', hindiAudio: 'assets/audio/hi/dhan.mp3', englishAudio: 'assets/audio/en/dhan.mp3'),
    EasyWord(id: 'khat', hindi: 'खत', english: 'Letter', letterCount: 2, letters: ['ख', 'त'], emoji: '✉️', hindiAudio: 'assets/audio/hi/khat.mp3', englishAudio: 'assets/audio/en/khat.mp3'),
    EasyWord(id: 'van', hindi: 'वन', english: 'Forest', letterCount: 2, letters: ['व', 'न'], emoji: '🌲', hindiAudio: 'assets/audio/hi/van.mp3', englishAudio: 'assets/audio/en/van.mp3'),
    EasyWord(id: 'kap', hindi: 'कप', english: 'Cup', letterCount: 2, letters: ['क', 'प'], emoji: '☕', hindiAudio: 'assets/audio/hi/kap.mp3', englishAudio: 'assets/audio/en/kap.mp3'),

    // 3-Letter Words
    EasyWord(id: 'kamal', hindi: 'कमल', english: 'Lotus', letterCount: 3, letters: ['क', 'म', 'ल'], emoji: '🪷', hindiAudio: 'assets/audio/hi/kamal.mp3', englishAudio: 'assets/audio/en/kamal.mp3'),
    EasyWord(id: 'matar', hindi: 'मटर', english: 'Peas', letterCount: 3, letters: ['म', 'ट', 'र'], emoji: '🫛', hindiAudio: 'assets/audio/hi/matar.mp3', englishAudio: 'assets/audio/en/matar.mp3'),
    EasyWord(id: 'sadak', hindi: 'सड़क', english: 'Road', letterCount: 3, letters: ['स', 'ड़', 'क'], emoji: '🛣️', hindiAudio: 'assets/audio/hi/sadak.mp3', englishAudio: 'assets/audio/en/sadak.mp3'),
    EasyWord(id: 'kalam', hindi: 'कलम', english: 'Pen', letterCount: 3, letters: ['क', 'ल', 'म'], emoji: '🖊️', hindiAudio: 'assets/audio/hi/kalam.mp3', englishAudio: 'assets/audio/en/kalam.mp3'),
    EasyWord(id: 'gagan', hindi: 'गगन', english: 'Sky', letterCount: 3, letters: ['ग', 'ग', 'न'], emoji: '☁️', hindiAudio: 'assets/audio/hi/gagan.mp3', englishAudio: 'assets/audio/en/gagan.mp3'),
    EasyWord(id: 'magar', hindi: 'मगर', english: 'Crocodile', letterCount: 3, letters: ['म', 'ग', 'र'], emoji: '🐊', hindiAudio: 'assets/audio/hi/magar.mp3', englishAudio: 'assets/audio/en/magar.mp3'),
    EasyWord(id: 'nayan', hindi: 'नयन', english: 'Eye', letterCount: 3, letters: ['न', 'य', 'न'], emoji: '👁️', hindiAudio: 'assets/audio/hi/nayan.mp3', englishAudio: 'assets/audio/en/nayan.mp3'),
    EasyWord(id: 'pawan', hindi: 'पवन', english: 'Wind', letterCount: 3, letters: ['प', 'व', 'न'], emoji: '💨', hindiAudio: 'assets/audio/hi/pawan.mp3', englishAudio: 'assets/audio/en/pawan.mp3'),
    EasyWord(id: 'shehad', hindi: 'शहद', english: 'Honey', letterCount: 3, letters: ['श', 'ह', 'द'], emoji: '🍯', hindiAudio: 'assets/audio/hi/shehad.mp3', englishAudio: 'assets/audio/en/shehad.mp3'),
    EasyWord(id: 'bhavan', hindi: 'भवन', english: 'Building', letterCount: 3, letters: ['भ', 'व', 'न'], emoji: '🏛️', hindiAudio: 'assets/audio/hi/bhavan.mp3', englishAudio: 'assets/audio/en/bhavan.mp3'),
    EasyWord(id: 'batan', hindi: 'बटन', english: 'Button', letterCount: 3, letters: ['ब', 'ट', 'न'], emoji: '🔘', hindiAudio: 'assets/audio/hi/batan.mp3', englishAudio: 'assets/audio/en/batan.mp3'),
  ];
}
