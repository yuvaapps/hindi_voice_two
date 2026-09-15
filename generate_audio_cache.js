const fs = require('fs');
const path = require('path');
const googleTTS = require('C:/Users/yuvadharshini/.gemini/antigravity-ide/brain/7f67153e-095f-4293-8abb-6aa0958374f7/scratch/tts_test/node_modules/google-tts-api');

const cacheDirHi = 'E:/hindi_voice_two/master_audio_cache/hi';
const cacheDirEn = 'E:/hindi_voice_two/master_audio_cache/en';

if (!fs.existsSync(cacheDirHi)) fs.mkdirSync(cacheDirHi, { recursive: true });
if (!fs.existsSync(cacheDirEn)) fs.mkdirSync(cacheDirEn, { recursive: true });

// Numbers 1 to 100
const hindiNumberWords = [
  "", "एक", "दो", "तीन", "चार", "पाँच", "छह", "सात", "आठ", "नौ", "दस",
  "ग्यारह", "बारह", "तेरह", "चौदह", "पंद्रह", "सोलह", "सत्रह", "अठारह", "उन्नीस", "बीस",
  "इक्कीस", "बाईस", "तेईस", "चौबीस", "पच्चीस", "छब्बीस", "सत्ताईस", "अट्ठाईस", "उनतीस", "तीस",
  "इकत्तीस", "बत्तीस", "तैंतीस", "चौंतीस", "पैंतीस", "छत्तीस", "सैंतीस", "अड़तीस", "उनतालीस", "चालीस",
  "इकतालीस", "बयालीस", "तैंतालीस", "चवालीस", "पैंतालीस", "छियालीस", "सैंतालीस", "अड़तालीस", "उनचास", "पचास",
  "इक्यावन", "बावन", "तिरेपन", "चौवन", "पचपन", "छप्पन", "सत्तावन", "अट्ठावन", "उनसठ", "साठ",
  "इकसठ", "बासठ", "तिरसठ", "चौंसठ", "पैंसठ", "छियासठ", "सरसठ", "अड़सठ", "उनहत्तर", "सत्तर",
  "इकहत्तर", "बहत्तर", "तिहत्तर", "चौहत्तर", "पचहत्तर", "छिहत्तर", "सतहत्तर", "अठहत्तर", "उन्यासी", "अस्सी",
  "इक्यासी", "बयासी", "तिरासी", "चौरासी", "पचासी", "छियासी", "सत्तासी", "अट्ठासी", "नवासी", "नब्बे",
  "इक्यानवे", "बानवे", "तिरानवे", "चौरानवे", "पंचानवे", "छियानवे", "सत्तानवे", "अट्ठानवे", "निन्यानवे", "सौ"
];

const englishNumberWords = [
  "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
  "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty",
  "Twenty-one", "Twenty-two", "Twenty-three", "Twenty-four", "Twenty-five", "Twenty-six", "Twenty-seven", "Twenty-eight", "Twenty-nine", "Thirty",
  "Thirty-one", "Thirty-two", "Thirty-three", "Thirty-four", "Thirty-five", "Thirty-six", "Thirty-seven", "Thirty-eight", "Thirty-nine", "Forty",
  "Forty-one", "Forty-two", "Forty-three", "Forty-four", "Forty-five", "Forty-six", "Forty-seven", "Forty-eight", "Forty-nine", "Fifty",
  "Fifty-one", "Fifty-two", "Fifty-three", "Fifty-four", "Fifty-five", "Fifty-six", "Fifty-seven", "Fifty-eight", "Fifty-nine", "Sixty",
  "Sixty-one", "Sixty-two", "Sixty-three", "Sixty-four", "Sixty-five", "Sixty-six", "Sixty-seven", "Sixty-eight", "Sixty-nine", "Seventy",
  "Seventy-one", "Seventy-two", "Seventy-three", "Seventy-four", "Seventy-five", "Seventy-six", "Seventy-seven", "Seventy-eight", "Seventy-nine", "Eighty",
  "Eighty-one", "Eighty-two", "Eighty-three", "Eighty-four", "Eighty-five", "Eighty-six", "Eighty-seven", "Eighty-eight", "Eighty-nine", "Ninety",
  "Ninety-one", "Ninety-two", "Ninety-three", "Ninety-four", "Ninety-five", "Ninety-six", "Ninety-seven", "Ninety-eight", "Ninety-nine", "One Hundred"
];

const audioDictionary = [
  // Numbers 1 to 10
  { key: 'ek', hi: 'एक', en: 'One' },
  { key: 'do', hi: 'दो', en: 'Two' },
  { key: 'teen', hi: 'तीन', en: 'Three' },
  { key: 'chaar', hi: 'चार', en: 'Four' },
  { key: 'paanch', hi: 'पाँच', en: 'Five' },
  { key: 'chhah', hi: 'छह', en: 'Six' },
  { key: 'saat', hi: 'सात', en: 'Seven' },
  { key: 'aath', hi: 'आठ', en: 'Eight' },
  { key: 'nau', hi: 'नौ', en: 'Nine' },
  { key: 'das', hi: 'दस', en: 'Ten' },

  // Toddler & First Words
  { key: 'maa', hi: 'माँ', en: 'Mother' },
  { key: 'papa', hi: 'पापा', en: 'Father' },
  { key: 'paani', hi: 'पानी', en: 'Water' },
  { key: 'doodh', hi: 'दूध', en: 'Milk' },
  { key: 'khaana', hi: 'खाना', en: 'Food' },
  { key: 'ghar', hi: 'घर', en: 'Home' },
  { key: 'gend', hi: 'गेंद', en: 'Ball' },
  { key: 'billi', hi: 'बिल्ली', en: 'Cat' },
  { key: 'kutta', hi: 'कुत्ता', en: 'Dog' },
  { key: 'bachha', hi: 'बच्चा', en: 'Baby' },
  { key: 'bhai', hi: 'भाई', en: 'Brother' },
  { key: 'behen', hi: 'बहन', en: 'Sister' },
  { key: 'dada', hi: 'दादा', en: 'Grandfather' },
  { key: 'dadi', hi: 'दादी', en: 'Grandmother' },

  // Fruits
  { key: 'aam', hi: 'आम', en: 'Mango' },
  { key: 'seb', hi: 'सेब', en: 'Apple' },
  { key: 'kela', hi: 'केला', en: 'Banana' },
  { key: 'angoor', hi: 'अंगूर', en: 'Grapes' },
  { key: 'santara', hi: 'संतरा', en: 'Orange' },
  { key: 'papeeta', hi: 'पपीता', en: 'Papaya' },
  { key: 'tarbooj', hi: 'तरबूज', en: 'Watermelon' },
  { key: 'ananas', hi: 'अनानास', en: 'Pineapple' },
  { key: 'anaar', hi: 'अनार', en: 'Pomegranate' },

  // Animals
  { key: 'haathi', hi: 'हाथी', en: 'Elephant' },
  { key: 'sher', hi: 'शेर', en: 'Lion' },
  { key: 'bandar', hi: 'बंदर', en: 'Monkey' },
  { key: 'gaay', hi: 'गाय', en: 'Cow' },
  { key: 'ghoda', hi: 'घोड़ा', en: 'Horse' },
  { key: 'bhaloo', hi: 'भालू', en: 'Bear' },
  { key: 'khargosh', hi: 'खरगोश', en: 'Rabbit' },
  { key: 'hiran', hi: 'हिरण', en: 'Deer' },
  { key: 'machhli', hi: 'मछली', en: 'Fish' },
  { key: 'titli', hi: 'तितली', en: 'Butterfly' },
  { key: 'chidiya', hi: 'चिड़िया', en: 'Bird' },
  { key: 'tota', hi: 'तोता', en: 'Parrot' },

  // Daily Objects & Home
  { key: 'kitaab', hi: 'किताब', en: 'Book' },
  { key: 'kalam', hi: 'कलम', en: 'Pen' },
  { key: 'pencil', hi: 'पेंसिल', en: 'Pencil' },
  { key: 'rubber', hi: 'रबर', en: 'Eraser' },
  { key: 'basta', hi: 'बस्ता', en: 'School Bag' },
  { key: 'pankha', hi: 'पंखा', en: 'Fan' },
  { key: 'kursi', hi: 'कुर्सी', en: 'Chair' },
  { key: 'mez', hi: 'मेज', en: 'Table' },
  { key: 'darwaza', hi: 'दरवाजा', en: 'Door' },
  { key: 'khidki', hi: 'खड़की', en: 'Window' },
  { key: 'bistar', hi: 'बिस्तर', en: 'Bed' },
  { key: 'gilaas', hi: 'गिलास', en: 'Glass' },
  { key: 'thaali', hi: 'थाली', en: 'Plate' },
  { key: 'katori', hi: 'कटोरी', en: 'Bowl' },
  { key: 'chammach', hi: 'चम्मच', en: 'Spoon' },
  { key: 'ghadi', hi: 'घड़ी', en: 'Clock' },
  { key: 'chhatri', hi: 'छतरी', en: 'Umbrella' },
  { key: 'chashma', hi: 'चश्मा', en: 'Spectacles' },
  { key: 'joota', hi: 'जूता', en: 'Shoes' },
  { key: 'topi', hi: 'टोपी', en: 'Cap' },
  { key: 'kurta', hi: 'कुर्ता', en: 'Shirt' },

  // School, Actions, Nature, Places
  { key: 'school', hi: 'स्कूल', en: 'School' },
  { key: 'bagicha', hi: 'बगीचा', en: 'Garden' },
  { key: 'baazaar', hi: 'बाज़ार', en: 'Market' },
  { key: 'suraj', hi: 'सूरज', en: 'Sun' },
  { key: 'chand', hi: 'चाँद', en: 'Moon' },
  { key: 'taare', hi: 'तारे', en: 'Stars' },
  { key: 'ped', hi: 'पेड़', en: 'Tree' },
  { key: 'phool', hi: 'फूल', en: 'Flower' },
  { key: 'baadal', hi: 'बादल', en: 'Cloud' },
  { key: 'nadi', hi: 'नदी', en: 'River' },
  { key: 'baarish', hi: 'बारिश', en: 'Rain' },
  { key: 'gaadi', hi: 'गाड़ी', en: 'Car' },
  { key: 'bus', hi: 'बस', en: 'Bus' },
  { key: 'railgaadi', hi: 'रेलगाड़ी', en: 'Train' },
  { key: 'vimaan', hi: 'विमान', en: 'Airplane' },
  { key: 'cycle', hi: 'साइकिल', en: 'Bicycle' },
  { key: 'naav', hi: 'नाव', en: 'Boat' },

  // Body Parts
  { key: 'aankh', hi: 'आँख', en: 'Eye' },
  { key: 'kaan', hi: 'कान', en: 'Ear' },
  { key: 'naak', hi: 'नाक', en: 'Nose' },
  { key: 'munh', hi: 'मुँह', en: 'Mouth' },
  { key: 'haath', hi: 'हाथ', en: 'Hand' },
  { key: 'pair', hi: 'पैर', en: 'Foot' },
  { key: 'sir', hi: 'सिर', en: 'Head' },
  { key: 'baal', hi: 'बाल', en: 'Hair' },
  { key: 'daant', hi: 'दाँत', en: 'Teeth' },
  { key: 'ungli', hi: 'उंगली', en: 'Finger' },

  // 2-Letter Words
  { key: 'kal', hi: 'कल', en: 'Tomorrow' },
  { key: 'jal', hi: 'जल', en: 'Water' },
  { key: 'phal', hi: 'फल', en: 'Fruit' },
  { key: 'sach', hi: 'सच', en: 'Truth' },
  { key: 'nal', hi: 'नल', en: 'Tap' },
  { key: 'jag', hi: 'जग', en: 'Jug' },
  { key: 'dhan', hi: 'धन', en: 'Wealth' },
  { key: 'khat', hi: 'खत', en: 'Letter' },
  { key: 'van', hi: 'वन', en: 'Forest' },
  { key: 'kap', hi: 'कप', en: 'Cup' },
  { key: 'chhat', hi: 'छत', en: 'Roof' },
  { key: 'mat', hi: 'मत', en: 'Do Not' },

  // 3-Letter Words
  { key: 'kamal', hi: 'कमल', en: 'Lotus' },
  { key: 'matar', hi: 'मटर', en: 'Peas' },
  { key: 'sadak', hi: 'सड़क', en: 'Road' },
  { key: 'gagan', hi: 'गगन', en: 'Sky' },
  { key: 'magar', hi: 'मगर', en: 'Crocodile' },
  { key: 'nayan', hi: 'नयन', en: 'Eye' },
  { key: 'pawan', hi: 'पवन', en: 'Wind' },
  { key: 'shehad', hi: 'शहद', en: 'Honey' },
  { key: 'bhavan', hi: 'भवन', en: 'Building' },
  { key: 'chamak', hi: 'चमक', en: 'Shine' },
  { key: 'garam', hi: 'गरम', en: 'Hot' },
  { key: 'naram', hi: 'नरम', en: 'Soft' },
  { key: 'batan', hi: 'बटन', en: 'Button' },

  // Names for 31_hindi_name_writing
  { key: 'amit', hi: 'अमित', en: 'Amit' },
  { key: 'pooja', hi: 'पूजा', en: 'Pooja' },
  { key: 'rahul', hi: 'राहुल', en: 'Rahul' },
  { key: 'neha', hi: 'नेहा', en: 'Neha' },
  { key: 'rohan', hi: 'रोहन', en: 'Rohan' },
  { key: 'riya', hi: 'रिया', en: 'Riya' },
  { key: 'aman', hi: 'अमन', en: 'Aman' },
  { key: 'ananya', hi: 'अनन्या', en: 'Ananya' },
  { key: 'kabir', hi: 'कबीर', en: 'Kabir' },
  { key: 'khushi', hi: 'खुशी', en: 'Khushi' },
  { key: 'aarav', hi: 'आरव', en: 'Aarav' },
  { key: 'tanvi', hi: 'तन्वी', en: 'Tanvi' },

  // Varnamala Letters (Swar & Vyanjan)
  { key: 'a_letter', hi: 'अ', en: 'Letter A' },
  { key: 'aa_letter', hi: 'आ', en: 'Letter Aa' },
  { key: 'i_letter', hi: 'इ', en: 'Letter I' },
  { key: 'ee_letter', hi: 'ई', en: 'Letter Ee' },
  { key: 'u_letter', hi: 'उ', en: 'Letter U' },
  { key: 'oo_letter', hi: 'ऊ', en: 'Letter Oo' },
  { key: 'ri_letter', hi: 'ऋ', en: 'Letter Ri' },
  { key: 'e_letter', hi: 'ए', en: 'Letter E' },
  { key: 'ai_letter', hi: 'ऐ', en: 'Letter Ai' },
  { key: 'o_letter', hi: 'ओ', en: 'Letter O' },
  { key: 'au_letter', hi: 'औ', en: 'Letter Au' },
  { key: 'am_letter', hi: 'अं', en: 'Letter Am' },
  { key: 'k_letter', hi: 'क', en: 'Letter Ka' },
  { key: 'kh_letter', hi: 'ख', en: 'Letter Kha' },
  { key: 'g_letter', hi: 'ग', en: 'Letter Ga' },
  { key: 'gh_letter', hi: 'घ', en: 'Letter Gha' },
  { key: 'ch_letter', hi: 'च', en: 'Letter Cha' },
  { key: 'chh_letter', hi: 'छ', en: 'Letter Chha' },
  { key: 'j_letter', hi: 'ज', en: 'Letter Ja' },
  { key: 'jh_letter', hi: 'झ', en: 'Letter Jha' },
  { key: 't_letter', hi: 'ट', en: 'Letter Ta' },
  { key: 'th_letter', hi: 'ठ', en: 'Letter Tha' },
  { key: 'd_letter', hi: 'ड', en: 'Letter Da' },
  { key: 'dh_letter', hi: 'ढ', en: 'Letter Dha' },
  { key: 'ta_letter', hi: 'त', en: 'Letter Ta' },
  { key: 'tha_letter', hi: 'थ', en: 'Letter Tha' },
  { key: 'da_letter', hi: 'द', en: 'Letter Da' },
  { key: 'dha_letter', hi: 'ध', en: 'Letter Dha' },
  { key: 'na_letter', hi: 'न', en: 'Letter Na' },
  { key: 'pa_letter', hi: 'प', en: 'Letter Pa' },
  { key: 'pha_letter', hi: 'फ', en: 'Letter Pha' },
  { key: 'ba_letter', hi: 'ब', en: 'Letter Ba' },
  { key: 'bha_letter', hi: 'भ', en: 'Letter Bha' },
  { key: 'ma_letter', hi: 'म', en: 'Letter Ma' },
  { key: 'ya_letter', hi: 'य', en: 'Letter Ya' },
  { key: 'ra_letter', hi: 'र', en: 'Letter Ra' },
  { key: 'la_letter', hi: 'ल', en: 'Letter La' },
  { key: 'va_letter', hi: 'व', en: 'Letter Va' },
  { key: 'sha_letter', hi: 'श', en: 'Letter Sha' },
  { key: 'sa_letter', hi: 'स', en: 'Letter Sa' },
  { key: 'ha_letter', hi: 'ह', en: 'Letter Ha' },

  // Reading Sentences
  { key: 's1_ghar', hi: 'यह मेरा घर है', en: 'This is my home' },
  { key: 's2_aam', hi: 'आम बहुत मीठा है', en: 'The mango is very sweet' },
  { key: 's3_jal', hi: 'शीतल जल भर लो', en: 'Fill cold water' },
  { key: 's4_kamal', hi: 'कमल खिल गया', en: 'The lotus has bloomed' },
  { key: 's5_suraj', hi: 'सूरज पूर्व से निकलता है', en: 'The sun rises in the east' },
  { key: 's6_gaay', hi: 'गाय मीठा दूध देती है', en: 'The cow gives sweet milk' },
  { key: 's7_billi', hi: 'बिल्ली म्याऊं बोलती है', en: 'The cat says meow' },
  { key: 's8_school', hi: 'हम रोज स्कूल जाते हैं', en: 'We go to school everyday' },
  { key: 's9_kitaab', hi: 'अच्छी किताबें पढ़ो', en: 'Read good books' },
  { key: 's10_sach', hi: 'सदा सच बोलो', en: 'Always speak the truth' },

  // UI Feedback Audio
  { key: 'feedback_great', hi: 'बहुत बढ़िया!', en: 'Great job!' },
  { key: 'feedback_try', hi: 'फिर कोशिश करें', en: 'Try again' },
  { key: 'feedback_correct', hi: 'सही उत्तर!', en: 'Correct answer!' }
];

// Add numbers 11 to 100 dynamically
for (let i = 11; i <= 100; i++) {
  audioDictionary.push({
    key: `num_${i}`,
    hi: hindiNumberWords[i],
    en: englishNumberWords[i]
  });
}

async function downloadFile(text, lang, filepath) {
  if (fs.existsSync(filepath) && fs.statSync(filepath).size > 1000) {
    return; // Already downloaded
  }
  try {
    const base64 = await googleTTS.getAudioBase64(text, {
      lang: lang,
      slow: false,
      host: 'https://translate.google.com',
      timeout: 10000,
    });
    fs.writeFileSync(filepath, Buffer.from(base64, 'base64'));
  } catch (err) {
    console.error(`Failed ${lang} for "${text}":`, err.message);
  }
}

function delay(ms) {
  return new Promise(res => setTimeout(res, ms));
}

async function run() {
  console.log(`Starting audio generation for ${audioDictionary.length} items...`);
  let count = 0;
  for (const item of audioDictionary) {
    const hiPath = path.join(cacheDirHi, `${item.key}.mp3`);
    const enPath = path.join(cacheDirEn, `${item.key}.mp3`);

    await downloadFile(item.hi, 'hi', hiPath);
    await delay(30);
    await downloadFile(item.en, 'en', enPath);
    await delay(30);

    count++;
    if (count % 20 === 0 || count === audioDictionary.length) {
      console.log(`Progress: ${count}/${audioDictionary.length} items generated.`);
    }
  }
  console.log('Audio generation completed successfully!');
}

run();
