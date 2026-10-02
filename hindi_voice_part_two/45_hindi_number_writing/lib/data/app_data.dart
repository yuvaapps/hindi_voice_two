
import '../models/num_write.dart';

class AppData {
  /// Numbers 1–100
  static const List<NumWrite> numbers = [
    NumWrite(1,  '१',  'ek',          'One',         'ஒன்று',       'assets/audio/hi/ek.mp3'),
    NumWrite(2,  '२',  'do',          'Two',         'இரண்டு',      'assets/audio/hi/do.mp3'),
    NumWrite(3,  '३',  'teen',        'Three',       'மூன்று',      'assets/audio/hi/teen.mp3'),
    NumWrite(4,  '४',  'chaar',       'Four',        'நான்கு',      'assets/audio/hi/chaar.mp3'),
    NumWrite(5,  '५',  'paanch',      'Five',        'ஐந்து',       'assets/audio/hi/paanch.mp3'),
    NumWrite(6,  '६',  'chhah',       'Six',         'ஆறு',         'assets/audio/hi/chhah.mp3'),
    NumWrite(7,  '७',  'saat',        'Seven',       'ஏழு',         'assets/audio/hi/saat.mp3'),
    NumWrite(8,  '८',  'aath',        'Eight',       'எட்டு',       'assets/audio/hi/aath.mp3'),
    NumWrite(9,  '९',  'nau',         'Nine',        'ஒன்பது',      'assets/audio/hi/nau.mp3'),
    NumWrite(10, '१०', 'das',         'Ten',         'பத்து',       'assets/audio/hi/das.mp3'),
    NumWrite(11, '११', 'gyaarah',     'Eleven',      'பதினொன்று',   'assets/audio/hi/gyaarah.mp3'),
    NumWrite(12, '१२', 'baarah',      'Twelve',      'பன்னிரண்டு', 'assets/audio/hi/baarah.mp3'),
    NumWrite(13, '१३', 'terah',       'Thirteen',    'பதின்மூன்று', 'assets/audio/hi/terah.mp3'),
    NumWrite(14, '१४', 'chaudah',     'Fourteen',    'பதினான்கு',   'assets/audio/hi/chaudah.mp3'),
    NumWrite(15, '१५', 'pandrah',     'Fifteen',     'பதினைந்து',   'assets/audio/hi/pandrah.mp3'),
    NumWrite(16, '१६', 'solah',       'Sixteen',     'பதினாறு',     'assets/audio/hi/solah.mp3'),
    NumWrite(17, '१७', 'satrah',      'Seventeen',   'பதினேழு',     'assets/audio/hi/satrah.mp3'),
    NumWrite(18, '१८', 'attharah',    'Eighteen',    'பதினெட்டு',   'assets/audio/hi/attharah.mp3'),
    NumWrite(19, '१९', 'unnees',      'Nineteen',    'பத்தொன்பது',  'assets/audio/hi/unnees.mp3'),
    NumWrite(20, '२०', 'bees',        'Twenty',      'இருபது',      'assets/audio/hi/bees.mp3'),
    NumWrite(21, '२१', 'ikkees',      'Twenty-One',  'இருபத்தொன்று','assets/audio/hi/ikkees.mp3'),
    NumWrite(22, '२२', 'baais',       'Twenty-Two',  'இருபத்திரண்டு','assets/audio/hi/baais.mp3'),
    NumWrite(23, '२३', 'teis',        'Twenty-Three','இருபத்துமூன்று','assets/audio/hi/teis.mp3'),
    NumWrite(24, '२४', 'chaubbees',   'Twenty-Four', 'இருபத்துநான்கு','assets/audio/hi/chaubbees.mp3'),
    NumWrite(25, '२५', 'pachchees',   'Twenty-Five', 'இருபத்தைந்து','assets/audio/hi/pachchees.mp3'),
    NumWrite(26, '२६', 'chhabbees',   'Twenty-Six',  'இருபத்தாறு',  'assets/audio/hi/chhabbees.mp3'),
    NumWrite(27, '२७', 'sattaees',    'Twenty-Seven','இருபத்தேழு',  'assets/audio/hi/sattaees.mp3'),
    NumWrite(28, '२८', 'atthaees',    'Twenty-Eight','இருபத்தெட்டு','assets/audio/hi/atthaees.mp3'),
    NumWrite(29, '२९', 'unnattees',   'Twenty-Nine', 'இருபத்தொன்பது','assets/audio/hi/unnattees.mp3'),
    NumWrite(30, '३०', 'tees',        'Thirty',      'முப்பது',     'assets/audio/hi/tees.mp3'),
    NumWrite(31, '३१', 'iktees',      'Thirty-One',  'முப்பத்தொன்று','assets/audio/hi/iktees.mp3'),
    NumWrite(32, '३२', 'battees',     'Thirty-Two',  'முப்பத்திரண்டு','assets/audio/hi/battees.mp3'),
    NumWrite(33, '३३', 'taintees',    'Thirty-Three','முப்பத்துமூன்று','assets/audio/hi/taintees.mp3'),
    NumWrite(34, '३४', 'chauntees',   'Thirty-Four', 'முப்பத்துநான்கு','assets/audio/hi/chauntees.mp3'),
    NumWrite(35, '३५', 'paintees',    'Thirty-Five', 'முப்பத்தைந்து','assets/audio/hi/paintees.mp3'),
    NumWrite(36, '३६', 'chhattees',   'Thirty-Six',  'முப்பத்தாறு', 'assets/audio/hi/chhattees.mp3'),
    NumWrite(37, '३७', 'sainttees',   'Thirty-Seven','முப்பத்தேழு', 'assets/audio/hi/sainttees.mp3'),
    NumWrite(38, '३८', 'artees',      'Thirty-Eight','முப்பத்தெட்டு','assets/audio/hi/artees.mp3'),
    NumWrite(39, '३९', 'untaalees',   'Thirty-Nine', 'முப்பத்தொன்பது','assets/audio/hi/untaalees.mp3'),
    NumWrite(40, '४०', 'chaalees',    'Forty',       'நாற்பது',     'assets/audio/hi/chaalees.mp3'),
    NumWrite(41, '४१', 'iktaalees',   'Forty-One',   'நாற்பத்தொன்று','assets/audio/hi/iktaalees.mp3'),
    NumWrite(42, '४२', 'bayaalees',   'Forty-Two',   'நாற்பத்திரண்டு','assets/audio/hi/bayaalees.mp3'),
    NumWrite(43, '४३', 'tantaalees',  'Forty-Three', 'நாற்பத்துமூன்று','assets/audio/hi/tantaalees.mp3'),
    NumWrite(44, '४४', 'chauvaalees', 'Forty-Four',  'நாற்பத்துநான்கு','assets/audio/hi/chauvaalees.mp3'),
    NumWrite(45, '४५', 'paintaalees', 'Forty-Five',  'நாற்பத்தைந்து','assets/audio/hi/paintaalees.mp3'),
    NumWrite(46, '४६', 'chhiyaalees', 'Forty-Six',   'நாற்பத்தாறு', 'assets/audio/hi/chhiyaalees.mp3'),
    NumWrite(47, '४७', 'saintaalees', 'Forty-Seven', 'நாற்பத்தேழு', 'assets/audio/hi/saintaalees.mp3'),
    NumWrite(48, '४८', 'artaalees',   'Forty-Eight', 'நாற்பத்தெட்டு','assets/audio/hi/artaalees.mp3'),
    NumWrite(49, '४९', 'unchaas',     'Forty-Nine',  'நாற்பத்தொன்பது','assets/audio/hi/unchaas.mp3'),
    NumWrite(50, '५०', 'pachaas',     'Fifty',       'ஐம்பது',      'assets/audio/hi/pachaas.mp3'),
    NumWrite(51, '५१', 'ikyaavan',    'Fifty-One',   'ஐம்பத்தொன்று','assets/audio/hi/ikyaavan.mp3'),
    NumWrite(52, '५२', 'baavan',      'Fifty-Two',   'ஐம்பத்திரண்டு','assets/audio/hi/baavan.mp3'),
    NumWrite(53, '५३', 'tirpan',      'Fifty-Three', 'ஐம்பத்துமூன்று','assets/audio/hi/tirpan.mp3'),
    NumWrite(54, '५४', 'chauvan',     'Fifty-Four',  'ஐம்பத்துநான்கு','assets/audio/hi/chauvan.mp3'),
    NumWrite(55, '५५', 'pachpan',     'Fifty-Five',  'ஐம்பத்தைந்து','assets/audio/hi/pachpan.mp3'),
    NumWrite(56, '५६', 'chhappan',    'Fifty-Six',   'ஐம்பத்தாறு',  'assets/audio/hi/chhappan.mp3'),
    NumWrite(57, '५७', 'sattaavan',   'Fifty-Seven', 'ஐம்பத்தேழு',  'assets/audio/hi/sattaavan.mp3'),
    NumWrite(58, '५८', 'atthaavan',   'Fifty-Eight', 'ஐம்பத்தெட்டு','assets/audio/hi/atthaavan.mp3'),
    NumWrite(59, '५९', 'unsath',      'Fifty-Nine',  'ஐம்பத்தொன்பது','assets/audio/hi/unsath.mp3'),
    NumWrite(60, '६०', 'saath',       'Sixty',       'அறுபது',      'assets/audio/hi/saath.mp3'),
    NumWrite(61, '६१', 'iksath',      'Sixty-One',   'அறுபத்தொன்று','assets/audio/hi/iksath.mp3'),
    NumWrite(62, '६२', 'baasath',     'Sixty-Two',   'அறுபத்திரண்டு','assets/audio/hi/baasath.mp3'),
    NumWrite(63, '६३', 'tirsath',     'Sixty-Three', 'அறுபத்துமூன்று','assets/audio/hi/tirsath.mp3'),
    NumWrite(64, '६४', 'chausath',    'Sixty-Four',  'அறுபத்துநான்கு','assets/audio/hi/chausath.mp3'),
    NumWrite(65, '६५', 'painsath',    'Sixty-Five',  'அறுபத்தைந்து','assets/audio/hi/painsath.mp3'),
    NumWrite(66, '६६', 'chhiyasath',  'Sixty-Six',   'அறுபத்தாறு',  'assets/audio/hi/chhiyasath.mp3'),
    NumWrite(67, '६७', 'sarsath',     'Sixty-Seven', 'அறுபத்தேழு',  'assets/audio/hi/sarsath.mp3'),
    NumWrite(68, '६८', 'arsath',      'Sixty-Eight', 'அறுபத்தெட்டு','assets/audio/hi/arsath.mp3'),
    NumWrite(69, '६९', 'unhattar',    'Sixty-Nine',  'அறுபத்தொன்பது','assets/audio/hi/unhattar.mp3'),
    NumWrite(70, '७०', 'sattar',      'Seventy',     'எழுபது',      'assets/audio/hi/sattar.mp3'),
    NumWrite(71, '७१', 'ikahattar',   'Seventy-One', 'எழுபத்தொன்று','assets/audio/hi/ikahattar.mp3'),
    NumWrite(72, '७२', 'bahattar',    'Seventy-Two', 'எழுபத்திரண்டு','assets/audio/hi/bahattar.mp3'),
    NumWrite(73, '७३', 'tihattar',    'Seventy-Three','எழுபத்துமூன்று','assets/audio/hi/tihattar.mp3'),
    NumWrite(74, '७४', 'chauhattar',  'Seventy-Four','எழுபத்துநான்கு','assets/audio/hi/chauhattar.mp3'),
    NumWrite(75, '७५', 'pachattar',   'Seventy-Five','எழுபத்தைந்து','assets/audio/hi/pachattar.mp3'),
    NumWrite(76, '७६', 'chhihattar',  'Seventy-Six', 'எழுபத்தாறு',  'assets/audio/hi/chhihattar.mp3'),
    NumWrite(77, '७७', 'satattar',    'Seventy-Seven','எழுபத்தேழு', 'assets/audio/hi/satattar.mp3'),
    NumWrite(78, '७८', 'atthattar',   'Seventy-Eight','எழுபத்தெட்டு','assets/audio/hi/atthattar.mp3'),
    NumWrite(79, '७९', 'unnaasi',     'Seventy-Nine','எழுபத்தொன்பது','assets/audio/hi/unnaasi.mp3'),
    NumWrite(80, '८०', 'assi',        'Eighty',      'எண்பது',      'assets/audio/hi/assi.mp3'),
    NumWrite(81, '८१', 'ikyaasi',     'Eighty-One',  'எண்பத்தொன்று','assets/audio/hi/ikyaasi.mp3'),
    NumWrite(82, '८२', 'bayaasi',     'Eighty-Two',  'எண்பத்திரண்டு','assets/audio/hi/bayaasi.mp3'),
    NumWrite(83, '८३', 'tiraasi',     'Eighty-Three','எண்பத்துமூன்று','assets/audio/hi/tiraasi.mp3'),
    NumWrite(84, '८४', 'chauraasi',   'Eighty-Four', 'எண்பத்துநான்கு','assets/audio/hi/chauraasi.mp3'),
    NumWrite(85, '८५', 'pachaasi',    'Eighty-Five', 'எண்பத்தைந்து','assets/audio/hi/pachaasi.mp3'),
    NumWrite(86, '८६', 'chhiyaasi',   'Eighty-Six',  'எண்பத்தாறு',  'assets/audio/hi/chhiyaasi.mp3'),
    NumWrite(87, '८७', 'sattaasi',    'Eighty-Seven','எண்பத்தேழு',  'assets/audio/hi/sattaasi.mp3'),
    NumWrite(88, '८८', 'atthaasi',    'Eighty-Eight','எண்பத்தெட்டு','assets/audio/hi/atthaasi.mp3'),
    NumWrite(89, '८९', 'navaasi',     'Eighty-Nine', 'எண்பத்தொன்பது','assets/audio/hi/navaasi.mp3'),
    NumWrite(90, '९०', 'nabbe',       'Ninety',      'தொண்ணூறு',    'assets/audio/hi/nabbe.mp3'),
    NumWrite(91, '९१', 'ikyaanave',   'Ninety-One',  'தொண்ணூற்றொன்று','assets/audio/hi/ikyaanave.mp3'),
    NumWrite(92, '९२', 'baaanave',    'Ninety-Two',  'தொண்ணூற்றிரண்டு','assets/audio/hi/baaanave.mp3'),
    NumWrite(93, '९३', 'tiraaanave',  'Ninety-Three','தொண்ணூற்றுமூன்று','assets/audio/hi/tiraaanave.mp3'),
    NumWrite(94, '९४', 'chauraanave', 'Ninety-Four', 'தொண்ணூற்றுநான்கு','assets/audio/hi/chauraanave.mp3'),
    NumWrite(95, '९५', 'panchaanave', 'Ninety-Five', 'தொண்ணூற்றைந்து','assets/audio/hi/panchaanave.mp3'),
    NumWrite(96, '९६', 'chhiyaanave','Ninety-Six',  'தொண்ணூற்றாறு','assets/audio/hi/chhiyaanave.mp3'),
    NumWrite(97, '९७', 'sattaanave',  'Ninety-Seven','தொண்ணூற்றேழு','assets/audio/hi/sattaanave.mp3'),
    NumWrite(98, '९८', 'atthaanave',  'Ninety-Eight','தொண்ணூற்றெட்டு','assets/audio/hi/atthaanave.mp3'),
    NumWrite(99, '९९', 'ninyaanave',  'Ninety-Nine', 'தொண்ணூற்றொன்பது','assets/audio/hi/ninyaanave.mp3'),
    NumWrite(100,'१००','sau',         'Hundred',     'நூறு',         'assets/audio/hi/sau.mp3'),
  ];

  /// Animals (जानवर) — 50+ words
  static const List<NumWrite> animals = [
    NumWrite(101, 'कुत्ता',  'kuttaa',     'Dog',      'நாய்',         'assets/audio/hi/kuttaa.mp3'),
    NumWrite(102, 'बिल्ली',  'billi',      'Cat',      'பூனை',         'assets/audio/hi/billi.mp3'),
    NumWrite(103, 'गाय',     'gaay',       'Cow',      'பசு',          'assets/audio/hi/gaay.mp3'),
    NumWrite(104, 'घोड़ा',   'ghoda',      'Horse',    'குதிரை',       'assets/audio/hi/ghoda.mp3'),
    NumWrite(105, 'हाथी',    'haathi',     'Elephant', 'யானை',         'assets/audio/hi/haathi.mp3'),
    NumWrite(106, 'शेर',     'sher',       'Lion',     'சிங்கம்',      'assets/audio/hi/sher.mp3'),
    NumWrite(107, 'बाघ',     'baagh',      'Tiger',    'புலி',         'assets/audio/hi/baagh.mp3'),
    NumWrite(108, 'बंदर',    'bandar',     'Monkey',   'குரங்கு',      'assets/audio/hi/bandar.mp3'),
    NumWrite(109, 'हिरण',    'hiran',      'Deer',     'மான்',         'assets/audio/hi/hiran.mp3'),
    NumWrite(110, 'खरगोश',   'kharagosh',  'Rabbit',   'முயல்',        'assets/audio/hi/kharagosh.mp3'),
    NumWrite(111, 'भालू',    'bhaalu',     'Bear',     'கரடி',         'assets/audio/hi/bhaalu.mp3'),
    NumWrite(112, 'लोमड़ी',  'lomdi',      'Fox',      'நரி',          'assets/audio/hi/lomdi.mp3'),
    NumWrite(113, 'भेड़िया', 'bhediya',    'Wolf',     'ஓநாய்',        'assets/audio/hi/bhediya.mp3'),
    NumWrite(114, 'जिराफ',   'jiraaf',     'Giraffe',  'ஒட்டகச்சிவிங்கி','assets/audio/hi/jiraaf.mp3'),
    NumWrite(115, 'ज़ेब्रा',  'zebra',      'Zebra',    'வரிக்குதிரை',  'assets/audio/hi/zebra.mp3'),
    NumWrite(116, 'पक्षी',   'pakshi',     'Bird',     'பறவை',         'assets/audio/hi/pakshi.mp3'),
    NumWrite(117, 'तोता',    'tota',       'Parrot',   'கிளி',         'assets/audio/hi/tota.mp3'),
    NumWrite(118, 'कोयल',    'koyal',      'Cuckoo',   'குயில்',       'assets/audio/hi/koyal.mp3'),
    NumWrite(119, 'मछली',    'machhli',    'Fish',     'மீன்',         'assets/audio/hi/machhli.mp3'),
    NumWrite(120, 'मेंढक',   'mendhak',    'Frog',     'தவளை',         'assets/audio/hi/mendhak.mp3'),
    NumWrite(121, 'साँप',    'saanp',      'Snake',    'பாம்பு',       'assets/audio/hi/saanp.mp3'),
    NumWrite(122, 'कछुआ',    'kachhuwaa',  'Tortoise', 'ஆமை',          'assets/audio/hi/kachhuwaa.mp3'),
    NumWrite(123, 'मगरमच्छ', 'magarmachchh','Crocodile','முதலை',       'assets/audio/hi/magarmachchh.mp3'),
    NumWrite(124, 'गिलहरी',  'gilhari',    'Squirrel', 'அணில்',        'assets/audio/hi/gilhari.mp3'),
    NumWrite(125, 'ऊँट',     'unt',        'Camel',    'ஒட்டகம்',      'assets/audio/hi/unt.mp3'),
    NumWrite(126, 'भैंस',    'bhains',     'Buffalo',  'எருமை',        'assets/audio/hi/bhains.mp3'),
    NumWrite(127, 'बकरी',    'bakri',      'Goat',     'வெள்ளாடு',     'assets/audio/hi/bakri.mp3'),
    NumWrite(128, 'भेड़',    'bhed',       'Sheep',    'செம்மறியாடு',  'assets/audio/hi/bhed.mp3'),
    NumWrite(129, 'मुर्गा',  'murga',      'Rooster',  'கோழி',         'assets/audio/hi/murga.mp3'),
    NumWrite(130, 'बत्तख',   'battakh',    'Duck',     'வாத்து',       'assets/audio/hi/battakh.mp3'),
    NumWrite(131, 'मोर',     'mor',        'Peacock',  'மயில்',        'assets/audio/hi/mor.mp3'),
    NumWrite(132, 'कौआ',     'kaua',       'Crow',     'காகம்',        'assets/audio/hi/kaua.mp3'),
    NumWrite(133, 'चिड़िया', 'chidiya',    'Sparrow',  'சிட்டுக்குருவி','assets/audio/hi/chidiya.mp3'),
    NumWrite(134, 'उल्लू',   'ullu',       'Owl',      'ஆந்தை',        'assets/audio/hi/ullu.mp3'),
    NumWrite(135, 'बाज',     'baaj',       'Eagle',    'கழுகு',        'assets/audio/hi/baaj.mp3'),
  ];

  /// Fruits (फल) — 30+ words
  static const List<NumWrite> fruits = [
    NumWrite(201, 'सेब',      'seb',        'Apple',      'ஆப்பிள்',     'assets/audio/hi/seb.mp3'),
    NumWrite(202, 'केला',     'kela',       'Banana',     'வாழைப்பழம்',  'assets/audio/hi/kela.mp3'),
    NumWrite(203, 'आम',       'aam',        'Mango',      'மாம்பழம்',    'assets/audio/hi/aam.mp3'),
    NumWrite(204, 'अंगूर',    'angur',      'Grapes',     'திராட்சை',     'assets/audio/hi/angur.mp3'),
    NumWrite(205, 'संतरा',    'santra',     'Orange',     'ஆரஞ்சு',       'assets/audio/hi/santra.mp3'),
    NumWrite(206, 'अनानास',   'anaanas',    'Pineapple',  'அன்னாசி',      'assets/audio/hi/anaanas.mp3'),
    NumWrite(207, 'तरबूज',    'tarbuz',     'Watermelon', 'தர்பூசணி',    'assets/audio/hi/tarbuz.mp3'),
    NumWrite(208, 'खरबूजा',   'kharbuja',   'Muskmelon',  'முலாம்பழம்',  'assets/audio/hi/kharbuja.mp3'),
    NumWrite(209, 'पपीता',    'papeeta',    'Papaya',     'பப்பாளி',      'assets/audio/hi/papeeta.mp3'),
    NumWrite(210, 'नारियल',   'naariyal',   'Coconut',    'தேங்காய்',     'assets/audio/hi/naariyal.mp3'),
    NumWrite(211, 'अमरूद',    'amrud',      'Guava',      'கொய்யா',       'assets/audio/hi/amrud.mp3'),
    NumWrite(212, 'अनार',     'anaar',      'Pomegranate','மாதுளை',       'assets/audio/hi/anaar.mp3'),
    NumWrite(213, 'चेरी',     'cheri',      'Cherry',     'செர்ரி',       'assets/audio/hi/cheri.mp3'),
    NumWrite(214, 'स्ट्रॉबेरी','strawberry', 'Strawberry', 'ஸ்ட்ராபெர்ரி','assets/audio/hi/strawberry.mp3'),
    NumWrite(215, 'लीची',     'leechi',     'Lychee',     'லிச்சி',       'assets/audio/hi/leechi.mp3'),
    NumWrite(216, 'नाशपाती',  'naashpaati', 'Pear',       'பேரிக்காய்',  'assets/audio/hi/naashpaati.mp3'),
    NumWrite(217, 'कीवी',     'kiwi',       'Kiwi',       'கிவி',         'assets/audio/hi/kiwi.mp3'),
    NumWrite(218, 'खजूर',     'khajur',     'Date',       'பேரீச்சம்பழம்','assets/audio/hi/khajur.mp3'),
    NumWrite(219, 'बेर',      'ber',        'Jujube',     'இலந்தைப்பழம்','assets/audio/hi/ber.mp3'),
    NumWrite(220, 'जामुन',    'jaamun',     'Blackberry', 'நாவல்பழம்',   'assets/audio/hi/jaamun.mp3'),
  ];

  /// Vegetables (सब्ज़ी) — 30+ words
  static const List<NumWrite> vegetables = [
    NumWrite(301, 'आलू',      'aalu',       'Potato',     'உருளைக்கிழங்கு','assets/audio/hi/aalu.mp3'),
    NumWrite(302, 'प्याज',    'pyaaj',      'Onion',      'வெங்காயம்',   'assets/audio/hi/pyaaj.mp3'),
    NumWrite(303, 'टमाटर',    'tamaatar',   'Tomato',     'தக்காளி',      'assets/audio/hi/tamaatar.mp3'),
    NumWrite(304, 'गोभी',     'gobhi',      'Cauliflower','காலிஃப்ளவர்',  'assets/audio/hi/gobhi.mp3'),
    NumWrite(305, 'बैंगन',    'baigan',     'Brinjal',    'கத்திரிக்காய்','assets/audio/hi/baigan.mp3'),
    NumWrite(306, 'भिंडी',    'bhindi',     'Okra',       'வெண்டைக்காய்','assets/audio/hi/bhindi.mp3'),
    NumWrite(307, 'पालक',     'paalak',     'Spinach',    'கீரை',         'assets/audio/hi/paalak.mp3'),
    NumWrite(308, 'गाजर',     'gaajar',     'Carrot',     'கேரட்',        'assets/audio/hi/gaajar.mp3'),
    NumWrite(309, 'मटर',      'matar',      'Peas',       'பட்டாணி',      'assets/audio/hi/matar.mp3'),
    NumWrite(310, 'लौकी',     'lauki',      'Gourd',      'சுரைக்காய்',   'assets/audio/hi/lauki.mp3'),
    NumWrite(311, 'करेला',    'karela',     'Bitter Gourd','பாவக்காய்',   'assets/audio/hi/karela.mp3'),
    NumWrite(312, 'मूली',     'muli',       'Radish',     'முள்ளங்கி',    'assets/audio/hi/muli.mp3'),
    NumWrite(313, 'शकरकंद',   'shakarkand', 'Sweet Potato','சர்க்கரைவள்ளி','assets/audio/hi/shakarkand.mp3'),
    NumWrite(314, 'खीरा',     'kheera',     'Cucumber',   'வெள்ளரிக்காய்','assets/audio/hi/kheera.mp3'),
    NumWrite(315, 'कद्दू',    'kaddu',      'Pumpkin',    'பூசணிக்காய்',  'assets/audio/hi/kaddu.mp3'),
    NumWrite(316, 'अदरक',     'adrak',      'Ginger',     'இஞ்சி',        'assets/audio/hi/adrak.mp3'),
    NumWrite(317, 'लहसुन',    'lahsun',     'Garlic',     'பூண்டு',       'assets/audio/hi/lahsun.mp3'),
    NumWrite(318, 'हरी मिर्च','hari mirch', 'Green Chilli','பச்சை மிளகாய்','assets/audio/hi/hari_mirch.mp3'),
    NumWrite(319, 'शिमला मिर्च','shimla mirch','Capsicum',  'குடைமிளகாய்', 'assets/audio/hi/shimla_mirch.mp3'),
    NumWrite(320, 'मशरूम',    'mashrum',    'Mushroom',   'காளான்',       'assets/audio/hi/mashrum.mp3'),
  ];

  /// Colors (रंग) — 20 words
  static const List<NumWrite> colors = [
    NumWrite(401, 'लाल',     'laal',       'Red',        'சிவப்பு',      'assets/audio/hi/laal.mp3'),
    NumWrite(402, 'नीला',    'neela',      'Blue',       'நீலம்',        'assets/audio/hi/neela.mp3'),
    NumWrite(403, 'हरा',     'hara',       'Green',      'பச்சை',        'assets/audio/hi/hara.mp3'),
    NumWrite(404, 'पीला',    'peela',      'Yellow',     'மஞ்சள்',       'assets/audio/hi/peela.mp3'),
    NumWrite(405, 'सफ़ेद',   'safed',      'White',      'வெள்ளை',       'assets/audio/hi/safed.mp3'),
    NumWrite(406, 'काला',    'kaala',      'Black',      'கறுப்பு',      'assets/audio/hi/kaala.mp3'),
    NumWrite(407, 'नारंगी',  'narangi',    'Orange',     'ஆரஞ்சு நிறம்', 'assets/audio/hi/narangi.mp3'),
    NumWrite(408, 'गुलाबी',  'gulaabi',    'Pink',       'இளஞ்சிவப்பு', 'assets/audio/hi/gulaabi.mp3'),
    NumWrite(409, 'बैंगनी',  'baingani',   'Purple',     'ஊதா',          'assets/audio/hi/baingani.mp3'),
    NumWrite(410, 'भूरा',    'bhoora',     'Brown',      'பழுப்பு',      'assets/audio/hi/bhoora.mp3'),
    NumWrite(411, 'सोना',    'sona',       'Golden',     'தங்க நிறம்',   'assets/audio/hi/sona_color.mp3'),
    NumWrite(412, 'चाँदी',   'chaandi',    'Silver',     'வெள்ளி நிறம்', 'assets/audio/hi/chaandi_color.mp3'),
    NumWrite(413, 'आसमानी',  'aasamaani',  'Sky Blue',   'வான்நீலம்',    'assets/audio/hi/aasamaani.mp3'),
    NumWrite(414, 'गहरा नीला','gahra neela','Dark Blue',  'அடர்நீலம்',   'assets/audio/hi/gahra_neela.mp3'),
    NumWrite(415, 'हल्का नीला','halka neela','Light Blue', 'இளநீலம்',     'assets/audio/hi/halka_neela.mp3'),
    NumWrite(416, 'मरून',    'maroon',     'Maroon',     'கருஞ்சிவப்பு', 'assets/audio/hi/maroon.mp3'),
    NumWrite(417, 'क्रीम',   'cream',      'Cream',      'கிரீம் நிறம்', 'assets/audio/hi/cream.mp3'),
    NumWrite(418, 'धूसर',    'dhusar',     'Grey',       'சாம்பல்',      'assets/audio/hi/dhusar.mp3'),
    NumWrite(419, 'फ़िरोज़ी', 'firozi',     'Turquoise',  'கருநீலம்',     'assets/audio/hi/firozi.mp3'),
    NumWrite(420, 'जैतूनी',  'jaitooni',   'Olive',      'ஆலிவ் நிறம்',  'assets/audio/hi/jaitooni.mp3'),
  ];

  /// Body Parts (शरीर के अंग) — 25 words
  static const List<NumWrite> bodyParts = [
    NumWrite(501, 'सिर',     'sir',        'Head',       'தலை',          'assets/audio/hi/sir.mp3'),
    NumWrite(502, 'आँख',     'aankh',      'Eye',        'கண்',           'assets/audio/hi/aankh.mp3'),
    NumWrite(503, 'नाक',     'naak',       'Nose',       'மூக்கு',        'assets/audio/hi/naak.mp3'),
    NumWrite(504, 'कान',     'kaan',       'Ear',        'காது',          'assets/audio/hi/kaan.mp3'),
    NumWrite(505, 'मुँह',    'munh',       'Mouth',      'வாய்',          'assets/audio/hi/munh.mp3'),
    NumWrite(506, 'दाँत',    'daant',      'Teeth',      'பல்',           'assets/audio/hi/daant.mp3'),
    NumWrite(507, 'जीभ',     'jeebh',      'Tongue',     'நாக்கு',        'assets/audio/hi/jeebh.mp3'),
    NumWrite(508, 'बाल',     'baal',       'Hair',       'தலைமுடி',       'assets/audio/hi/baal.mp3'),
    NumWrite(509, 'गर्दन',   'gardan',     'Neck',       'கழுத்து',       'assets/audio/hi/gardan.mp3'),
    NumWrite(510, 'कंधा',    'kandha',     'Shoulder',   'தோள்',          'assets/audio/hi/kandha.mp3'),
    NumWrite(511, 'हाथ',     'haath',      'Hand',       'கை',            'assets/audio/hi/haath.mp3'),
    NumWrite(512, 'उँगली',   'ungali',     'Finger',     'விரல்',         'assets/audio/hi/ungali.mp3'),
    NumWrite(513, 'पेट',     'pet',        'Stomach',    'வயிறு',         'assets/audio/hi/pet.mp3'),
    NumWrite(514, 'पीठ',     'peeth',      'Back',       'முதுகு',        'assets/audio/hi/peeth.mp3'),
    NumWrite(515, 'पैर',     'pair',       'Leg',        'கால்',          'assets/audio/hi/pair.mp3'),
    NumWrite(516, 'घुटना',   'ghutna',     'Knee',       'முழங்கால்',     'assets/audio/hi/ghutna.mp3'),
    NumWrite(517, 'पंजा',    'panja',      'Paw / Foot', 'பாதம்',         'assets/audio/hi/panja.mp3'),
    NumWrite(518, 'छाती',    'chhaati',    'Chest',      'மார்பு',        'assets/audio/hi/chhaati.mp3'),
    NumWrite(519, 'दिल',     'dil',        'Heart',      'இதயம்',         'assets/audio/hi/dil.mp3'),
    NumWrite(520, 'नाखून',   'naakhun',    'Nail',       'நகம்',          'assets/audio/hi/naakhun.mp3'),
  ];

  /// Family (परिवार) — 20 words
  static const List<NumWrite> family = [
    NumWrite(601, 'माँ',     'maa',        'Mother',     'அம்மா',         'assets/audio/hi/maa.mp3'),
    NumWrite(602, 'पिता',    'pita',       'Father',     'அப்பா',         'assets/audio/hi/pita.mp3'),
    NumWrite(603, 'दादा',    'daada',      'Grandfather','தாத்தா',         'assets/audio/hi/daada.mp3'),
    NumWrite(604, 'दादी',    'daadi',      'Grandmother','பாட்டி',         'assets/audio/hi/daadi.mp3'),
    NumWrite(605, 'भाई',     'bhai',       'Brother',    'அண்ணன்/தம்பி',  'assets/audio/hi/bhai.mp3'),
    NumWrite(606, 'बहन',     'bahan',      'Sister',     'அக்கா/தங்கை',   'assets/audio/hi/bahan.mp3'),
    NumWrite(607, 'चाचा',    'chacha',     'Uncle',      'சித்தப்பா',      'assets/audio/hi/chacha.mp3'),
    NumWrite(608, 'चाची',    'chaachi',    'Aunt',       'சித்தி',         'assets/audio/hi/chaachi.mp3'),
    NumWrite(609, 'मामा',    'mama',       'Maternal Uncle','மாமா',        'assets/audio/hi/mama.mp3'),
    NumWrite(610, 'मामी',    'maami',      'Maternal Aunt','மாமி',          'assets/audio/hi/maami.mp3'),
    NumWrite(611, 'बेटा',    'beta',       'Son',        'மகன்',           'assets/audio/hi/beta.mp3'),
    NumWrite(612, 'बेटी',    'beti',       'Daughter',   'மகள்',           'assets/audio/hi/beti.mp3'),
    NumWrite(613, 'पति',     'pati',       'Husband',    'கணவன்',          'assets/audio/hi/pati.mp3'),
    NumWrite(614, 'पत्नी',   'patni',      'Wife',       'மனைவி',          'assets/audio/hi/patni.mp3'),
    NumWrite(615, 'नाना',    'naana',      'Maternal Grandfather','நாட்டுத் தாத்தா','assets/audio/hi/naana.mp3'),
    NumWrite(616, 'नानी',    'naani',      'Maternal Grandmother','நாட்டுப் பாட்டி','assets/audio/hi/naani.mp3'),
    NumWrite(617, 'फूफा',    'phupha',     'Paternal Aunt\'s Husband','அத்தை மாமன்','assets/audio/hi/phupha.mp3'),
    NumWrite(618, 'बुआ',     'bua',        'Paternal Aunt','அத்தை',        'assets/audio/hi/bua.mp3'),
    NumWrite(619, 'भतीजा',   'bhatija',    'Nephew',     'மருமகன்',        'assets/audio/hi/bhatija.mp3'),
    NumWrite(620, 'भतीजी',   'bhatiji',    'Niece',      'மருமகள்',        'assets/audio/hi/bhatiji.mp3'),
  ];

  /// Transport (यातायात) — 20 words
  static const List<NumWrite> transport = [
    NumWrite(701, 'कार',      'car',        'Car',        'கார்',           'assets/audio/hi/car.mp3'),
    NumWrite(702, 'बस',       'bus',        'Bus',        'பேருந்து',       'assets/audio/hi/bus.mp3'),
    NumWrite(703, 'ट्रेन',    'train',      'Train',      'தொடர்வண்டி',    'assets/audio/hi/train.mp3'),
    NumWrite(704, 'हवाई जहाज','hawai jahaz','Aeroplane',  'விமானம்',       'assets/audio/hi/hawai_jahaz.mp3'),
    NumWrite(705, 'जहाज',     'jahaz',      'Ship',       'கப்பல்',        'assets/audio/hi/jahaz.mp3'),
    NumWrite(706, 'साइकिल',   'cycle',      'Bicycle',    'மிதிவண்டி',     'assets/audio/hi/cycle.mp3'),
    NumWrite(707, 'मोटरसाइकिल','motorcycle','Motorcycle', 'மோட்டார் சைக்கிள்','assets/audio/hi/motorcycle.mp3'),
    NumWrite(708, 'ट्रक',     'truck',      'Truck',      'லாரி',           'assets/audio/hi/truck.mp3'),
    NumWrite(709, 'ऑटो',      'auto',       'Auto',       'ஆட்டோ',         'assets/audio/hi/auto.mp3'),
    NumWrite(710, 'रिक्शा',   'ricksha',    'Rickshaw',   'ரிக்ஷா',        'assets/audio/hi/ricksha.mp3'),
    NumWrite(711, 'हेलीकॉप्टर','helicopter','Helicopter', 'ஹெலிகாப்டர்',   'assets/audio/hi/helicopter.mp3'),
    NumWrite(712, 'नाव',      'naav',       'Boat',       'படகு',           'assets/audio/hi/naav.mp3'),
    NumWrite(713, 'स्कूटर',   'scooter',    'Scooter',    'ஸ்கூட்டர்',     'assets/audio/hi/scooter.mp3'),
    NumWrite(714, 'टैक्सी',   'taxi',       'Taxi',       'டாக்சி',         'assets/audio/hi/taxi.mp3'),
    NumWrite(715, 'मेट्रो',   'metro',      'Metro',      'மெட்ரோ',         'assets/audio/hi/metro.mp3'),
    NumWrite(716, 'ट्रैम',    'tram',       'Tram',       'டிராம்',         'assets/audio/hi/tram.mp3'),
    NumWrite(717, 'सबमरीन',   'submarine',  'Submarine',  'நீர்மூழ்கிக் கப்பல்','assets/audio/hi/submarine.mp3'),
    NumWrite(718, 'रॉकेट',    'rocket',     'Rocket',     'ராக்கெட்',       'assets/audio/hi/rocket.mp3'),
    NumWrite(719, 'टैंकर',    'tanker',     'Tanker',     'டேங்கர்',        'assets/audio/hi/tanker.mp3'),
    NumWrite(720, 'ट्राली',   'trolley',    'Trolley',    'டிராலி',         'assets/audio/hi/trolley.mp3'),
  ];

  /// School Items (स्कूल की चीज़ें) — 20 words
  static const List<NumWrite> schoolItems = [
    NumWrite(801, 'किताब',    'kitaab',     'Book',       'புத்தகம்',      'assets/audio/hi/kitaab.mp3'),
    NumWrite(802, 'पेन',      'pen',        'Pen',        'பேனா',           'assets/audio/hi/pen.mp3'),
    NumWrite(803, 'पेंसिल',   'pencil',     'Pencil',     'பென்சில்',       'assets/audio/hi/pencil.mp3'),
    NumWrite(804, 'रबड़',     'rubber',     'Eraser',     'அழிப்பான்',     'assets/audio/hi/rubber.mp3'),
    NumWrite(805, 'शासक',     'shaasak',    'Ruler',      'அளவுகோல்',      'assets/audio/hi/shaasak.mp3'),
    NumWrite(806, 'बैग',      'bag',        'Bag',        'பை',             'assets/audio/hi/bag.mp3'),
    NumWrite(807, 'नोटबुक',   'notebook',   'Notebook',   'குறிப்பேடு',    'assets/audio/hi/notebook.mp3'),
    NumWrite(808, 'कक्षा',    'kaksha',     'Classroom',  'வகுப்பறை',      'assets/audio/hi/kaksha.mp3'),
    NumWrite(809, 'श्यामपट्ट','shyaamapatt','Blackboard', 'கரும்பலகை',     'assets/audio/hi/shyaamapatt.mp3'),
    NumWrite(810, 'चाक',      'chaak',      'Chalk',      'சாக்பீஸ்',      'assets/audio/hi/chaak.mp3'),
    NumWrite(811, 'कम्पास',   'compass',    'Compass',    'கம்பாஸ்',        'assets/audio/hi/compass.mp3'),
    NumWrite(812, 'कैंची',    'kainchi',    'Scissors',   'கத்தரிக்கோல்',  'assets/audio/hi/kainchi.mp3'),
    NumWrite(813, 'रंग',      'rang',       'Colors',     'வண்ணங்கள்',     'assets/audio/hi/rang.mp3'),
    NumWrite(814, 'ब्रश',     'brush',      'Brush',      'தூரிகை',         'assets/audio/hi/brush.mp3'),
    NumWrite(815, 'गोंद',     'gond',       'Glue',       'பசை',            'assets/audio/hi/gond.mp3'),
    NumWrite(816, 'घड़ी',     'ghadi',      'Clock',      'கடிகாரம்',      'assets/audio/hi/ghadi.mp3'),
    NumWrite(817, 'मेज़',     'mez',        'Table',      'மேசை',           'assets/audio/hi/mez.mp3'),
    NumWrite(818, 'कुर्सी',   'kursi',      'Chair',      'நாற்காலி',      'assets/audio/hi/kursi.mp3'),
    NumWrite(819, 'शिक्षक',   'shikshak',   'Teacher',    'ஆசிரியர்',      'assets/audio/hi/shikshak.mp3'),
    NumWrite(820, 'छात्र',    'chhaatra',   'Student',    'மாணவன்',         'assets/audio/hi/chhaatra.mp3'),
  ];

  /// Nature (प्रकृति) — 20 words
  static const List<NumWrite> nature = [
    NumWrite(901, 'पेड़',     'ped',        'Tree',       'மரம்',           'assets/audio/hi/ped.mp3'),
    NumWrite(902, 'फूल',     'phool',      'Flower',     'பூ',             'assets/audio/hi/phool.mp3'),
    NumWrite(903, 'नदी',     'nadi',       'River',      'ஆறு',            'assets/audio/hi/nadi.mp3'),
    NumWrite(904, 'पहाड़',   'pahaad',     'Mountain',   'மலை',            'assets/audio/hi/pahaad.mp3'),
    NumWrite(905, 'आकाश',    'aakaash',    'Sky',        'வானம்',          'assets/audio/hi/aakaash.mp3'),
    NumWrite(906, 'सूरज',    'suraj',      'Sun',        'சூரியன்',        'assets/audio/hi/suraj.mp3'),
    NumWrite(907, 'चाँद',    'chaand',     'Moon',       'நிலா',           'assets/audio/hi/chaand.mp3'),
    NumWrite(908, 'तारा',    'taara',      'Star',       'நட்சத்திரம்',   'assets/audio/hi/taara.mp3'),
    NumWrite(909, 'बादल',    'baadal',     'Cloud',      'மேகம்',          'assets/audio/hi/baadal.mp3'),
    NumWrite(910, 'बारिश',   'baarish',    'Rain',       'மழை',            'assets/audio/hi/baarish.mp3'),
    NumWrite(911, 'हवा',     'hawa',       'Wind',       'காற்று',         'assets/audio/hi/hawa.mp3'),
    NumWrite(912, 'बर्फ',    'barf',       'Snow',       'பனி',            'assets/audio/hi/barf.mp3'),
    NumWrite(913, 'समुद्र',  'samudra',    'Sea',        'கடல்',           'assets/audio/hi/samudra.mp3'),
    NumWrite(914, 'जंगल',    'jangal',     'Forest',     'காடு',           'assets/audio/hi/jangal.mp3'),
    NumWrite(915, 'रेगिस्तान','registaan',  'Desert',     'பாலைவனம்',      'assets/audio/hi/registaan.mp3'),
    NumWrite(916, 'झील',     'jheel',      'Lake',       'ஏரி',            'assets/audio/hi/jheel.mp3'),
    NumWrite(917, 'झरना',    'jharna',     'Waterfall',  'நீர்வீழ்ச்சி', 'assets/audio/hi/jharna.mp3'),
    NumWrite(918, 'घास',     'ghaas',      'Grass',      'புல்',           'assets/audio/hi/ghaas.mp3'),
    NumWrite(919, 'मिट्टी',  'mitti',      'Soil',       'மண்',            'assets/audio/hi/mitti.mp3'),
    NumWrite(920, 'पत्ता',   'patta',      'Leaf',       'இலை',            'assets/audio/hi/patta.mp3'),
  ];

  /// Food (खाना) — 20 words
  static const List<NumWrite> food = [
    NumWrite(1001, 'रोटी',    'roti',       'Bread/Roti', 'ரொட்டி',        'assets/audio/hi/roti.mp3'),
    NumWrite(1002, 'चावल',    'chaawal',    'Rice',       'அரிசி',          'assets/audio/hi/chaawal.mp3'),
    NumWrite(1003, 'दाल',     'daal',       'Lentils',    'பருப்பு',        'assets/audio/hi/daal.mp3'),
    NumWrite(1004, 'सब्ज़ी',  'sabzi',      'Vegetables', 'காய்கறி',        'assets/audio/hi/sabzi.mp3'),
    NumWrite(1005, 'दूध',     'doodh',      'Milk',       'பால்',           'assets/audio/hi/doodh.mp3'),
    NumWrite(1006, 'दही',     'dahi',       'Curd',       'தயிர்',          'assets/audio/hi/dahi.mp3'),
    NumWrite(1007, 'मक्खन',   'makkhan',    'Butter',     'வெண்ணெய்',      'assets/audio/hi/makkhan.mp3'),
    NumWrite(1008, 'पानी',    'paani',      'Water',      'தண்ணீர்',        'assets/audio/hi/paani.mp3'),
    NumWrite(1009, 'चाय',     'chai',       'Tea',        'தேநீர்',         'assets/audio/hi/chai.mp3'),
    NumWrite(1010, 'चीनी',    'cheeni',     'Sugar',      'சர்க்கரை',       'assets/audio/hi/cheeni.mp3'),
    NumWrite(1011, 'नमक',     'namak',      'Salt',       'உப்பு',          'assets/audio/hi/namak.mp3'),
    NumWrite(1012, 'तेल',     'tel',        'Oil',        'எண்ணெய்',        'assets/audio/hi/tel.mp3'),
    NumWrite(1013, 'घी',      'ghee',       'Ghee',       'நெய்',           'assets/audio/hi/ghee.mp3'),
    NumWrite(1014, 'अचार',    'achaar',     'Pickle',     'ஊறுகாய்',        'assets/audio/hi/achaar.mp3'),
    NumWrite(1015, 'मिठाई',   'mithai',     'Sweets',     'இனிப்பு',        'assets/audio/hi/mithai.mp3'),
    NumWrite(1016, 'बिस्किट', 'biscuit',    'Biscuit',    'பிஸ்கட்',        'assets/audio/hi/biscuit.mp3'),
    NumWrite(1017, 'समोसा',   'samosa',     'Samosa',     'சமோசா',          'assets/audio/hi/samosa.mp3'),
    NumWrite(1018, 'इडली',    'idli',       'Idli',       'இட்லி',          'assets/audio/hi/idli.mp3'),
    NumWrite(1019, 'पूरी',    'puri',       'Puri',       'பூரி',           'assets/audio/hi/puri.mp3'),
    NumWrite(1020, 'खिचड़ी',  'khichdi',    'Khichdi',    'கிச்சடி',        'assets/audio/hi/khichdi.mp3'),
  ];

  /// All items combined (for browsing everything)
  static List<NumWrite> get allItems => [
    ...numbers,
    ...animals,
    ...fruits,
    ...vegetables,
    ...colors,
    ...bodyParts,
    ...family,
    ...transport,
    ...schoolItems,
    ...nature,
    ...food,
  ];

  /// Categories for the home screen
  static const List<String> categoryNames = [
    'संख्याएँ',   // Numbers
    'जानवर',     // Animals
    'फल',        // Fruits
    'सब्ज़ियाँ', // Vegetables
    'रंग',       // Colors
    'शरीर',      // Body Parts
    'परिवार',    // Family
    'यातायात',   // Transport
    'स्कूल',     // School
    'प्रकृति',   // Nature
    'खाना',      // Food
  ];

  static const List<String> categoryEmojis = [
    '🔢', '🦁', '🍎', '🥦', '🎨', '👁️', '👨‍👩‍👧', '🚗', '📚', '🌳', '🍛',
  ];

  static List<NumWrite> getCategory(int index) {
    switch (index) {
      case 0:  return numbers;
      case 1:  return animals;
      case 2:  return fruits;
      case 3:  return vegetables;
      case 4:  return colors;
      case 5:  return bodyParts;
      case 6:  return family;
      case 7:  return transport;
      case 8:  return schoolItems;
      case 9:  return nature;
      case 10: return food;
      default: return numbers;
    }
  }
}
