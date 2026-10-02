
import '../models/reading_num.dart';

class AppData {
  // ── Numbers 1–100 ───────────────────────────────────────────────────────────
  static const List<ReadingNum> numbers = [
    ReadingNum(1,  '१',  'एक',         'ek',          'One',          'ஒன்று',          '1️⃣',  'assets/audio/hi/ek.mp3'),
    ReadingNum(2,  '२',  'दो',          'do',          'Two',          'இரண்டு',         '2️⃣',  'assets/audio/hi/do.mp3'),
    ReadingNum(3,  '३',  'तीन',         'teen',        'Three',        'மூன்று',         '3️⃣',  'assets/audio/hi/teen.mp3'),
    ReadingNum(4,  '४',  'चार',         'chaar',       'Four',         'நான்கு',         '4️⃣',  'assets/audio/hi/chaar.mp3'),
    ReadingNum(5,  '५',  'पाँच',        'paanch',      'Five',         'ஐந்து',          '5️⃣',  'assets/audio/hi/paanch.mp3'),
    ReadingNum(6,  '६',  'छह',          'chhah',       'Six',          'ஆறு',            '6️⃣',  'assets/audio/hi/chhah.mp3'),
    ReadingNum(7,  '७',  'सात',         'saat',        'Seven',        'ஏழு',            '7️⃣',  'assets/audio/hi/saat.mp3'),
    ReadingNum(8,  '८',  'आठ',          'aath',        'Eight',        'எட்டு',          '8️⃣',  'assets/audio/hi/aath.mp3'),
    ReadingNum(9,  '९',  'नौ',          'nau',         'Nine',         'ஒன்பது',         '9️⃣',  'assets/audio/hi/nau.mp3'),
    ReadingNum(10, '१०', 'दस',          'das',         'Ten',          'பத்து',          '🔟',  'assets/audio/hi/das.mp3'),
    ReadingNum(11, '११', 'ग्यारह',      'gyaarah',     'Eleven',       'பதினொன்று',      '1️⃣1️⃣','assets/audio/hi/gyaarah.mp3'),
    ReadingNum(12, '१२', 'बारह',        'baarah',      'Twelve',       'பன்னிரண்டு',    '1️⃣2️⃣','assets/audio/hi/baarah.mp3'),
    ReadingNum(13, '१३', 'तेरह',        'terah',       'Thirteen',     'பதின்மூன்று',    '1️⃣3️⃣','assets/audio/hi/terah.mp3'),
    ReadingNum(14, '१४', 'चौदह',        'chaudah',     'Fourteen',     'பதினான்கு',      '1️⃣4️⃣','assets/audio/hi/chaudah.mp3'),
    ReadingNum(15, '१५', 'पंद्रह',      'pandrah',     'Fifteen',      'பதினைந்து',      '1️⃣5️⃣','assets/audio/hi/pandrah.mp3'),
    ReadingNum(16, '१६', 'सोलह',        'solah',       'Sixteen',      'பதினாறு',        '1️⃣6️⃣','assets/audio/hi/solah.mp3'),
    ReadingNum(17, '१७', 'सत्रह',       'satrah',      'Seventeen',    'பதினேழு',        '1️⃣7️⃣','assets/audio/hi/satrah.mp3'),
    ReadingNum(18, '१८', 'अठारह',       'attharah',    'Eighteen',     'பதினெட்டு',      '1️⃣8️⃣','assets/audio/hi/attharah.mp3'),
    ReadingNum(19, '१९', 'उन्नीस',      'unnees',      'Nineteen',     'பத்தொன்பது',     '1️⃣9️⃣','assets/audio/hi/unnees.mp3'),
    ReadingNum(20, '२०', 'बीस',         'bees',        'Twenty',       'இருபது',         '2️⃣0️⃣','assets/audio/hi/bees.mp3'),
    ReadingNum(21, '२१', 'इक्कीस',      'ikkees',      'Twenty-One',   'இருபத்தொன்று',   '🔢',  'assets/audio/hi/ikkees.mp3'),
    ReadingNum(22, '२२', 'बाईस',        'baais',       'Twenty-Two',   'இருபத்திரண்டு',  '🔢',  'assets/audio/hi/baais.mp3'),
    ReadingNum(23, '२३', 'तेईस',        'teis',        'Twenty-Three', 'இருபத்துமூன்று', '🔢',  'assets/audio/hi/teis.mp3'),
    ReadingNum(24, '२४', 'चौबीस',       'chaubbees',   'Twenty-Four',  'இருபத்துநான்கு', '🔢',  'assets/audio/hi/chaubbees.mp3'),
    ReadingNum(25, '२५', 'पच्चीस',      'pachchees',   'Twenty-Five',  'இருபத்தைந்து',   '🔢',  'assets/audio/hi/pachchees.mp3'),
    ReadingNum(26, '२६', 'छब्बीस',      'chhabbees',   'Twenty-Six',   'இருபத்தாறு',     '🔢',  'assets/audio/hi/chhabbees.mp3'),
    ReadingNum(27, '२७', 'सत्ताईस',     'sattaees',    'Twenty-Seven', 'இருபத்தேழு',     '🔢',  'assets/audio/hi/sattaees.mp3'),
    ReadingNum(28, '२८', 'अट्ठाईस',     'atthaees',    'Twenty-Eight', 'இருபத்தெட்டு',   '🔢',  'assets/audio/hi/atthaees.mp3'),
    ReadingNum(29, '२९', 'उनतीस',       'unnattees',   'Twenty-Nine',  'இருபத்தொன்பது',  '🔢',  'assets/audio/hi/unnattees.mp3'),
    ReadingNum(30, '३०', 'तीस',         'tees',        'Thirty',       'முப்பது',         '🔢',  'assets/audio/hi/tees.mp3'),
    ReadingNum(31, '३१', 'इकतीस',       'iktees',      'Thirty-One',   'முப்பத்தொன்று',  '🔢',  'assets/audio/hi/iktees.mp3'),
    ReadingNum(32, '३२', 'बत्तीस',      'battees',     'Thirty-Two',   'முப்பத்திரண்டு', '🔢',  'assets/audio/hi/battees.mp3'),
    ReadingNum(33, '३३', 'तैंतीस',      'taintees',    'Thirty-Three', 'முப்பத்துமூன்று','🔢',  'assets/audio/hi/taintees.mp3'),
    ReadingNum(34, '३४', 'चौंतीस',      'chauntees',   'Thirty-Four',  'முப்பத்துநான்கு','🔢',  'assets/audio/hi/chauntees.mp3'),
    ReadingNum(35, '३५', 'पैंतीस',      'paintees',    'Thirty-Five',  'முப்பத்தைந்து',  '🔢',  'assets/audio/hi/paintees.mp3'),
    ReadingNum(36, '३६', 'छत्तीस',      'chhattees',   'Thirty-Six',   'முப்பத்தாறு',    '🔢',  'assets/audio/hi/chhattees.mp3'),
    ReadingNum(37, '३७', 'सैंतीस',      'sainttees',   'Thirty-Seven', 'முப்பத்தேழு',    '🔢',  'assets/audio/hi/sainttees.mp3'),
    ReadingNum(38, '३८', 'अड़तीस',      'artees',      'Thirty-Eight', 'முப்பத்தெட்டு',  '🔢',  'assets/audio/hi/artees.mp3'),
    ReadingNum(39, '३९', 'उनतालीस',     'untaalees',   'Thirty-Nine',  'முப்பத்தொன்பது', '🔢',  'assets/audio/hi/untaalees.mp3'),
    ReadingNum(40, '४०', 'चालीस',       'chaalees',    'Forty',        'நாற்பது',         '🔢',  'assets/audio/hi/chaalees.mp3'),
    ReadingNum(41, '४१', 'इकतालीस',     'iktaalees',   'Forty-One',    'நாற்பத்தொன்று',  '🔢',  'assets/audio/hi/iktaalees.mp3'),
    ReadingNum(42, '४२', 'बयालीस',      'bayaalees',   'Forty-Two',    'நாற்பத்திரண்டு', '🔢',  'assets/audio/hi/bayaalees.mp3'),
    ReadingNum(43, '४३', 'तैंतालीस',    'tantaalees',  'Forty-Three',  'நாற்பத்துமூன்று','🔢',  'assets/audio/hi/tantaalees.mp3'),
    ReadingNum(44, '४४', 'चौवालीस',     'chauvaalees', 'Forty-Four',   'நாற்பத்துநான்கு','🔢',  'assets/audio/hi/chauvaalees.mp3'),
    ReadingNum(45, '४५', 'पैंतालीस',    'paintaalees', 'Forty-Five',   'நாற்பத்தைந்து',  '🔢',  'assets/audio/hi/paintaalees.mp3'),
    ReadingNum(46, '४६', 'छियालीस',     'chhiyaalees', 'Forty-Six',    'நாற்பத்தாறு',    '🔢',  'assets/audio/hi/chhiyaalees.mp3'),
    ReadingNum(47, '४७', 'सैंतालीस',    'saintaalees', 'Forty-Seven',  'நாற்பத்தேழு',    '🔢',  'assets/audio/hi/saintaalees.mp3'),
    ReadingNum(48, '४८', 'अड़तालीस',    'artaalees',   'Forty-Eight',  'நாற்பத்தெட்டு',  '🔢',  'assets/audio/hi/artaalees.mp3'),
    ReadingNum(49, '४९', 'उनचास',       'unchaas',     'Forty-Nine',   'நாற்பத்தொன்பது', '🔢',  'assets/audio/hi/unchaas.mp3'),
    ReadingNum(50, '५०', 'पचास',        'pachaas',     'Fifty',        'ஐம்பது',          '5️⃣0️⃣','assets/audio/hi/pachaas.mp3'),
    ReadingNum(51, '५१', 'इक्यावन',     'ikyaavan',    'Fifty-One',    'ஐம்பத்தொன்று',   '🔢',  'assets/audio/hi/ikyaavan.mp3'),
    ReadingNum(52, '५२', 'बावन',        'baavan',      'Fifty-Two',    'ஐம்பத்திரண்டு',  '🔢',  'assets/audio/hi/baavan.mp3'),
    ReadingNum(53, '५३', 'तिरपन',       'tirpan',      'Fifty-Three',  'ஐம்பத்துமூன்று', '🔢',  'assets/audio/hi/tirpan.mp3'),
    ReadingNum(54, '५४', 'चौवन',        'chauvan',     'Fifty-Four',   'ஐம்பத்துநான்கு', '🔢',  'assets/audio/hi/chauvan.mp3'),
    ReadingNum(55, '५५', 'पचपन',        'pachpan',     'Fifty-Five',   'ஐம்பத்தைந்து',   '🔢',  'assets/audio/hi/pachpan.mp3'),
    ReadingNum(56, '५६', 'छप्पन',       'chhappan',    'Fifty-Six',    'ஐம்பத்தாறு',     '🔢',  'assets/audio/hi/chhappan.mp3'),
    ReadingNum(57, '५७', 'सत्तावन',     'sattaavan',   'Fifty-Seven',  'ஐம்பத்தேழு',     '🔢',  'assets/audio/hi/sattaavan.mp3'),
    ReadingNum(58, '५८', 'अट्ठावन',     'atthaavan',   'Fifty-Eight',  'ஐம்பத்தெட்டு',   '🔢',  'assets/audio/hi/atthaavan.mp3'),
    ReadingNum(59, '५९', 'उनसठ',        'unsath',      'Fifty-Nine',   'ஐம்பத்தொன்பது',  '🔢',  'assets/audio/hi/unsath.mp3'),
    ReadingNum(60, '६०', 'साठ',         'saath',       'Sixty',        'அறுபது',          '6️⃣0️⃣','assets/audio/hi/saath.mp3'),
    ReadingNum(61, '६१', 'इकसठ',        'iksath',      'Sixty-One',    'அறுபத்தொன்று',   '🔢',  'assets/audio/hi/iksath.mp3'),
    ReadingNum(62, '६२', 'बासठ',        'baasath',     'Sixty-Two',    'அறுபத்திரண்டு',  '🔢',  'assets/audio/hi/baasath.mp3'),
    ReadingNum(63, '६३', 'तिरसठ',       'tirsath',     'Sixty-Three',  'அறுபத்துமூன்று', '🔢',  'assets/audio/hi/tirsath.mp3'),
    ReadingNum(64, '६४', 'चौंसठ',       'chausath',    'Sixty-Four',   'அறுபத்துநான்கு', '🔢',  'assets/audio/hi/chausath.mp3'),
    ReadingNum(65, '६५', 'पैंसठ',       'painsath',    'Sixty-Five',   'அறுபத்தைந்து',   '🔢',  'assets/audio/hi/painsath.mp3'),
    ReadingNum(66, '६६', 'छियासठ',      'chhiyasath',  'Sixty-Six',    'அறுபத்தாறு',     '🔢',  'assets/audio/hi/chhiyasath.mp3'),
    ReadingNum(67, '६७', 'सड़सठ',       'sarsath',     'Sixty-Seven',  'அறுபத்தேழு',     '🔢',  'assets/audio/hi/sarsath.mp3'),
    ReadingNum(68, '६८', 'अड़सठ',       'arsath',      'Sixty-Eight',  'அறுபத்தெட்டு',   '🔢',  'assets/audio/hi/arsath.mp3'),
    ReadingNum(69, '६९', 'उनहत्तर',     'unhattar',    'Sixty-Nine',   'அறுபத்தொன்பது',  '🔢',  'assets/audio/hi/unhattar.mp3'),
    ReadingNum(70, '७०', 'सत्तर',       'sattar',      'Seventy',      'எழுபது',          '7️⃣0️⃣','assets/audio/hi/sattar.mp3'),
    ReadingNum(71, '७१', 'इकहत्तर',     'ikahattar',   'Seventy-One',  'எழுபத்தொன்று',   '🔢',  'assets/audio/hi/ikahattar.mp3'),
    ReadingNum(72, '७२', 'बहत्तर',      'bahattar',    'Seventy-Two',  'எழுபத்திரண்டு',  '🔢',  'assets/audio/hi/bahattar.mp3'),
    ReadingNum(73, '७३', 'तिहत्तर',     'tihattar',    'Seventy-Three','எழுபத்துமூன்று', '🔢',  'assets/audio/hi/tihattar.mp3'),
    ReadingNum(74, '७४', 'चौहत्तर',     'chauhattar',  'Seventy-Four', 'எழுபத்துநான்கு', '🔢',  'assets/audio/hi/chauhattar.mp3'),
    ReadingNum(75, '७५', 'पचहत्तर',     'pachattar',   'Seventy-Five', 'எழுபத்தைந்து',   '🔢',  'assets/audio/hi/pachattar.mp3'),
    ReadingNum(76, '७६', 'छिहत्तर',     'chhihattar',  'Seventy-Six',  'எழுபத்தாறு',     '🔢',  'assets/audio/hi/chhihattar.mp3'),
    ReadingNum(77, '७७', 'सतहत्तर',     'satattar',    'Seventy-Seven','எழுபத்தேழு',     '🔢',  'assets/audio/hi/satattar.mp3'),
    ReadingNum(78, '७८', 'अठहत्तर',     'atthattar',   'Seventy-Eight','எழுபத்தெட்டு',   '🔢',  'assets/audio/hi/atthattar.mp3'),
    ReadingNum(79, '७९', 'उनासी',       'unnaasi',     'Seventy-Nine', 'எழுபத்தொன்பது',  '🔢',  'assets/audio/hi/unnaasi.mp3'),
    ReadingNum(80, '८०', 'अस्सी',       'assi',        'Eighty',       'எண்பது',          '8️⃣0️⃣','assets/audio/hi/assi.mp3'),
    ReadingNum(81, '८१', 'इक्यासी',     'ikyaasi',     'Eighty-One',   'எண்பத்தொன்று',   '🔢',  'assets/audio/hi/ikyaasi.mp3'),
    ReadingNum(82, '८२', 'बयासी',       'bayaasi',     'Eighty-Two',   'எண்பத்திரண்டு',  '🔢',  'assets/audio/hi/bayaasi.mp3'),
    ReadingNum(83, '८३', 'तिरासी',      'tiraasi',     'Eighty-Three', 'எண்பத்துமூன்று', '🔢',  'assets/audio/hi/tiraasi.mp3'),
    ReadingNum(84, '८४', 'चौरासी',      'chauraasi',   'Eighty-Four',  'எண்பத்துநான்கு', '🔢',  'assets/audio/hi/chauraasi.mp3'),
    ReadingNum(85, '८५', 'पचासी',       'pachaasi',    'Eighty-Five',  'எண்பத்தைந்து',   '🔢',  'assets/audio/hi/pachaasi.mp3'),
    ReadingNum(86, '८६', 'छियासी',      'chhiyaasi',   'Eighty-Six',   'எண்பத்தாறு',     '🔢',  'assets/audio/hi/chhiyaasi.mp3'),
    ReadingNum(87, '८७', 'सत्तासी',     'sattaasi',    'Eighty-Seven', 'எண்பத்தேழு',     '🔢',  'assets/audio/hi/sattaasi.mp3'),
    ReadingNum(88, '८८', 'अट्ठासी',     'atthaasi',    'Eighty-Eight', 'எண்பத்தெட்டு',   '🔢',  'assets/audio/hi/atthaasi.mp3'),
    ReadingNum(89, '८९', 'नवासी',       'navaasi',     'Eighty-Nine',  'எண்பத்தொன்பது',  '🔢',  'assets/audio/hi/navaasi.mp3'),
    ReadingNum(90, '९०', 'नब्बे',       'nabbe',       'Ninety',       'தொண்ணூறு',        '9️⃣0️⃣','assets/audio/hi/nabbe.mp3'),
    ReadingNum(91, '९१', 'इक्यानवे',    'ikyaanave',   'Ninety-One',   'தொண்ணூற்றொன்று', '🔢',  'assets/audio/hi/ikyaanave.mp3'),
    ReadingNum(92, '९२', 'बानवे',       'baaanave',    'Ninety-Two',   'தொண்ணூற்றிரண்டு','🔢',  'assets/audio/hi/baaanave.mp3'),
    ReadingNum(93, '९३', 'तिरानवे',     'tiraaanave',  'Ninety-Three', 'தொண்ணூற்றுமூன்று','🔢', 'assets/audio/hi/tiraaanave.mp3'),
    ReadingNum(94, '९४', 'चौरानवे',     'chauraanave', 'Ninety-Four',  'தொண்ணூற்றுநான்கு','🔢', 'assets/audio/hi/chauraanave.mp3'),
    ReadingNum(95, '९५', 'पंचानवे',     'panchaanave', 'Ninety-Five',  'தொண்ணூற்றைந்து', '🔢',  'assets/audio/hi/panchaanave.mp3'),
    ReadingNum(96, '९६', 'छियानवे',     'chhiyaanave', 'Ninety-Six',   'தொண்ணூற்றாறு',   '🔢',  'assets/audio/hi/chhiyaanave.mp3'),
    ReadingNum(97, '९७', 'सत्तानवे',    'sattaanave',  'Ninety-Seven', 'தொண்ணூற்றேழு',   '🔢',  'assets/audio/hi/sattaanave.mp3'),
    ReadingNum(98, '९८', 'अट्ठानवे',    'atthaanave',  'Ninety-Eight', 'தொண்ணூற்றெட்டு', '🔢',  'assets/audio/hi/atthaanave.mp3'),
    ReadingNum(99, '९९', 'निन्यानवे',   'ninyaanave',  'Ninety-Nine',  'தொண்ணூற்றொன்பது','🔢',  'assets/audio/hi/ninyaanave.mp3'),
    ReadingNum(100,'१००','सौ',          'sau',         'Hundred',      'நூறு',            '💯',  'assets/audio/hi/sau.mp3'),
  ];

  // ── Animals (जानवर) ─────────────────────────────────────────────────────────
  static const List<ReadingNum> animals = [
    ReadingNum(101,'कुत्ता','कुत्ता', 'kuttaa',    'Dog',       'நாய்',              '🐕', 'assets/audio/hi/kuttaa.mp3'),
    ReadingNum(102,'बिल्ली','बिल्ली', 'billi',     'Cat',       'பூனை',              '🐈', 'assets/audio/hi/billi.mp3'),
    ReadingNum(103,'गाय',   'गाय',    'gaay',      'Cow',       'பசு',               '🐄', 'assets/audio/hi/gaay.mp3'),
    ReadingNum(104,'घोड़ा', 'घोड़ा',  'ghoda',     'Horse',     'குதிரை',            '🐎', 'assets/audio/hi/ghoda.mp3'),
    ReadingNum(105,'हाथी',  'हाथी',   'haathi',    'Elephant',  'யானை',              '🐘', 'assets/audio/hi/haathi.mp3'),
    ReadingNum(106,'शेर',   'शेर',    'sher',      'Lion',      'சிங்கம்',           '🦁', 'assets/audio/hi/sher.mp3'),
    ReadingNum(107,'बाघ',   'बाघ',    'baagh',     'Tiger',     'புலி',              '🐯', 'assets/audio/hi/baagh.mp3'),
    ReadingNum(108,'बंदर',  'बंदर',   'bandar',    'Monkey',    'குரங்கு',           '🐒', 'assets/audio/hi/bandar.mp3'),
    ReadingNum(109,'हिरण',  'हिरण',   'hiran',     'Deer',      'மான்',              '🦌', 'assets/audio/hi/hiran.mp3'),
    ReadingNum(110,'खरगोश','खरगोश',  'kharagosh', 'Rabbit',    'முயல்',             '🐇', 'assets/audio/hi/kharagosh.mp3'),
    ReadingNum(111,'भालू',  'भालू',   'bhaalu',    'Bear',      'கரடி',              '🐻', 'assets/audio/hi/bhaalu.mp3'),
    ReadingNum(112,'लोमड़ी','लोमड़ी', 'lomdi',     'Fox',       'நரி',               '🦊', 'assets/audio/hi/lomdi.mp3'),
    ReadingNum(113,'जिराफ', 'जिराफ',  'jiraaf',    'Giraffe',   'ஒட்டகச்சிவிங்கி',  '🦒', 'assets/audio/hi/jiraaf.mp3'),
    ReadingNum(114,'ज़ेब्रा','ज़ेब्रा', 'zebra',    'Zebra',     'வரிக்குதிரை',       '🦓', 'assets/audio/hi/zebra.mp3'),
    ReadingNum(115,'तोता',  'तोता',   'tota',      'Parrot',    'கிளி',              '🦜', 'assets/audio/hi/tota.mp3'),
    ReadingNum(116,'मछली',  'मछली',   'machhli',   'Fish',      'மீன்',              '🐟', 'assets/audio/hi/machhli.mp3'),
    ReadingNum(117,'मेंढक', 'मेंढक',  'mendhak',   'Frog',      'தவளை',              '🐸', 'assets/audio/hi/mendhak.mp3'),
    ReadingNum(118,'साँप',  'साँप',   'saanp',     'Snake',     'பாம்பு',            '🐍', 'assets/audio/hi/saanp.mp3'),
    ReadingNum(119,'कछुआ',  'कछुआ',   'kachhuwaa', 'Tortoise',  'ஆமை',               '🐢', 'assets/audio/hi/kachhuwaa.mp3'),
    ReadingNum(120,'गिलहरी','गिलहरी', 'gilhari',   'Squirrel',  'அணில்',             '🐿️','assets/audio/hi/gilhari.mp3'),
    ReadingNum(121,'ऊँट',   'ऊँट',    'unt',       'Camel',     'ஒட்டகம்',           '🐪', 'assets/audio/hi/unt.mp3'),
    ReadingNum(122,'बकरी',  'बकरी',   'bakri',     'Goat',      'வெள்ளாடு',          '🐐', 'assets/audio/hi/bakri.mp3'),
    ReadingNum(123,'भेड़',  'भेड़',   'bhed',      'Sheep',     'செம்மறியாடு',       '🐑', 'assets/audio/hi/bhed.mp3'),
    ReadingNum(124,'मुर्गा','मुर्गा', 'murga',     'Rooster',   'கோழி',              '🐓', 'assets/audio/hi/murga.mp3'),
    ReadingNum(125,'बत्तख', 'बत्तख',  'battakh',   'Duck',      'வாத்து',            '🦆', 'assets/audio/hi/battakh.mp3'),
    ReadingNum(126,'मोर',   'मोर',    'mor',       'Peacock',   'மயில்',             '🦚', 'assets/audio/hi/mor.mp3'),
    ReadingNum(127,'कौआ',   'कौआ',    'kaua',      'Crow',      'காகம்',             '🐦‍⬛','assets/audio/hi/kaua.mp3'),
    ReadingNum(128,'उल्लू', 'उल्लू',  'ullu',      'Owl',       'ஆந்தை',             '🦉', 'assets/audio/hi/ullu.mp3'),
    ReadingNum(129,'बाज',   'बाज',    'baaj',      'Eagle',     'கழுகு',             '🦅', 'assets/audio/hi/baaj.mp3'),
    ReadingNum(130,'भैंस',  'भैंस',   'bhains',    'Buffalo',   'எருமை',             '🐃', 'assets/audio/hi/bhains.mp3'),
  ];

  // ── Fruits (फल) ─────────────────────────────────────────────────────────────
  static const List<ReadingNum> fruits = [
    ReadingNum(201,'सेब',     'सेब',     'seb',       'Apple',      'ஆப்பிள்',        '🍎', 'assets/audio/hi/seb.mp3'),
    ReadingNum(202,'केला',    'केला',    'kela',      'Banana',     'வாழைப்பழம்',     '🍌', 'assets/audio/hi/kela.mp3'),
    ReadingNum(203,'आम',      'आम',      'aam',       'Mango',      'மாம்பழம்',       '🥭', 'assets/audio/hi/aam.mp3'),
    ReadingNum(204,'अंगूर',   'अंगूर',   'angur',     'Grapes',     'திராட்சை',        '🍇', 'assets/audio/hi/angur.mp3'),
    ReadingNum(205,'संतरा',   'संतरा',   'santra',    'Orange',     'ஆரஞ்சு',          '🍊', 'assets/audio/hi/santra.mp3'),
    ReadingNum(206,'अनानास',  'अनानास',  'anaanas',   'Pineapple',  'அன்னாசி',         '🍍', 'assets/audio/hi/anaanas.mp3'),
    ReadingNum(207,'तरबूज',   'तरबूज',   'tarbuz',    'Watermelon', 'தர்பூசணி',        '🍉', 'assets/audio/hi/tarbuz.mp3'),
    ReadingNum(208,'पपीता',   'पपीता',   'papeeta',   'Papaya',     'பப்பாளி',         '🍈', 'assets/audio/hi/papeeta.mp3'),
    ReadingNum(209,'नारियल',  'नारियल',  'naariyal',  'Coconut',    'தேங்காய்',        '🥥', 'assets/audio/hi/naariyal.mp3'),
    ReadingNum(210,'अमरूद',   'अमरूद',   'amrud',     'Guava',      'கொய்யா',          '🍏', 'assets/audio/hi/amrud.mp3'),
    ReadingNum(211,'अनार',    'अनार',    'anaar',     'Pomegranate','மாதுளை',          '🍑', 'assets/audio/hi/anaar.mp3'),
    ReadingNum(212,'स्ट्रॉबेरी','स्ट्रॉबेरी','strawberry','Strawberry','ஸ்ட்ராபெர்ரி',  '🍓', 'assets/audio/hi/strawberry.mp3'),
    ReadingNum(213,'लीची',    'लीची',    'leechi',    'Lychee',     'லிச்சி',          '🍒', 'assets/audio/hi/leechi.mp3'),
    ReadingNum(214,'नाशपाती', 'नाशपाती', 'naashpaati','Pear',       'பேரிக்காய்',     '🍐', 'assets/audio/hi/naashpaati.mp3'),
    ReadingNum(215,'कीवी',    'कीवी',    'kiwi',      'Kiwi',       'கிவி',            '🥝', 'assets/audio/hi/kiwi.mp3'),
    ReadingNum(216,'खजूर',    'खजूर',    'khajur',    'Date',       'பேரீச்சம்பழம்',  '🌴', 'assets/audio/hi/khajur.mp3'),
    ReadingNum(217,'जामुन',   'जामुन',   'jaamun',    'Blackberry', 'நாவல்பழம்',      '🫐', 'assets/audio/hi/jaamun.mp3'),
    ReadingNum(218,'चेरी',    'चेरी',    'cheri',     'Cherry',     'செர்ரி',          '🍒', 'assets/audio/hi/cheri.mp3'),
    ReadingNum(219,'खरबूजा',  'खरबूजा',  'kharbuja',  'Muskmelon',  'முலாம்பழம்',     '🍈', 'assets/audio/hi/kharbuja.mp3'),
    ReadingNum(220,'बेर',     'बेर',     'ber',       'Jujube',     'இலந்தைப்பழம்',  '🫒', 'assets/audio/hi/ber.mp3'),
  ];

  // ── Vegetables (सब्ज़ी) ──────────────────────────────────────────────────────
  static const List<ReadingNum> vegetables = [
    ReadingNum(301,'आलू',      'आलू',      'aalu',       'Potato',      'உருளைக்கிழங்கு','🥔','assets/audio/hi/aalu.mp3'),
    ReadingNum(302,'प्याज',    'प्याज',    'pyaaj',      'Onion',       'வெங்காயம்',    '🧅', 'assets/audio/hi/pyaaj.mp3'),
    ReadingNum(303,'टमाटर',    'टमाटर',    'tamaatar',   'Tomato',      'தக்காளி',       '🍅', 'assets/audio/hi/tamaatar.mp3'),
    ReadingNum(304,'गोभी',     'गोभी',     'gobhi',      'Cauliflower', 'காலிஃப்ளவர்',   '🥦', 'assets/audio/hi/gobhi.mp3'),
    ReadingNum(305,'बैंगन',    'बैंगन',    'baigan',     'Brinjal',     'கத்திரிக்காய்', '🍆', 'assets/audio/hi/baigan.mp3'),
    ReadingNum(306,'भिंडी',    'भिंडी',    'bhindi',     'Okra',        'வெண்டைக்காய்', '🌿', 'assets/audio/hi/bhindi.mp3'),
    ReadingNum(307,'पालक',     'पालक',     'paalak',     'Spinach',     'கீரை',          '🥬', 'assets/audio/hi/paalak.mp3'),
    ReadingNum(308,'गाजर',     'गाजर',     'gaajar',     'Carrot',      'கேரட்',         '🥕', 'assets/audio/hi/gaajar.mp3'),
    ReadingNum(309,'मटर',      'मटर',      'matar',      'Peas',        'பட்டாணி',       '🫛', 'assets/audio/hi/matar.mp3'),
    ReadingNum(310,'लौकी',     'लौकी',     'lauki',      'Gourd',       'சுரைக்காய்',    '🥒', 'assets/audio/hi/lauki.mp3'),
    ReadingNum(311,'करेला',    'करेला',    'karela',     'Bitter Gourd','பாவக்காய்',    '🥦', 'assets/audio/hi/karela.mp3'),
    ReadingNum(312,'मूली',     'मूली',     'muli',       'Radish',      'முள்ளங்கி',     '🌱', 'assets/audio/hi/muli.mp3'),
    ReadingNum(313,'खीरा',     'खीरा',     'kheera',     'Cucumber',    'வெள்ளரிக்காய்','🥒', 'assets/audio/hi/kheera.mp3'),
    ReadingNum(314,'कद्दू',    'कद्दू',    'kaddu',      'Pumpkin',     'பூசணிக்காய்',  '🎃', 'assets/audio/hi/kaddu.mp3'),
    ReadingNum(315,'अदरक',     'अदरक',     'adrak',      'Ginger',      'இஞ்சி',         '🫚', 'assets/audio/hi/adrak.mp3'),
    ReadingNum(316,'लहसुन',    'लहसुन',    'lahsun',     'Garlic',      'பூண்டு',        '🧄', 'assets/audio/hi/lahsun.mp3'),
    ReadingNum(317,'हरी मिर्च','हरी मिर्च','hari mirch', 'Green Chilli','பச்சை மிளகாய்','🌶️','assets/audio/hi/hari_mirch.mp3'),
    ReadingNum(318,'मशरूम',    'मशरूम',    'mashrum',    'Mushroom',    'காளான்',        '🍄', 'assets/audio/hi/mashrum.mp3'),
    ReadingNum(319,'शकरकंद',   'शकरकंद',   'shakarkand', 'Sweet Potato','சர்க்கரைவள்ளி','🍠', 'assets/audio/hi/shakarkand.mp3'),
    ReadingNum(320,'मक्का',    'मक्का',    'makka',      'Corn',        'சோளம்',         '🌽', 'assets/audio/hi/makka.mp3'),
  ];

  // ── Colors (रंग) ─────────────────────────────────────────────────────────────
  static const List<ReadingNum> colors = [
    ReadingNum(401,'लाल',    'लाल',    'laal',    'Red',       'சிவப்பு',     '🔴', 'assets/audio/hi/laal.mp3'),
    ReadingNum(402,'नीला',   'नीला',   'neela',   'Blue',      'நீலம்',       '🔵', 'assets/audio/hi/neela.mp3'),
    ReadingNum(403,'हरा',    'हरा',    'hara',    'Green',     'பச்சை',       '🟢', 'assets/audio/hi/hara.mp3'),
    ReadingNum(404,'पीला',   'पीला',   'peela',   'Yellow',    'மஞ்சள்',      '🟡', 'assets/audio/hi/peela.mp3'),
    ReadingNum(405,'सफ़ेद',  'सफ़ेद',  'safed',   'White',     'வெள்ளை',      '⚪', 'assets/audio/hi/safed.mp3'),
    ReadingNum(406,'काला',   'काला',   'kaala',   'Black',     'கறுப்பு',     '⚫', 'assets/audio/hi/kaala.mp3'),
    ReadingNum(407,'नारंगी', 'नारंगी', 'narangi', 'Orange',    'ஆரஞ்சு நிறம்','🟠', 'assets/audio/hi/narangi.mp3'),
    ReadingNum(408,'गुलाबी', 'गुलाबी', 'gulaabi', 'Pink',      'இளஞ்சிவப்பு','🩷', 'assets/audio/hi/gulaabi.mp3'),
    ReadingNum(409,'बैंगनी', 'बैंगनी', 'baingani','Purple',    'ஊதா',         '🟣', 'assets/audio/hi/baingani.mp3'),
    ReadingNum(410,'भूरा',   'भूरा',   'bhoora',  'Brown',     'பழுப்பு',     '🟤', 'assets/audio/hi/bhoora.mp3'),
    ReadingNum(411,'सोना',   'सोना',   'sona',    'Golden',    'தங்க நிறம்',  '🟨', 'assets/audio/hi/sona_color.mp3'),
    ReadingNum(412,'चाँदी',  'चाँदी',  'chaandi', 'Silver',    'வெள்ளி நிறம்','⬜', 'assets/audio/hi/chaandi_color.mp3'),
    ReadingNum(413,'आसमानी', 'आसमानी', 'aasamaani','Sky Blue', 'வான்நீலம்',   '🩵', 'assets/audio/hi/aasamaani.mp3'),
    ReadingNum(414,'धूसर',   'धूसर',   'dhusar',  'Grey',      'சாம்பல்',     '🩶', 'assets/audio/hi/dhusar.mp3'),
    ReadingNum(415,'मरून',   'मरून',   'maroon',  'Maroon',    'கருஞ்சிவப்பு','🎆', 'assets/audio/hi/maroon.mp3'),
    ReadingNum(416,'क्रीम',  'क्रीम',  'cream',   'Cream',     'கிரீம் நிறம்','🌸', 'assets/audio/hi/cream.mp3'),
    ReadingNum(417,'फ़िरोज़ी','फ़िरोज़ी','firozi',  'Turquoise', 'கருநீலம்',    '💎', 'assets/audio/hi/firozi.mp3'),
    ReadingNum(418,'जैतूनी', 'जैतूनी', 'jaitooni','Olive',     'ஆலிவ் நிறம்', '🫒', 'assets/audio/hi/jaitooni.mp3'),
    ReadingNum(419,'चमकीला', 'चमकीला', 'chamkeela','Bright',   'பிரகாசமான',   '✨', 'assets/audio/hi/chamkeela.mp3'),
    ReadingNum(420,'हल्का',  'हल्का',  'halka',   'Light',     'இளம்',        '🌟', 'assets/audio/hi/halka.mp3'),
  ];

  // ── Body Parts (शरीर) ────────────────────────────────────────────────────────
  static const List<ReadingNum> bodyParts = [
    ReadingNum(501,'सिर',   'सिर',   'sir',     'Head',     'தலை',       '👤', 'assets/audio/hi/sir.mp3'),
    ReadingNum(502,'आँख',   'आँख',   'aankh',   'Eye',      'கண்',        '👁️','assets/audio/hi/aankh.mp3'),
    ReadingNum(503,'नाक',   'नाक',   'naak',    'Nose',     'மூக்கு',    '👃', 'assets/audio/hi/naak.mp3'),
    ReadingNum(504,'कान',   'कान',   'kaan',    'Ear',      'காது',       '👂', 'assets/audio/hi/kaan.mp3'),
    ReadingNum(505,'मुँह',  'मुँह',  'munh',    'Mouth',    'வாய்',       '👄', 'assets/audio/hi/munh.mp3'),
    ReadingNum(506,'दाँत',  'दाँत',  'daant',   'Teeth',    'பல்',        '🦷', 'assets/audio/hi/daant.mp3'),
    ReadingNum(507,'जीभ',   'जीभ',   'jeebh',   'Tongue',   'நாக்கு',    '👅', 'assets/audio/hi/jeebh.mp3'),
    ReadingNum(508,'बाल',   'बाल',   'baal',    'Hair',     'தலைமுடி',   '💇', 'assets/audio/hi/baal.mp3'),
    ReadingNum(509,'गर्दन', 'गर्दन', 'gardan',  'Neck',     'கழுத்து',   '🦒', 'assets/audio/hi/gardan.mp3'),
    ReadingNum(510,'कंधा',  'कंधा',  'kandha',  'Shoulder', 'தோள்',       '🤷', 'assets/audio/hi/kandha.mp3'),
    ReadingNum(511,'हाथ',   'हाथ',   'haath',   'Hand',     'கை',         '✋', 'assets/audio/hi/haath.mp3'),
    ReadingNum(512,'उँगली', 'उँगली', 'ungali',  'Finger',   'விரல்',      '☝️','assets/audio/hi/ungali.mp3'),
    ReadingNum(513,'पेट',   'पेट',   'pet',     'Stomach',  'வயிறு',      '🫃', 'assets/audio/hi/pet.mp3'),
    ReadingNum(514,'पीठ',   'पीठ',   'peeth',   'Back',     'முதுகு',     '🧍', 'assets/audio/hi/peeth.mp3'),
    ReadingNum(515,'पैर',   'पैर',   'pair',    'Leg',      'கால்',       '🦵', 'assets/audio/hi/pair.mp3'),
    ReadingNum(516,'घुटना', 'घुटना', 'ghutna',  'Knee',     'முழங்கால்', '🦵', 'assets/audio/hi/ghutna.mp3'),
    ReadingNum(517,'छाती',  'छाती',  'chhaati', 'Chest',    'மார்பு',     '🫀', 'assets/audio/hi/chhaati.mp3'),
    ReadingNum(518,'दिल',   'दिल',   'dil',     'Heart',    'இதயம்',      '❤️','assets/audio/hi/dil.mp3'),
    ReadingNum(519,'नाखून', 'नाखून', 'naakhun', 'Nail',     'நகம்',       '💅', 'assets/audio/hi/naakhun.mp3'),
    ReadingNum(520,'भौंह',  'भौंह',  'bhaunh',  'Eyebrow',  'புருவம்',    '🤨', 'assets/audio/hi/bhaunh.mp3'),
  ];

  // ── Family (परिवार) ──────────────────────────────────────────────────────────
  static const List<ReadingNum> family = [
    ReadingNum(601,'माँ',    'माँ',    'maa',    'Mother',            'அம்மா',         '👩', 'assets/audio/hi/maa.mp3'),
    ReadingNum(602,'पिता',   'पिता',   'pita',   'Father',            'அப்பா',         '👨', 'assets/audio/hi/pita.mp3'),
    ReadingNum(603,'दादा',   'दादा',   'daada',  'Grandfather',       'தாத்தா',        '👴', 'assets/audio/hi/daada.mp3'),
    ReadingNum(604,'दादी',   'दादी',   'daadi',  'Grandmother',       'பாட்டி',        '👵', 'assets/audio/hi/daadi.mp3'),
    ReadingNum(605,'भाई',    'भाई',    'bhai',   'Brother',           'அண்ணன்/தம்பி', '👦', 'assets/audio/hi/bhai.mp3'),
    ReadingNum(606,'बहन',    'बहन',    'bahan',  'Sister',            'அக்கா/தங்கை',  '👧', 'assets/audio/hi/bahan.mp3'),
    ReadingNum(607,'चाचा',   'चाचा',   'chacha', 'Uncle',             'சித்தப்பா',     '🧑', 'assets/audio/hi/chacha.mp3'),
    ReadingNum(608,'चाची',   'चाची',   'chaachi','Aunt',              'சித்தி',        '👩', 'assets/audio/hi/chaachi.mp3'),
    ReadingNum(609,'मामा',   'मामा',   'mama',   'Maternal Uncle',    'மாமா',          '🧔', 'assets/audio/hi/mama.mp3'),
    ReadingNum(610,'मामी',   'मामी',   'maami',  'Maternal Aunt',     'மாமி',          '👩', 'assets/audio/hi/maami.mp3'),
    ReadingNum(611,'बेटा',   'बेटा',   'beta',   'Son',               'மகன்',          '👦', 'assets/audio/hi/beta.mp3'),
    ReadingNum(612,'बेटी',   'बेटी',   'beti',   'Daughter',          'மகள்',          '👧', 'assets/audio/hi/beti.mp3'),
    ReadingNum(613,'पति',    'पति',    'pati',   'Husband',           'கணவன்',         '👨', 'assets/audio/hi/pati.mp3'),
    ReadingNum(614,'पत्नी',  'पत्नी',  'patni',  'Wife',              'மனைவி',         '👩', 'assets/audio/hi/patni.mp3'),
    ReadingNum(615,'नाना',   'नाना',   'naana',  'Maternal Grandfather','நாட்டு தாத்தா','👴','assets/audio/hi/naana.mp3'),
    ReadingNum(616,'नानी',   'नानी',   'naani',  'Maternal Grandmother','நாட்டு பாட்டி','👵','assets/audio/hi/naani.mp3'),
    ReadingNum(617,'बुआ',    'बुआ',    'bua',    'Paternal Aunt',     'அத்தை',         '👩', 'assets/audio/hi/bua.mp3'),
    ReadingNum(618,'भतीजा',  'भतीजा',  'bhatija','Nephew',            'மருமகன்',       '👦', 'assets/audio/hi/bhatija.mp3'),
    ReadingNum(619,'भतीजी',  'भतीजी',  'bhatiji','Niece',             'மருமகள்',       '👧', 'assets/audio/hi/bhatiji.mp3'),
    ReadingNum(620,'परिवार', 'परिवार', 'parivar','Family',            'குடும்பம்',     '👨‍👩‍👧‍👦','assets/audio/hi/parivar.mp3'),
  ];

  // ── Transport (यातायात) ──────────────────────────────────────────────────────
  static const List<ReadingNum> transport = [
    ReadingNum(701,'कार',        'कार',        'car',        'Car',        'கார்',              '🚗', 'assets/audio/hi/car.mp3'),
    ReadingNum(702,'बस',         'बस',         'bus',        'Bus',        'பேருந்து',          '🚌', 'assets/audio/hi/bus.mp3'),
    ReadingNum(703,'ट्रेन',      'ट्रेन',      'train',      'Train',      'தொடர்வண்டி',       '🚂', 'assets/audio/hi/train.mp3'),
    ReadingNum(704,'हवाई जहाज',  'हवाई जहाज',  'hawai jahaz','Aeroplane',  'விமானம்',           '✈️','assets/audio/hi/hawai_jahaz.mp3'),
    ReadingNum(705,'जहाज',       'जहाज',       'jahaz',      'Ship',       'கப்பல்',            '🚢', 'assets/audio/hi/jahaz.mp3'),
    ReadingNum(706,'साइकिल',     'साइकिल',     'cycle',      'Bicycle',    'மிதிவண்டி',         '🚲', 'assets/audio/hi/cycle.mp3'),
    ReadingNum(707,'मोटरसाइकिल', 'मोटरसाइकिल', 'motorcycle', 'Motorcycle', 'மோட்டார் சைக்கிள்', '🏍️','assets/audio/hi/motorcycle.mp3'),
    ReadingNum(708,'ट्रक',       'ट्रक',       'truck',      'Truck',      'லாரி',              '🚛', 'assets/audio/hi/truck.mp3'),
    ReadingNum(709,'ऑटो',        'ऑटो',        'auto',       'Auto',       'ஆட்டோ',             '🛺', 'assets/audio/hi/auto.mp3'),
    ReadingNum(710,'हेलीकॉप्टर', 'हेलीकॉप्टर', 'helicopter', 'Helicopter', 'ஹெலிகாப்டர்',       '🚁', 'assets/audio/hi/helicopter.mp3'),
    ReadingNum(711,'नाव',        'नाव',        'naav',       'Boat',       'படகு',              '⛵', 'assets/audio/hi/naav.mp3'),
    ReadingNum(712,'स्कूटर',     'स्कूटर',     'scooter',    'Scooter',    'ஸ்கூட்டர்',         '🛵', 'assets/audio/hi/scooter.mp3'),
    ReadingNum(713,'टैक्सी',     'टैक्सी',     'taxi',       'Taxi',       'டாக்சி',            '🚕', 'assets/audio/hi/taxi.mp3'),
    ReadingNum(714,'मेट्रो',     'मेट्रो',     'metro',      'Metro',      'மெட்ரோ',            '🚇', 'assets/audio/hi/metro.mp3'),
    ReadingNum(715,'रॉकेट',      'रॉकेट',      'rocket',     'Rocket',     'ராக்கெட்',          '🚀', 'assets/audio/hi/rocket.mp3'),
    ReadingNum(716,'रिक्शा',     'रिक्शा',     'ricksha',    'Rickshaw',   'ரிக்ஷா',            '🛺', 'assets/audio/hi/ricksha.mp3'),
    ReadingNum(717,'सबमरीन',     'सबमरीन',     'submarine',  'Submarine',  'நீர்மூழ்கிக் கப்பல்','🤿','assets/audio/hi/submarine.mp3'),
    ReadingNum(718,'ट्राम',      'ट्राम',      'tram',       'Tram',       'டிராம்',             '🚃', 'assets/audio/hi/tram.mp3'),
    ReadingNum(719,'एम्बुलेंस',  'एम्बुलेंस',  'ambulance',  'Ambulance',  'ஆம்புலன்ஸ்',        '🚑', 'assets/audio/hi/ambulance.mp3'),
    ReadingNum(720,'अंतरिक्ष यान','अंतरिक्ष यान','antriksh',  'Spacecraft', 'விண்கலம்',          '🛸', 'assets/audio/hi/antriksh.mp3'),
  ];

  // ── School (विद्यालय) ────────────────────────────────────────────────────────
  static const List<ReadingNum> school = [
    ReadingNum(801,'किताब',  'किताब',  'kitaab',    'Book',       'புத்தகம்',    '📚', 'assets/audio/hi/kitaab.mp3'),
    ReadingNum(802,'पेन',    'पेन',    'pen',       'Pen',        'பேனா',         '🖊️','assets/audio/hi/pen.mp3'),
    ReadingNum(803,'पेंसिल', 'पेंसिल', 'pencil',    'Pencil',     'பென்சில்',     '✏️','assets/audio/hi/pencil.mp3'),
    ReadingNum(804,'रबड़',   'रबड़',   'rubber',    'Eraser',     'அழிப்பான்',   '🧹', 'assets/audio/hi/rubber.mp3'),
    ReadingNum(805,'शासक',   'शासक',   'shaasak',   'Ruler',      'அளவுகோல்',    '📏', 'assets/audio/hi/shaasak.mp3'),
    ReadingNum(806,'बैग',    'बैग',    'bag',       'Bag',        'பை',           '🎒', 'assets/audio/hi/bag.mp3'),
    ReadingNum(807,'नोटबुक', 'नोटबुक', 'notebook',  'Notebook',   'குறிப்பேடு',  '📓', 'assets/audio/hi/notebook.mp3'),
    ReadingNum(808,'कक्षा',  'कक्षा',  'kaksha',    'Classroom',  'வகுப்பறை',    '🏫', 'assets/audio/hi/kaksha.mp3'),
    ReadingNum(809,'चाक',    'चाक',    'chaak',     'Chalk',      'சாக்பீஸ்',    '🖍️','assets/audio/hi/chaak.mp3'),
    ReadingNum(810,'कैंची',  'कैंची',  'kainchi',   'Scissors',   'கத்தரிக்கோல்','✂️','assets/audio/hi/kainchi.mp3'),
    ReadingNum(811,'रंग',    'रंग',    'rang',      'Colors',     'வண்ணங்கள்',   '🎨', 'assets/audio/hi/rang.mp3'),
    ReadingNum(812,'ब्रश',   'ब्रश',   'brush',     'Brush',      'தூரிகை',       '🖌️','assets/audio/hi/brush.mp3'),
    ReadingNum(813,'गोंद',   'गोंद',   'gond',      'Glue',       'பசை',          '🫙', 'assets/audio/hi/gond.mp3'),
    ReadingNum(814,'घड़ी',   'घड़ी',   'ghadi',     'Clock',      'கடிகாரம்',    '🕐', 'assets/audio/hi/ghadi.mp3'),
    ReadingNum(815,'मेज़',   'मेज़',   'mez',       'Table',      'மேசை',         '🪑', 'assets/audio/hi/mez.mp3'),
    ReadingNum(816,'कुर्सी', 'कुर्सी', 'kursi',     'Chair',      'நாற்காலி',    '🪑', 'assets/audio/hi/kursi.mp3'),
    ReadingNum(817,'शिक्षक', 'शिक्षक', 'shikshak',  'Teacher',    'ஆசிரியர்',    '👩‍🏫','assets/audio/hi/shikshak.mp3'),
    ReadingNum(818,'छात्र',  'छात्र',  'chhaatra',  'Student',    'மாணவன்',       '🧑‍🎓','assets/audio/hi/chhaatra.mp3'),
    ReadingNum(819,'स्कूल',  'स्कूल',  'school',    'School',     'பள்ளி',        '🏫', 'assets/audio/hi/school.mp3'),
    ReadingNum(820,'कम्पास', 'कम्पास', 'compass',   'Compass',    'கம்பாஸ்',      '🔘', 'assets/audio/hi/compass.mp3'),
  ];

  // ── Nature (प्रकृति) ─────────────────────────────────────────────────────────
  static const List<ReadingNum> nature = [
    ReadingNum(901,'पेड़',    'पेड़',    'ped',       'Tree',       'மரம்',          '🌳', 'assets/audio/hi/ped.mp3'),
    ReadingNum(902,'फूल',    'फूल',    'phool',     'Flower',     'பூ',            '🌸', 'assets/audio/hi/phool.mp3'),
    ReadingNum(903,'नदी',    'नदी',    'nadi',      'River',      'ஆறு',           '🌊', 'assets/audio/hi/nadi.mp3'),
    ReadingNum(904,'पहाड़',  'पहाड़',  'pahaad',    'Mountain',   'மலை',           '⛰️','assets/audio/hi/pahaad.mp3'),
    ReadingNum(905,'आकाश',   'आकाश',   'aakaash',   'Sky',        'வானம்',         '🌌', 'assets/audio/hi/aakaash.mp3'),
    ReadingNum(906,'सूरज',   'सूरज',   'suraj',     'Sun',        'சூரியன்',       '☀️','assets/audio/hi/suraj.mp3'),
    ReadingNum(907,'चाँद',   'चाँद',   'chaand',    'Moon',       'நிலா',          '🌙', 'assets/audio/hi/chaand.mp3'),
    ReadingNum(908,'तारा',   'तारा',   'taara',     'Star',       'நட்சத்திரம்',  '⭐', 'assets/audio/hi/taara.mp3'),
    ReadingNum(909,'बादल',   'बादल',   'baadal',    'Cloud',      'மேகம்',         '☁️','assets/audio/hi/baadal.mp3'),
    ReadingNum(910,'बारिश',  'बारिश',  'baarish',   'Rain',       'மழை',           '🌧️','assets/audio/hi/baarish.mp3'),
    ReadingNum(911,'हवा',    'हवा',    'hawa',      'Wind',       'காற்று',        '💨', 'assets/audio/hi/hawa.mp3'),
    ReadingNum(912,'बर्फ',   'बर्फ',   'barf',      'Snow',       'பனி',           '❄️','assets/audio/hi/barf.mp3'),
    ReadingNum(913,'समुद्र', 'समुद्र', 'samudra',   'Sea',        'கடல்',          '🌊', 'assets/audio/hi/samudra.mp3'),
    ReadingNum(914,'जंगल',   'जंगल',   'jangal',    'Forest',     'காடு',          '🌲', 'assets/audio/hi/jangal.mp3'),
    ReadingNum(915,'रेगिस्तान','रेगिस्तान','registaan','Desert',   'பாலைவனம்',     '🏜️','assets/audio/hi/registaan.mp3'),
    ReadingNum(916,'झील',    'झील',    'jheel',     'Lake',       'ஏரி',           '🏞️','assets/audio/hi/jheel.mp3'),
    ReadingNum(917,'झरना',   'झरना',   'jharna',    'Waterfall',  'நீர்வீழ்ச்சி', '💦', 'assets/audio/hi/jharna.mp3'),
    ReadingNum(918,'घास',    'घास',    'ghaas',     'Grass',      'புல்',          '🌿', 'assets/audio/hi/ghaas.mp3'),
    ReadingNum(919,'मिट्टी', 'मिट्टी', 'mitti',     'Soil',       'மண்',           '🌍', 'assets/audio/hi/mitti.mp3'),
    ReadingNum(920,'पत्ता',  'पत्ता',  'patta',     'Leaf',       'இலை',           '🍃', 'assets/audio/hi/patta.mp3'),
  ];

  // ── Food (खाना) ──────────────────────────────────────────────────────────────
  static const List<ReadingNum> food = [
    ReadingNum(1001,'रोटी',    'रोटी',    'roti',     'Bread/Roti', 'ரொட்டி',      '🫓', 'assets/audio/hi/roti.mp3'),
    ReadingNum(1002,'चावल',    'चावल',    'chaawal',  'Rice',       'அரிசி',        '🍚', 'assets/audio/hi/chaawal.mp3'),
    ReadingNum(1003,'दाल',     'दाल',     'daal',     'Lentils',    'பருப்பு',      '🍲', 'assets/audio/hi/daal.mp3'),
    ReadingNum(1004,'दूध',     'दूध',     'doodh',    'Milk',       'பால்',         '🥛', 'assets/audio/hi/doodh.mp3'),
    ReadingNum(1005,'दही',     'दही',     'dahi',     'Curd',       'தயிர்',        '🫙', 'assets/audio/hi/dahi.mp3'),
    ReadingNum(1006,'मक्खन',   'मक्खन',   'makkhan',  'Butter',     'வெண்ணெய்',   '🧈', 'assets/audio/hi/makkhan.mp3'),
    ReadingNum(1007,'पानी',    'पानी',    'paani',    'Water',      'தண்ணீர்',     '💧', 'assets/audio/hi/paani.mp3'),
    ReadingNum(1008,'चाय',     'चाय',     'chai',     'Tea',        'தேநீர்',       '☕', 'assets/audio/hi/chai.mp3'),
    ReadingNum(1009,'चीनी',    'चीनी',    'cheeni',   'Sugar',      'சர்க்கரை',    '🍬', 'assets/audio/hi/cheeni.mp3'),
    ReadingNum(1010,'नमक',     'नमक',     'namak',    'Salt',       'உப்பு',        '🧂', 'assets/audio/hi/namak.mp3'),
    ReadingNum(1011,'तेल',     'तेल',     'tel',      'Oil',        'எண்ணெய்',     '🫙', 'assets/audio/hi/tel.mp3'),
    ReadingNum(1012,'घी',      'घी',      'ghee',     'Ghee',       'நெய்',         '🥄', 'assets/audio/hi/ghee.mp3'),
    ReadingNum(1013,'अचार',    'अचार',    'achaar',   'Pickle',     'ஊறுகாய்',     '🫙', 'assets/audio/hi/achaar.mp3'),
    ReadingNum(1014,'मिठाई',   'मिठाई',   'mithai',   'Sweets',     'இனிப்பு',     '🍮', 'assets/audio/hi/mithai.mp3'),
    ReadingNum(1015,'बिस्किट', 'बिस्किट', 'biscuit',  'Biscuit',    'பிஸ்கட்',     '🍪', 'assets/audio/hi/biscuit.mp3'),
    ReadingNum(1016,'समोसा',   'समोसा',   'samosa',   'Samosa',     'சமோசா',        '🔺', 'assets/audio/hi/samosa.mp3'),
    ReadingNum(1017,'इडली',    'इडली',    'idli',     'Idli',       'இட்லி',        '🍱', 'assets/audio/hi/idli.mp3'),
    ReadingNum(1018,'पूरी',    'पूरी',    'puri',     'Puri',       'பூரி',         '🫓', 'assets/audio/hi/puri.mp3'),
    ReadingNum(1019,'खिचड़ी',  'खिचड़ी',  'khichdi',  'Khichdi',    'கிச்சடி',     '🍛', 'assets/audio/hi/khichdi.mp3'),
    ReadingNum(1020,'सब्ज़ी',  'सब्ज़ी',  'sabzi',    'Vegetables', 'காய்கறி',     '🥘', 'assets/audio/hi/sabzi.mp3'),
  ];

  // ── Helpers ──────────────────────────────────────────────────────────────────
  static List<ReadingNum> get allItems => [
    ...numbers, ...animals, ...fruits, ...vegetables,
    ...colors, ...bodyParts, ...family, ...transport,
    ...school, ...nature, ...food,
  ];

  static const List<String> categoryNames = [
    'संख्याएँ', 'जानवर', 'फल', 'सब्ज़ियाँ', 'रंग',
    'शरीर', 'परिवार', 'यातायात', 'विद्यालय', 'प्रकृति', 'खाना',
  ];

  static const List<String> categoryEmojis = [
    '🔢', '🦁', '🍎', '🥦', '🎨', '👁️', '👨‍👩‍👧', '🚗', '📚', '🌳', '🍛',
  ];

  static List<ReadingNum> getCategory(int i) {
    switch (i) {
      case 0:  return numbers;
      case 1:  return animals;
      case 2:  return fruits;
      case 3:  return vegetables;
      case 4:  return colors;
      case 5:  return bodyParts;
      case 6:  return family;
      case 7:  return transport;
      case 8:  return school;
      case 9:  return nature;
      case 10: return food;
      default: return numbers;
    }
  }

  /// Legacy accessor kept for backward compat (progress screen etc.)
  static List<ReadingNum> get items => numbers;
}
