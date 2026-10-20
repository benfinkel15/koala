const Map<String, List<Map<String, dynamic>>> lessonExercises = {
  // ─────────────────────────────────────────────
  // UNIT 1
  // ─────────────────────────────────────────────

  // u1_l1 — Hello and Goodbye
  'u1_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Guten Morgen" mean?',
      'options': ['Good night', 'Good morning', 'Good evening', 'Hello'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Put the words in order: "Goodbye" (formal)',
      'target': 'Auf Wiedersehen',
      'tiles': ['Auf', 'Wiedersehen', 'Tschüss', 'Hallo'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which greeting is used in the evening?',
      'options': ['Guten Morgen', 'Guten Tag', 'Guten Abend', 'Gute Nacht'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': '___ Tag!',
      'correct': 'Guten',
      'hint': 'daytime greeting',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good night" in German.',
      'target': 'Gute Nacht',
      'tiles': ['Gute', 'Nacht', 'Morgen', 'Abend'],
    },
  ],

  // u1_l2 — My Name Is…
  'u1_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "My name is Anna" in German?',
      'options': [
        'Ich bin Anna.',
        'Ich heiße Anna.',
        'Mein Name Anna.',
        'Wie heißt du Anna?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask someone\'s name informally.',
      'target': 'Wie heißt du?',
      'tiles': ['Wie', 'heißt', 'du', 'Sie', 'bist'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ Anna.',
      'correct': 'heiße',
      'hint': 'heißen (ich form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'When meeting someone for the first time, you say "Freut mich." What does it mean?',
      'options': [
        'See you later.',
        'Nice to meet you.',
        'How are you?',
        'Where are you from?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask for someone\'s name formally.',
      'target': 'Wie heißen Sie?',
      'tiles': ['Wie', 'heißen', 'Sie', 'du', 'bist'],
    },
  ],

  // u1_l3 — The verb "sein"
  'u1_l3': [
    {
      'type': 'conjugationTable',
      'verb': 'sein',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['bin', 'bist', 'ist', 'sind', 'seid', 'sind'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Er ___ müde.',
      'correct': 'ist',
      'hint': 'sein (er form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which form of "sein" goes with "wir"?',
      'options': ['bin', 'seid', 'sind', 'ist'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Build the sentence: "You (informal) are tired."',
      'target': 'Du bist müde.',
      'tiles': ['Du', 'bist', 'müde', 'bin', 'ist', '.'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ihr ___ sehr nett.',
      'correct': 'seid',
      'hint': 'sein (ihr form)',
    },
  ],

  // u1_l4 — Where Are You From?
  'u1_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you ask "Where are you from?" informally?',
      'options': [
        'Woher kommst du?',
        'Wo wohnst du?',
        'Wohin gehst du?',
        'Wie heißt du?',
      ],
      'correct': 0,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I come from Germany."',
      'target': 'Ich komme aus Deutschland.',
      'tiles': ['Ich', 'komme', 'aus', 'Deutschland', 'bin', 'nach', '.'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Woher ___ du?',
      'correct': 'kommst',
      'hint': 'kommen (du form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Ich komme aus Österreich." Where is this person from?',
      'options': ['Germany', 'Switzerland', 'Austria', 'France'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Where are you from?" formally.',
      'target': 'Woher kommen Sie?',
      'tiles': ['Woher', 'kommen', 'Sie', 'kommst', 'du', '?'],
    },
  ],

  // u1_l5 — First Conversation
  'u1_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Build a greeting and introduction: "Hello, my name is Max."',
      'target': 'Hallo, ich heiße Max.',
      'tiles': ['Hallo', ',', 'ich', 'heiße', 'Max', '.', 'bin', 'du'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Put the dialogue in the correct order:\n1. Woher kommst du?\n2. Hallo! Ich heiße Lena.\n3. Ich komme aus Berlin.\n4. Wie heißt du?',
      'options': [
        '1 → 2 → 3 → 4',
        '4 → 2 → 1 → 3',
        '2 → 4 → 1 → 3',
        '2 → 1 → 4 → 3',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ aus Frankreich.',
      'correct': 'komme',
      'hint': 'kommen (ich form)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say goodbye formally.',
      'target': 'Auf Wiedersehen!',
      'tiles': ['Auf', 'Wiedersehen', '!', 'Tschüss', 'Guten'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Someone says: "Freut mich!" How do you respond?',
      'options': [
        'Auf Wiedersehen!',
        'Guten Morgen!',
        'Mich auch!',
        'Woher kommst du?',
      ],
      'correct': 2,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 2
  // ─────────────────────────────────────────────

  // u2_l1 — The verb "haben"
  'u2_l1': [
    {
      'type': 'conjugationTable',
      'verb': 'haben',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['habe', 'hast', 'hat', 'haben', 'habt', 'haben'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Sie ___ einen Bruder.',
      'correct': 'hat',
      'hint': 'haben (sie/er form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which form of "haben" goes with "ihr"?',
      'options': ['haben', 'habt', 'hast', 'hat'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have a dog."',
      'target': 'Ich habe einen Hund.',
      'tiles': ['Ich', 'habe', 'einen', 'Hund', '.', 'hast', 'ein'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ keine Zeit.',
      'correct': 'haben',
      'hint': 'haben (wir form)',
    },
  ],

  // u2_l2 — Family Members
  'u2_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Geschwister" mean?',
      'options': ['Parents', 'Grandparents', 'Siblings', 'Cousins'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have a sister."',
      'target': 'Ich habe eine Schwester.',
      'tiles': ['Ich', 'habe', 'eine', 'Schwester', '.', 'einen', 'Bruder'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich habe ___ Bruder.',
      'correct': 'einen',
      'hint': 'masculine accusative indefinite article',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "father" in German?',
      'options': ['Mutter', 'Bruder', 'Vater', 'Onkel'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My mother is nice."',
      'target': 'Meine Mutter ist nett.',
      'tiles': ['Meine', 'Mutter', 'ist', 'nett', '.', 'Mein', 'Vater'],
    },
  ],

  // u2_l3 — Regular -en Verbs
  'u2_l3': [
    {
      'type': 'conjugationTable',
      'verb': 'spielen',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['spiele', 'spielst', 'spielt', 'spielen', 'spielt', 'spielen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ Deutsch.',
      'correct': 'lernen',
      'hint': 'lernen (wir form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is the correct "du" form of "wohnen"?',
      'options': ['wohnt', 'wohne', 'wohnst', 'wohnen'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "She cooks every day."',
      'target': 'Sie kocht jeden Tag.',
      'tiles': ['Sie', 'kocht', 'jeden', 'Tag', '.', 'kochen', 'koche'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ihr ___ in Berlin.',
      'correct': 'wohnt',
      'hint': 'wohnen (ihr form)',
    },
  ],

  // u2_l4 — Hobbies
  'u2_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ich spiele gerne Fußball." What does "gerne" indicate here?',
      'options': [
        'I play football badly.',
        'I like playing football.',
        'I have to play football.',
        'I can play football.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I like reading."',
      'target': 'Ich lese gerne.',
      'tiles': ['Ich', 'lese', 'gerne', '.', 'spiele', 'nicht'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Was machst du ___?',
      'correct': 'gerne',
      'hint': 'word meaning "gladly / for fun"',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you ask "What do you like to do?" (informal)?',
      'options': [
        'Was machst du gerne?',
        'Was hast du gerne?',
        'Was bist du gerne?',
        'Was lernst du gerne?',
      ],
      'correct': 0,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "He likes playing tennis."',
      'target': 'Er spielt gerne Tennis.',
      'tiles': ['Er', 'spielt', 'gerne', 'Tennis', '.', 'spiele', 'sie'],
    },
  ],

  // u2_l5 — Full Self-Introduction
  'u2_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Build: "Hello, I am 20 years old."',
      'target': 'Hallo, ich bin 20 Jahre alt.',
      'tiles': ['Hallo', ',', 'ich', 'bin', '20', 'Jahre', 'alt', '.', 'habe', 'heiße'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which sentence correctly introduces a hobby?',
      'options': [
        'Ich habe gerne Fußball.',
        'Ich spiele gerne Fußball.',
        'Ich bin gerne Fußball.',
        'Ich komme gerne Fußball.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich habe eine Schwester und ___ Bruder.',
      'correct': 'einen',
      'hint': 'masculine accusative indefinite article',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My name is Felix and I come from Austria."',
      'target': 'Ich heiße Felix und ich komme aus Österreich.',
      'tiles': ['Ich', 'heiße', 'Felix', 'und', 'ich', 'komme', 'aus', 'Österreich', '.', 'bin', 'Deutschland'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "I have two brothers"?',
      'options': [
        'Ich bin zwei Brüder.',
        'Ich habe zwei Brüder.',
        'Ich habe zwei Bruder.',
        'Ich spiele zwei Brüder.',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 3
  // ─────────────────────────────────────────────

  // u3_l1 — Food and Drink Vocabulary
  'u3_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is the grammatical gender of "Kaffee"?',
      'options': ['das (neuter)', 'die (feminine)', 'der (masculine)', 'No gender'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I drink tea."',
      'target': 'Ich trinke Tee.',
      'tiles': ['Ich', 'trinke', 'Tee', '.', 'esse', 'Kaffee'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich esse gerne ___.',
      'correct': 'Kuchen',
      'hint': 'German word for "cake"',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Das Brot" — which article class does "Brot" belong to?',
      'options': ['masculine (der)', 'feminine (die)', 'neuter (das)', 'plural (die)'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The water is cold."',
      'target': 'Das Wasser ist kalt.',
      'tiles': ['Das', 'Wasser', 'ist', 'kalt', '.', 'Der', 'Die'],
    },
  ],

  // u3_l2 — mögen
  'u3_l2': [
    {
      'type': 'conjugationTable',
      'verb': 'mögen',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['mag', 'magst', 'mag', 'mögen', 'mögt', 'mögen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ Kaffee nicht.',
      'correct': 'mag',
      'hint': 'mögen (ich form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Ich mag Schokolade." mean?',
      'options': [
        'I want chocolate.',
        'I like chocolate.',
        'I have chocolate.',
        'I eat chocolate.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "She doesn\'t like tea."',
      'target': 'Sie mag Tee nicht.',
      'tiles': ['Sie', 'mag', 'Tee', 'nicht', '.', 'magst', 'kein'],
    },
    {
      'type': 'fillBlank',
      'sentence': '___ du Kuchen?',
      'correct': 'Magst',
      'hint': 'mögen (du form)',
    },
  ],

  // u3_l3 — Ordering at a Café
  'u3_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you politely say "I would like a coffee"?',
      'options': [
        'Ich mag einen Kaffee.',
        'Ich will einen Kaffee.',
        'Ich möchte einen Kaffee.',
        'Ich habe einen Kaffee.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask for the bill politely.',
      'target': 'Die Rechnung bitte.',
      'tiles': ['Die', 'Rechnung', 'bitte', '.', 'Das', 'Menü'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Was ___ Sie?',
      'correct': 'möchten',
      'hint': 'möchten (Sie form) — formal',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'A waiter asks "Was möchten Sie?" How do you order a tea?',
      'options': [
        'Ich habe einen Tee.',
        'Ich mag einen Tee.',
        'Ich möchte einen Tee, bitte.',
        'Einen Tee muss ich.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I would like a piece of cake."',
      'target': 'Ich möchte ein Stück Kuchen.',
      'tiles': ['Ich', 'möchte', 'ein', 'Stück', 'Kuchen', '.', 'einen', 'mag'],
    },
  ],

  // u3_l4 — können and müssen
  'u3_l4': [
    {
      'type': 'conjugationTable',
      'verb': 'können',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['kann', 'kannst', 'kann', 'können', 'könnt', 'können'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ heute nicht kommen.',
      'correct': 'kann',
      'hint': 'können (ich form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Where does the infinitive go in a sentence with a modal verb?',
      'options': [
        'Directly after the subject',
        'Directly before the modal verb',
        'At the end of the sentence',
        'Anywhere in the sentence',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "You must pay now." (informal)',
      'target': 'Du musst jetzt bezahlen.',
      'tiles': ['Du', 'musst', 'jetzt', 'bezahlen', '.', 'kannst', 'zahlen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ morgen früh aufstehen.',
      'correct': 'müssen',
      'hint': 'müssen (wir form)',
    },
  ],

  // u3_l5 — At the Café — Full Interaction
  'u3_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Order: "I would like a coffee and a piece of cake."',
      'target': 'Ich möchte einen Kaffee und ein Stück Kuchen.',
      'tiles': ['Ich', 'möchte', 'einen', 'Kaffee', 'und', 'ein', 'Stück', 'Kuchen', '.', 'mag', 'eine'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'The waiter asks "Kann ich Ihnen helfen?" What does this mean?',
      'options': [
        'Can I bring the bill?',
        'Can I help you?',
        'Would you like something to drink?',
        'Are you ready to order?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ leider keinen Kuchen essen.',
      'correct': 'kann',
      'hint': 'können (ich form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "The coffee is very good" in German?',
      'options': [
        'Der Kaffee ist sehr gut.',
        'Der Kaffee hat sehr gut.',
        'Den Kaffee ist sehr gut.',
        'Die Kaffee ist sehr gut.',
      ],
      'correct': 0,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask for the bill.',
      'target': 'Die Rechnung bitte!',
      'tiles': ['Die', 'Rechnung', 'bitte', '!', 'Das', 'Menü', 'Bezahlen'],
    },
  ],
};
