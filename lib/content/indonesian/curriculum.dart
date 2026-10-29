const Map<String, List<Map<String, dynamic>>> indonesianLessonExercises = {

  // ─────────────────────────────────────────────
  // UNIT 1 — Salam & Perkenalan (Greetings & Introductions)
  // ─────────────────────────────────────────────

  'id_u1_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Selamat pagi" mean?',
      'options': ['Good evening', 'Good morning', 'Good night', 'Good afternoon'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Goodbye" in Indonesian.',
      'target': 'Sampai jumpa',
      'tiles': ['Sampai', 'jumpa', 'Halo', 'Dadah', 'malam'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which greeting is used in the evening?',
      'options': ['Selamat pagi', 'Selamat siang', 'Selamat sore', 'Selamat malam'],
      'correct': 3,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Selamat ___, selamat istirahat!',
      'correct': 'malam',
      'hint': 'Good evening, rest well',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good afternoon, how are you?"',
      'target': 'Selamat sore apa kabar',
      'tiles': ['Selamat', 'sore', 'apa', 'kabar', 'pagi', 'malam'],
    },
  ],

  'id_u1_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "My name is Rina" in Indonesian?',
      'options': [
        'Saya nama Rina.',
        'Nama saya Rina.',
        'Saya adalah Rina nama.',
        'Rina adalah nama saya.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "What is your name?" (informal).',
      'target': 'Siapa nama kamu?',
      'tiles': ['Siapa', 'nama', 'kamu', 'saya', 'apa', 'Anda'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Nama ___ adalah Budi.',
      'correct': 'saya',
      'hint': 'My name is Budi',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Senang bertemu denganmu" means?',
      'options': [
        'See you later.',
        'How are you?',
        'Nice to meet you.',
        'Where are you from?',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My name is Sari."',
      'target': 'Nama saya Sari',
      'tiles': ['Nama', 'saya', 'Sari', 'kamu', 'adalah', 'dia'],
    },
  ],

  'id_u1_l3': [
    {
      'type': 'conjugationTable',
      'verb': 'Pronoun chart — saya/kamu/dia',
      'tense': 'Indonesian personal pronouns',
      'pronouns': ['saya (formal I)', 'aku (informal I)', 'kamu (you informal)', 'Anda (you formal)', 'dia (he/she)', 'mereka (they)'],
      'answers': ['I / me', 'I / me', 'you', 'you (polite)', 'he / she', 'they'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Dia adalah guru." mean?',
      'options': ['He is a student.', 'She is a teacher.', 'They are teachers.', 'You are a teacher.'],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': '___ adalah mahasiswa.',
      'correct': 'Saya',
      'hint': 'I am a university student.',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We are friends."',
      'target': 'Kami adalah teman',
      'tiles': ['Kami', 'adalah', 'teman', 'Mereka', 'kita', 'guru'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is the difference between "kami" and "kita"?',
      'options': [
        'kami = formal we, kita = informal we',
        'kami = we (excluding listener), kita = we (including listener)',
        'kami = plural you, kita = plural they',
        'There is no difference.',
      ],
      'correct': 1,
    },
  ],

  'id_u1_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Kamu dari mana?" mean?',
      'options': [
        'Where do you live?',
        'What is your name?',
        'Where are you from?',
        'Where are you going?',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I come from Indonesia."',
      'target': 'Saya dari Indonesia',
      'tiles': ['Saya', 'dari', 'Indonesia', 'adalah', 'tinggal', 'Jakarta'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ di Bandung.',
      'correct': 'tinggal',
      'hint': 'tinggal = to live',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Saya bisa bicara sedikit bahasa Indonesia." means?',
      'options': [
        'I speak a lot of Indonesian.',
        'I speak a little Indonesian.',
        'I don\'t speak Indonesian.',
        'Do you speak Indonesian?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you speak English?"',
      'target': 'Apakah kamu bisa berbahasa Inggris?',
      'tiles': ['Apakah', 'kamu', 'bisa', 'berbahasa', 'Inggris?', 'Indonesia', 'saya'],
    },
  ],

  'id_u1_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Hello, how are you?"',
      'target': 'Halo apa kabar',
      'tiles': ['Halo', 'apa', 'kabar', 'Selamat', 'pagi', 'baik'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Baik-baik saja, terima kasih." means?',
      'options': [
        'I feel tired, thanks.',
        'I\'m fine, thank you.',
        'Thank you very much.',
        'Good morning, thank you.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Senang ___ denganmu!',
      'correct': 'bertemu',
      'hint': 'Nice to meet you',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you tomorrow!"',
      'target': 'Sampai jumpa besok',
      'tiles': ['Sampai', 'jumpa', 'besok', 'malam', 'nanti', 'hari'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is the most casual goodbye in Indonesian?',
      'options': ['Sampai jumpa', 'Selamat malam', 'Dadah', 'Selamat tinggal'],
      'correct': 2,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 2 — Keluarga & Hobi (Family & Hobbies)
  // ─────────────────────────────────────────────

  'id_u2_l1': [
    {
      'type': 'conjugationTable',
      'verb': 'punya / ada',
      'tense': 'Indonesian "to have" — same form for all subjects',
      'pronouns': ['saya', 'kamu', 'dia', 'kami', 'kita', 'mereka'],
      'answers': ['punya', 'punya', 'punya', 'punya', 'punya', 'punya'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Dia punya seekor kucing." means?',
      'options': ['He wants a cat.', 'He had a cat.', 'He has a cat.', 'He likes a cat.'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Kami ___ rumah besar.',
      'correct': 'punya',
      'hint': 'We have a big house.',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have a sister."',
      'target': 'Saya punya seorang kakak perempuan',
      'tiles': ['Saya', 'punya', 'seorang', 'kakak', 'perempuan', 'laki-laki', 'adik'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "She has a car"?',
      'options': ['Dia adalah mobil.', 'Dia punya mobil.', 'Dia ada mobil.', 'Dia mau mobil.'],
      'correct': 1,
    },
  ],

  'id_u2_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "kakak laki-laki" mean?',
      'options': ['younger sister', 'father', 'older brother', 'son'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My mother is kind."',
      'target': 'Ibu saya baik hati',
      'tiles': ['Ibu', 'saya', 'baik', 'hati', 'Ayah', 'kakak', 'adik'],
    },
    {
      'type': 'fillBlank',
      'sentence': '___ saya bernama Dewi.',
      'correct': 'Adik',
      'hint': 'My younger sibling is named Dewi.',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"kakek dan nenek" means?',
      'options': ['parents', 'grandparents', 'children', 'siblings'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have two children."',
      'target': 'Saya punya dua orang anak',
      'tiles': ['Saya', 'punya', 'dua', 'orang', 'anak', 'tiga', 'kakak'],
    },
  ],

  'id_u2_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is the me- prefix form of "tulis" (to write)?',
      'options': ['menulis', 'metulis', 'tertulis', 'ditulis'],
      'correct': 0,
    },
    {
      'type': 'conjugationTable',
      'verb': 'me- active / di- passive prefix',
      'tense': 'Indonesian verb prefix patterns',
      'pronouns': ['makan → memakan', 'tulis → menulis', 'beli → membeli', 'baca → membaca', 'makan (passive)', 'tulis (passive)'],
      'answers': ['to eat (active)', 'to write (active)', 'to buy (active)', 'to read (active)', 'dimakan (is eaten)', 'ditulis (is written)'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ buku setiap hari.',
      'correct': 'membaca',
      'hint': 'baca → me- prefix form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We work every day."',
      'target': 'Kami bekerja setiap hari',
      'tiles': ['Kami', 'bekerja', 'setiap', 'hari', 'kerja', 'belajar', 'tinggal'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "bermain" mean?',
      'options': ['to speak', 'to sleep', 'to play', 'to swim'],
      'correct': 2,
    },
  ],

  'id_u2_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Hobi saya adalah membaca." means?',
      'options': [
        'My hobby is writing.',
        'My hobby is cycling.',
        'My hobby is reading.',
        'My hobby is swimming.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I like to swim."',
      'target': 'Saya suka berenang',
      'tiles': ['Saya', 'suka', 'berenang', 'bermain', 'membaca', 'memasak'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Dia bermain gitar ___ kali seminggu.',
      'correct': 'tiga',
      'hint': 'three times a week',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "bersepeda" mean?',
      'options': ['to run', 'to cycle', 'to swim', 'to cook'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "What is your hobby?"',
      'target': 'Apa hobi kamu?',
      'tiles': ['Apa', 'hobi', 'kamu', 'suka', 'saya', 'siapa'],
    },
  ],

  'id_u2_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My name is Andi and I am 25."',
      'target': 'Nama saya Andi dan saya berumur 25 tahun',
      'tiles': ['Nama', 'saya', 'Andi', 'dan', 'berumur', '25', 'tahun', 'dari'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Saya berasal dari Surabaya." means?',
      'options': [
        'I live in Surabaya.',
        'I come from Surabaya.',
        'I work in Surabaya.',
        'I visit Surabaya.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ sebagai guru di sebuah sekolah.',
      'correct': 'bekerja',
      'hint': 'bekerja = to work',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My hobby is cooking."',
      'target': 'Hobi saya adalah memasak',
      'tiles': ['Hobi', 'saya', 'adalah', 'memasak', 'berenang', 'membaca'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "I have two older brothers"?',
      'options': [
        'Saya adalah dua kakak laki-laki.',
        'Saya punya dua kakak laki-laki.',
        'Saya punya dua adik laki-laki.',
        'Saya ada dua kakak.',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 3 — Makanan & Warung (Food & Warung)
  // ─────────────────────────────────────────────

  'id_u3_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"nasi goreng" means?',
      'options': ['steamed rice', 'fried rice', 'rice cake', 'rice soup'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I would like a fried rice, please."',
      'target': 'Saya mau nasi goreng',
      'tiles': ['Saya', 'mau', 'nasi', 'goreng', 'mie', 'ayam', 'satu'],
    },
    {
      'type': 'fillBlank',
      'sentence': '___ ayam dengan kuah, pak.',
      'correct': 'Mie',
      'hint': 'Chicken noodle soup',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"es teh manis" means?',
      'options': ['hot sweet tea', 'iced black coffee', 'iced sweet tea', 'mineral water'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you have chicken satay?"',
      'target': 'Apakah ada sate ayam?',
      'tiles': ['Apakah', 'ada', 'sate', 'ayam?', 'nasi', 'mie', 'tempe'],
    },
  ],

  'id_u3_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Saya suka makanan pedas." means?',
      'options': [
        'I think the food is ugly.',
        'I find the food boring.',
        'I like spicy food.',
        'I like to cook food.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I don\'t like very spicy food."',
      'target': 'Saya tidak suka makanan yang terlalu pedas',
      'tiles': ['Saya', 'tidak', 'suka', 'makanan', 'yang', 'terlalu', 'pedas', 'manis'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya suka ___ dengan sambal.',
      'correct': 'tempe',
      'hint': 'fermented soybean with sambal',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Bisa minta bonnya?" means?',
      'options': [
        'Can I see the menu?',
        'May I have the bill?',
        'Can I order please?',
        'What do you recommend?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I like Indonesian food."',
      'target': 'Saya suka makanan Indonesia',
      'tiles': ['Saya', 'suka', 'makanan', 'Indonesia', 'tidak', 'Jepang'],
    },
  ],

  'id_u3_l3': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "One portion of fried rice, please."',
      'target': 'Satu porsi nasi goreng',
      'tiles': ['Satu', 'porsi', 'nasi', 'goreng', 'dua', 'mie', 'sate'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Mau pesan apa?" means?',
      'options': [
        'What do you recommend?',
        'What can I do for you?',
        'What would you like to order?',
        'Can I take your order?',
      ],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ satu es teh manis.',
      'correct': 'mau',
      'hint': 'I want one iced sweet tea.',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Ada meja untuk dua orang?" means?',
      'options': [
        'Do you have a menu for two?',
        'Can we have two coffees?',
        'Do you have a table for two?',
        'Is it busy today?',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The bill, please."',
      'target': 'Minta bon',
      'tiles': ['Minta', 'bon', 'menu', 'pesanan', 'tolong'],
    },
  ],

  'id_u3_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Saya harus pulang sekarang." means?',
      'options': [
        'I want to go home now.',
        'I can go home now.',
        'I must go home now.',
        'I am going home now.',
      ],
      'correct': 2,
    },
    {
      'type': 'conjugationTable',
      'verb': 'mau / bisa / harus / boleh',
      'tense': 'Indonesian modals — same form for every subject',
      'pronouns': ['saya mau makan', 'kamu bisa datang', 'dia harus pergi', 'kami boleh masuk', 'kita mau beli', 'mereka harus tahu'],
      'answers': ['I want to eat', 'you can come', 'he/she must go', 'we may enter', 'we want to buy', 'they must know'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Kamu ___ datang besok.',
      'correct': 'harus',
      'hint': 'harus = must/have to',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We must go now."',
      'target': 'Kami harus pergi sekarang',
      'tiles': ['Kami', 'harus', 'pergi', 'sekarang', 'bisa', 'mau', 'nanti'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which is correct for "She can swim"?',
      'options': [
        'Dia mau berenang.',
        'Dia harus berenang.',
        'Dia bisa berenang.',
        'Dia boleh berenang.',
      ],
      'correct': 2,
    },
  ],

  'id_u3_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good afternoon, a table for two please."',
      'target': 'Selamat siang meja untuk dua orang',
      'tiles': ['Selamat', 'siang', 'meja', 'untuk', 'dua', 'orang', 'tiga', 'sore'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Sudah siap mau pesan?" means?',
      'options': [
        'Do you want something to eat?',
        'Are you ready to order?',
        'Would you like something to drink?',
        'What is today\'s special?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ nasi goreng spesial dan es jeruk.',
      'correct': 'mau',
      'hint': 'I want a special fried rice and iced orange juice.',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "It was delicious, thank you."',
      'target': 'Enak sekali terima kasih',
      'tiles': ['Enak', 'sekali', 'terima', 'kasih', 'tidak', 'kurang'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'You want to pay. What do you say?',
      'options': [
        '"Minta menunya?"',
        '"Minta bonnya?"',
        '"Minta pesanannya?"',
        '"Minta dapurnya?"',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 4 — Arah & Transportasi (Directions & Transport)
  // ─────────────────────────────────────────────

  'id_u4_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "tiga belas" in numerals?',
      'options': ['12', '30', '13', '3'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am seventeen years old."',
      'target': 'Saya berumur tujuh belas tahun',
      'tiles': ['Saya', 'berumur', 'tujuh', 'belas', 'tahun', 'enam', 'delapan'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ada ___ orang di ruangan ini.',
      'correct': 'dua belas',
      'hint': 'twelve people in this room',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which number comes after "sembilan belas"?',
      'options': ['delapan belas', 'dua puluh', 'dua puluh satu', 'enam belas'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have fifteen thousand rupiah."',
      'target': 'Saya punya lima belas ribu rupiah',
      'tiles': ['Saya', 'punya', 'lima', 'belas', 'ribu', 'rupiah', 'sepuluh', 'dua'],
    },
  ],

  'id_u4_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jalan terus" means?',
      'options': ['Turn right', 'Turn left', 'Go straight ahead', 'Stop here'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Turn left at the traffic light."',
      'target': 'Belok kiri di lampu merah',
      'tiles': ['Belok', 'kiri', 'di', 'lampu', 'merah', 'kanan', 'terus'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Stasiunnya ada ___ tikungan.',
      'correct': 'di balik',
      'hint': 'around/behind the bend',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Berapa jauh dari sini?" means?',
      'options': [
        'What time is it?',
        'How long does it take?',
        'How far is it from here?',
        'Where is the stop?',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The museum is on the right."',
      'target': 'Museumnya ada di sebelah kanan',
      'tiles': ['Museumnya', 'ada', 'di', 'sebelah', 'kanan', 'kiri', 'depan'],
    },
  ],

  'id_u4_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Saya naik kereta." means?',
      'options': ['I take the bus.', 'I take the ojek.', 'I take the train.', 'I take the subway.'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Where is the bus stop?"',
      'target': 'Di mana halte busnya?',
      'tiles': ['Di', 'mana', 'halte', 'busnya?', 'stasiunnya', 'ojeknya', 'terminalnya'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ ojek ke kantor setiap hari.',
      'correct': 'naik',
      'hint': 'naik = to take/ride (transport)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"tiket sekali jalan" means?',
      'options': [
        'a return ticket',
        'a student ticket',
        'a first class ticket',
        'a one-way ticket',
      ],
      'correct': 3,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Two tickets to Yogyakarta, please."',
      'target': 'Dua tiket ke Yogyakarta',
      'tiles': ['Dua', 'tiket', 'ke', 'Yogyakarta', 'satu', 'Jakarta', 'Bali'],
    },
  ],

  'id_u4_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Kuncinya ada di atas meja." means?',
      'options': [
        'The key is under the table.',
        'The key is on the table.',
        'The key is next to the table.',
        'The key is behind the table.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The bakery is next to the station."',
      'target': 'Toko rotinya ada di samping stasiun',
      'tiles': ['Toko', 'rotinya', 'ada', 'di', 'samping', 'stasiun', 'depan', 'bank'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Kucingnya duduk ___ kursi.',
      'correct': 'di bawah',
      'hint': 'under / beneath the chair',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which preposition means "in front of"?',
      'options': ['di belakang', 'di samping', 'di depan', 'di antara'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The hotel is opposite the mosque."',
      'target': 'Hotelnya ada di seberang masjid',
      'tiles': ['Hotelnya', 'ada', 'di', 'seberang', 'masjid', 'samping', 'depan'],
    },
  ],

  'id_u4_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Excuse me, where is the station?"',
      'target': 'Permisi di mana stasiunnya?',
      'tiles': ['Permisi', 'di', 'mana', 'stasiunnya?', 'halte', 'museumnya'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Itu bisa ditempuh dengan jalan kaki." means?',
      'options': [
        'It is far away.',
        'It can be reached on foot.',
        'You need to take the bus.',
        'It is on the right.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': '___ jauh dari sini ke Monas?',
      'correct': 'Berapa',
      'hint': 'How far is it from here to Monas?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Take bus number 5."',
      'target': 'Naik bus nomor lima',
      'tiles': ['Naik', 'bus', 'nomor', 'lima', 'kereta', 'empat', 'ojek'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Terima kasih atas bantuannya." means?',
      'options': [
        'Sorry for the trouble.',
        'Thank you for your help.',
        'Can you help me please?',
        'I don\'t understand.',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 5 — Kehidupan Sehari-hari & Waktu (Daily Life & Time)
  // ─────────────────────────────────────────────

  'id_u5_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jam berapa sekarang?" means?',
      'options': [
        'What day is it?',
        'What time is it?',
        'How old are you?',
        'What is the date?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "It is half past eight." (08:30)',
      'target': 'Sekarang jam setengah sembilan',
      'tiles': ['Sekarang', 'jam', 'setengah', 'sembilan', 'delapan', 'lebih', 'kurang'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Kereta berangkat jam ___.',
      'correct': 'tiga',
      'hint': 'three o\'clock (write the word)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Jam setengah lima" means?',
      'options': ['4:15', '4:30', '5:15', '5:30'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The shop closes at six o\'clock."',
      'target': 'Toko itu tutup jam enam',
      'tiles': ['Toko', 'itu', 'tutup', 'jam', 'enam', 'lima', 'buka', 'tujuh'],
    },
  ],

  'id_u5_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Saya bangun jam tujuh setiap hari." means?',
      'options': [
        'I go to bed at seven every day.',
        'I get up at seven every day.',
        'I eat at seven every day.',
        'I leave at seven every day.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "After showering I eat breakfast."',
      'target': 'Setelah mandi saya sarapan',
      'tiles': ['Setelah', 'mandi', 'saya', 'sarapan', 'tidur', 'pergi', 'bekerja'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Saya ___ tidur jam sepuluh malam.',
      'correct': 'selalu',
      'hint': 'always',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"makan siang" means?',
      'options': ['breakfast', 'lunch', 'dinner', 'snack'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I go to work by ojek."',
      'target': 'Saya pergi ke kantor naik ojek',
      'tiles': ['Saya', 'pergi', 'ke', 'kantor', 'naik', 'ojek', 'bus', 'jalan'],
    },
  ],

  'id_u5_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Saya berolahraga pagi-pagi." — What is the base verb?',
      'options': ['olahraga', 'berolahraga', 'mengolahraga', 'diolahraga'],
      'correct': 1,
    },
    {
      'type': 'conjugationTable',
      'verb': 'ber- prefix verbs',
      'tense': 'ber- verbs — same form for all subjects',
      'pronouns': ['saya berjalan', 'kamu berlari', 'dia berbicara', 'kami belajar', 'kita bekerja', 'mereka berolahraga'],
      'answers': ['I walk', 'you run', 'he/she speaks', 'we study', 'we (incl.) work', 'they exercise'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Dia ___ kepada ibunya setiap minggu.',
      'correct': 'bertelepon',
      'hint': 'bertelepon = to phone/call',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"berhenti" means?',
      'options': ['to start', 'to continue', 'to stop', 'to travel'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "She stops at the traffic light."',
      'target': 'Dia berhenti di lampu merah',
      'tiles': ['Dia', 'berhenti', 'di', 'lampu', 'merah', 'berjalan', 'belok'],
    },
  ],

  'id_u5_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What day comes after "Rabu"?',
      'options': ['Selasa', 'Kamis', 'Jumat', 'Senin'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I work from Monday to Friday."',
      'target': 'Saya bekerja dari Senin sampai Jumat',
      'tiles': ['Saya', 'bekerja', 'dari', 'Senin', 'sampai', 'Jumat', 'Sabtu', 'Selasa'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ulang tahun saya di bulan ___.',
      'correct': 'Maret',
      'hint': 'March',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Februari" is?',
      'options': ['January', 'February', 'March', 'April'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you on Saturday!"',
      'target': 'Sampai jumpa hari Sabtu',
      'tiles': ['Sampai', 'jumpa', 'hari', 'Sabtu', 'Minggu', 'Jumat', 'nanti'],
    },
  ],

  'id_u5_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Are you free this weekend?"',
      'target': 'Apakah kamu bebas akhir pekan ini?',
      'tiles': ['Apakah', 'kamu', 'bebas', 'akhir', 'pekan', 'ini?', 'sibuk', 'minggu'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Saya ada janji." means?',
      'options': [
        'I made a plan.',
        'I have an appointment.',
        'I am going to the doctor.',
        'I cancelled the meeting.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Kita ketemuan ___ di kota ya?',
      'correct': 'di suatu tempat',
      'hint': 'somewhere in the city',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Suggest "Let\'s go to the cinema on Friday."',
      'target': 'Kita nonton bioskop hari Jumat yuk',
      'tiles': ['Kita', 'nonton', 'bioskop', 'hari', 'Jumat', 'yuk', 'Sabtu', 'mall'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Kedengarannya bagus!" means?',
      'options': [
        'That sounds difficult.',
        'That is not possible.',
        'That sounds good!',
        'That is expensive.',
      ],
      'correct': 2,
    },
  ],
};
