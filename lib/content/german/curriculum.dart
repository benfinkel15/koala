const Map<String, List<Map<String, dynamic>>> lessonExercises = {
  // ─────────────────────────────────────────────
  // UNIT 1 — Greetings & Introductions
  // ─────────────────────────────────────────────

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
      'tiles': ['Du', 'bist', 'müde', 'bin', 'ist'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ihr ___ sehr nett.',
      'correct': 'seid',
      'hint': 'sein (ihr form)',
    },
  ],

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
      'tiles': ['Ich', 'komme', 'aus', 'Deutschland', 'bin', 'nach'],
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
      'tiles': ['Woher', 'kommen', 'Sie', 'kommst', 'du'],
    },
  ],

  'u1_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Build a greeting and introduction: "Hello, my name is Max."',
      'target': 'Hallo, ich heiße Max.',
      'tiles': ['Hallo', 'ich', 'heiße', 'Max', 'bin', 'du'],
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
      'tiles': ['Auf', 'Wiedersehen', 'Tschüss', 'Guten'],
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
  // UNIT 2 — Family & Hobbies
  // ─────────────────────────────────────────────

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
      'tiles': ['Ich', 'habe', 'einen', 'Hund', 'hast', 'ein'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ keine Zeit.',
      'correct': 'haben',
      'hint': 'haben (wir form)',
    },
  ],

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
      'tiles': ['Ich', 'habe', 'eine', 'Schwester', 'einen', 'Bruder'],
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
      'tiles': ['Meine', 'Mutter', 'ist', 'nett', 'Mein', 'Vater'],
    },
  ],

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
      'tiles': ['Sie', 'kocht', 'jeden', 'Tag', 'kochen', 'koche'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ihr ___ in Berlin.',
      'correct': 'wohnt',
      'hint': 'wohnen (ihr form)',
    },
  ],

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
      'tiles': ['Ich', 'lese', 'gerne', 'spiele', 'nicht'],
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
      'tiles': ['Er', 'spielt', 'gerne', 'Tennis', 'spiele', 'sie'],
    },
  ],

  'u2_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Build: "Hello, I am 20 years old."',
      'target': 'Hallo, ich bin 20 Jahre alt.',
      'tiles': ['Hallo', 'ich', 'bin', '20', 'Jahre', 'alt', 'habe', 'heiße'],
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
      'tiles': ['Ich', 'heiße', 'Felix', 'und', 'ich', 'komme', 'aus', 'Österreich', 'bin', 'Deutschland'],
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
  // UNIT 3 — Food & Café
  // ─────────────────────────────────────────────

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
      'tiles': ['Ich', 'trinke', 'Tee', 'esse', 'Kaffee'],
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
      'tiles': ['Das', 'Wasser', 'ist', 'kalt', 'Der', 'Die'],
    },
  ],

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
      'tiles': ['Sie', 'mag', 'Tee', 'nicht', 'magst', 'kein'],
    },
    {
      'type': 'fillBlank',
      'sentence': '___ du Kuchen?',
      'correct': 'Magst',
      'hint': 'mögen (du form)',
    },
  ],

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
      'tiles': ['Die', 'Rechnung', 'bitte', 'Das', 'Menü'],
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
      'tiles': ['Ich', 'möchte', 'ein', 'Stück', 'Kuchen', 'einen', 'mag'],
    },
  ],

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
      'tiles': ['Du', 'musst', 'jetzt', 'bezahlen', 'kannst', 'zahlen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ morgen früh aufstehen.',
      'correct': 'müssen',
      'hint': 'müssen (wir form)',
    },
  ],

  'u3_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Order: "I would like a coffee and a piece of cake."',
      'target': 'Ich möchte einen Kaffee und ein Stück Kuchen.',
      'tiles': ['Ich', 'möchte', 'einen', 'Kaffee', 'und', 'ein', 'Stück', 'Kuchen', 'mag', 'eine'],
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
      'tiles': ['Die', 'Rechnung', 'bitte', 'Das', 'Menü', 'Bezahlen'],
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 4 — Directions & Getting Around
  // ─────────────────────────────────────────────

  'u4_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "zwölf" in numbers?',
      'options': ['11', '12', '13', '20'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am twenty years old."',
      'target': 'Ich bin zwanzig Jahre alt.',
      'tiles': ['Ich', 'bin', 'zwanzig', 'Jahre', 'alt', 'dreißig', 'heiße'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich habe ___ Geschwister. (3)',
      'correct': 'drei',
      'hint': 'the number 3 as a word',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which number comes after "neunzehn"?',
      'options': ['einundzwanzig', 'zwanzig', 'achtzehn', 'dreißig'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "There are fifteen people."',
      'target': 'Es gibt fünfzehn Personen.',
      'tiles': ['Es', 'gibt', 'fünfzehn', 'Personen', 'zwölf', 'sind'],
    },
  ],

  'u4_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "links" mean?',
      'options': ['straight ahead', 'right', 'left', 'behind'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Go straight ahead." (formal)',
      'target': 'Gehen Sie geradeaus.',
      'tiles': ['Gehen', 'Sie', 'geradeaus', 'links', 'rechts'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Gehen Sie ___ rechts.',
      'correct': 'nach',
      'hint': '"turn right" = gehen Sie ___ rechts',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Someone says "Es ist auf der linken Seite." Where is it?',
      'options': ['On the right side', 'Behind you', 'On the left side', 'Straight ahead'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Where is the train station?"',
      'target': 'Wo ist der Bahnhof?',
      'tiles': ['Wo', 'ist', 'der', 'Bahnhof', 'die', 'Bushaltestelle'],
    },
  ],

  'u4_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "der Zug"?',
      'options': ['The bus', 'The car', 'The train', 'The tram'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I take the bus."',
      'target': 'Ich nehme den Bus.',
      'tiles': ['Ich', 'nehme', 'den', 'Bus', 'die', 'Bahn', 'fahre'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich fahre ___ der U-Bahn.',
      'correct': 'mit',
      'hint': '"by" transport = fahren ___ + dative',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "I drive by car"?',
      'options': [
        'Ich fahre mit dem Auto.',
        'Ich nehme das Auto.',
        'Ich bin mit dem Auto.',
        'Ich gehe mit dem Auto.',
      ],
      'correct': 0,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "How long does it take?"',
      'target': 'Wie lange dauert es?',
      'tiles': ['Wie', 'lange', 'dauert', 'es', 'weit', 'ist'],
    },
  ],

  'u4_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'Which preposition means "next to"?',
      'options': ['auf', 'vor', 'neben', 'zwischen'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The supermarket is near here."',
      'target': 'Der Supermarkt ist hier in der Nähe.',
      'tiles': ['Der', 'Supermarkt', 'ist', 'hier', 'in', 'der', 'Nähe', 'weit'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Das Buch liegt ___ dem Tisch.',
      'correct': 'auf',
      'hint': 'preposition meaning "on top of"',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "gegenüber" mean?',
      'options': ['around the corner', 'next to', 'opposite / across from', 'behind'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The café is on the left."',
      'target': 'Das Café ist links.',
      'tiles': ['Das', 'Café', 'ist', 'links', 'rechts', 'Der'],
    },
  ],

  'u4_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Excuse me, where is the bus stop?"',
      'target': 'Entschuldigung, wo ist die Bushaltestelle?',
      'tiles': ['Entschuldigung', 'wo', 'ist', 'die', 'Bushaltestelle', 'Bahnhof', 'der'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'You ask "Wie komme ich zum Bahnhof?" What are you asking?',
      'options': [
        'How far is the train station?',
        'How do I get to the train station?',
        'When does the train leave?',
        'Where can I buy a ticket?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Gehen Sie ___ links und dann geradeaus.',
      'correct': 'nach',
      'hint': '"turn left" = gehen Sie ___ links',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Take the first street on the right." (formal)',
      'target': 'Nehmen Sie die erste Straße rechts.',
      'tiles': ['Nehmen', 'Sie', 'die', 'erste', 'Straße', 'rechts', 'links', 'zweite'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "ungefähr zehn Minuten" mean?',
      'options': [
        'Exactly ten minutes',
        'More than ten minutes',
        'About ten minutes',
        'Less than ten minutes',
      ],
      'correct': 2,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 5 — Daily Life & Time
  // ─────────────────────────────────────────────

  'u5_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you ask "What time is it?"',
      'options': [
        'Wie heißt es?',
        'Wie spät ist es?',
        'Was ist die Zeit?',
        'Wann ist es?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "It is three o\'clock."',
      'target': 'Es ist drei Uhr.',
      'tiles': ['Es', 'ist', 'drei', 'Uhr', 'vier', 'zwei'],
    },
    {
      'type': 'fillBlank',
      'sentence': '___ spät ist es?',
      'correct': 'Wie',
      'hint': 'question word for "what time is it"',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Es ist halb vier." What time is it?',
      'options': ['4:00', '4:30', '3:30', '3:00'],
      'correct': 2,
      'explanation': 'In German, "halb vier" means half an hour before four — so 3:30.',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The train leaves at eight."',
      'target': 'Der Zug fährt um acht Uhr ab.',
      'tiles': ['Der', 'Zug', 'fährt', 'um', 'acht', 'Uhr', 'ab', 'neun', 'kommt'],
    },
  ],

  'u5_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "aufstehen" mean?',
      'options': ['To go to sleep', 'To get up', 'To eat breakfast', 'To work'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I wake up at seven."',
      'target': 'Ich wache um sieben Uhr auf.',
      'tiles': ['Ich', 'wache', 'um', 'sieben', 'Uhr', 'auf', 'schlafe', 'acht'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ jeden Morgen Kaffee.',
      'correct': 'trinke',
      'hint': 'trinken (ich form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is the correct order of a typical German morning?',
      'options': [
        'arbeiten → aufwachen → frühstücken → schlafen',
        'aufwachen → frühstücken → arbeiten → schlafen',
        'frühstücken → aufwachen → schlafen → arbeiten',
        'schlafen → arbeiten → frühstücken → aufwachen',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I go to bed at eleven."',
      'target': 'Ich gehe um elf Uhr schlafen.',
      'tiles': ['Ich', 'gehe', 'um', 'elf', 'Uhr', 'schlafen', 'zehn', 'aufstehen'],
    },
  ],

  'u5_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'In "Ich stehe früh auf", which part is the separable prefix?',
      'options': ['Ich', 'stehe', 'früh', 'auf'],
      'correct': 3,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I open the window."',
      'target': 'Ich mache das Fenster auf.',
      'tiles': ['Ich', 'mache', 'das', 'Fenster', 'auf', 'zu', 'öffne'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ich ___ das Licht an.',
      'correct': 'mache',
      'hint': 'anmachen (ich form) — "to turn on"',
    },
    {
      'type': 'conjugationTable',
      'verb': 'aufstehen',
      'tense': 'Präsens',
      'pronouns': ['ich', 'du', 'er/sie/es', 'wir', 'ihr', 'sie/Sie'],
      'answers': ['stehe auf', 'stehst auf', 'steht auf', 'stehen auf', 'steht auf', 'stehen auf'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'In a main clause, where does the separable prefix go?',
      'options': [
        'Right after the subject',
        'Directly after the verb',
        'At the very end of the sentence',
        'Before the subject',
      ],
      'correct': 2,
    },
  ],

  'u5_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What day comes after "Mittwoch"?',
      'options': ['Dienstag', 'Freitag', 'Donnerstag', 'Montag'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I work on Monday."',
      'target': 'Ich arbeite am Montag.',
      'tiles': ['Ich', 'arbeite', 'am', 'Montag', 'Dienstag', 'gehe'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Im ___ ist Weihnachten.',
      'correct': 'Dezember',
      'hint': 'the month of Christmas',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "every Friday" (as a regular habit)?',
      'options': ['am Freitags', 'freitags', 'auf Freitag', 'in Freitag'],
      'correct': 1,
      'explanation': 'Adding "-s" to a day of the week makes it mean "every [day]" — freitags = every Friday.',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My birthday is in March."',
      'target': 'Mein Geburtstag ist im März.',
      'tiles': ['Mein', 'Geburtstag', 'ist', 'im', 'März', 'April', 'der'],
    },
  ],

  'u5_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Are you free on Saturday?" (informal)',
      'target': 'Hast du am Samstag Zeit?',
      'tiles': ['Hast', 'du', 'am', 'Samstag', 'Zeit', 'Sonntag', 'bist'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Someone asks "Wollen wir uns treffen?" What are they suggesting?',
      'options': [
        'Shall we go eat?',
        'Let\'s meet up.',
        'Are you busy?',
        'Do you want to call?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wir ___ uns um drei Uhr.',
      'correct': 'treffen',
      'hint': 'sich treffen (wir form) — "to meet"',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I can\'t on Wednesday."',
      'target': 'Am Mittwoch kann ich nicht.',
      'tiles': ['Am', 'Mittwoch', 'kann', 'ich', 'nicht', 'Donnerstag', 'muss'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you enthusiastically confirm plans? "Das ___ gut!"',
      'options': ['macht', 'klingt', 'ist', 'hat'],
      'correct': 1,
      'explanation': '"Das klingt gut!" means "That sounds good!" — klingen = to sound.',
    },
  ],
};
