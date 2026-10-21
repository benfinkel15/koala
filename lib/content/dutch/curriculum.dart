const Map<String, List<Map<String, dynamic>>> dutchLessonExercises = {

  // ─────────────────────────────────────────────
  // UNIT 1 — Groeten & Kennismaken
  // ─────────────────────────────────────────────

  'nl_u1_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Goedemorgen" mean?',
      'options': ['Good evening', 'Good morning', 'Good night', 'Good afternoon'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Goodbye" (formal) in Dutch.',
      'target': 'Tot ziens',
      'tiles': ['Tot', 'ziens', 'Doei', 'Hallo', 'Dag'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which greeting is used in the evening?',
      'options': ['Goedemorgen', 'Goedemiddag', 'Goedenavond', 'Goedenacht'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Goede___ allemaal!',
      'correct': 'middag',
      'hint': 'Good afternoon everyone',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good night, sleep well."',
      'target': 'Goedenacht slaap lekker',
      'tiles': ['Goedenacht', 'slaap', 'lekker', 'Dag', 'morgen', 'wel'],
    },
  ],

  'nl_u1_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "My name is Lisa" in Dutch?',
      'options': [
        'Ik ben Lisa heiten.',
        'Mijn naam is Lisa.',
        'Hoe heet jij Lisa?',
        'Lisa naam ik.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask someone\'s name informally.',
      'target': 'Hoe heet jij?',
      'tiles': ['Hoe', 'heet', 'jij', 'u', 'ben', 'naam'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ Anna.',
      'correct': 'heet',
      'hint': 'heten (ik-form)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Aangenaam kennis te maken" means?',
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
      'prompt': 'Ask someone\'s name formally.',
      'target': 'Hoe heet u?',
      'tiles': ['Hoe', 'heet', 'u', 'jij', 'bent', 'naam'],
    },
  ],

  'nl_u1_l3': [
    {
      'type': 'conjugationTable',
      'verb': 'zijn',
      'tense': 'present tense',
      'pronouns': ['ik', 'jij/je', 'hij/zij', 'wij/we', 'jullie', 'zij/ze'],
      'answers': ['ben', 'bent', 'is', 'zijn', 'zijn', 'zijn'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Jij bent slim." mean?',
      'options': ['You have talent.', 'You are smart.', 'You feel good.', 'You are tired.'],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wij ___ goede vrienden.',
      'correct': 'zijn',
      'hint': 'zijn — wij form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am tired."',
      'target': 'Ik ben moe',
      'tiles': ['Ik', 'ben', 'moe', 'bent', 'zijn', 'blij'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Choose the correct translation of "She is happy."',
      'options': ['Zij zijn blij.', 'Zij heeft blij.', 'Zij is blij.', 'Zij bent blij.'],
      'correct': 2,
    },
  ],

  'nl_u1_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Waar kom jij vandaan?" mean?',
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
      'prompt': 'Say "I come from the Netherlands."',
      'target': 'Ik kom uit Nederland',
      'tiles': ['Ik', 'kom', 'uit', 'Nederland', 'ben', 'van', 'woon'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ in Amsterdam.',
      'correct': 'woon',
      'hint': 'wonen (to live) — ik form',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Ik spreek een beetje Nederlands." means?',
      'options': [
        'I speak a lot of Dutch.',
        'I speak a little Dutch.',
        'I don\'t speak Dutch.',
        'Do you speak Dutch?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you speak Dutch?"',
      'target': 'Spreek jij Nederlands?',
      'tiles': ['Spreek', 'jij', 'Nederlands', 'Ben', 'Engels', 'Praat'],
    },
  ],

  'nl_u1_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Hello, how are you?"',
      'target': 'Hallo hoe gaat het',
      'tiles': ['Hallo', 'hoe', 'gaat', 'het', 'ben', 'jij', 'goed'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Het gaat goed, dank je wel." means?',
      'options': [
        'I feel tired, thanks.',
        'It\'s going well, thank you.',
        'Thank you very much.',
        'Good morning, thank you.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Leuk je te ___!',
      'correct': 'ontmoeten',
      'hint': 'Nice to meet you (infinitive)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you later!"',
      'target': 'Tot later',
      'tiles': ['Tot', 'later', 'ziens', 'Dag', 'Doei', 'snel'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which is the most casual goodbye?',
      'options': ['Tot ziens', 'Goedenavond', 'Doei', 'Goedemorgen'],
      'correct': 2,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 2 — Familie & Hobby's
  // ─────────────────────────────────────────────

  'nl_u2_l1': [
    {
      'type': 'conjugationTable',
      'verb': 'hebben',
      'tense': 'present tense',
      'pronouns': ['ik', 'jij/je', 'hij/zij', 'wij/we', 'jullie', 'zij/ze'],
      'answers': ['heb', 'hebt', 'heeft', 'hebben', 'hebben', 'hebben'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Hij heeft een hond." means?',
      'options': ['He wants a dog.', 'He had a dog.', 'He has a dog.', 'He likes a dog.'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jullie ___ een grote tuin.',
      'correct': 'hebben',
      'hint': 'hebben — jullie form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have a sister."',
      'target': 'Ik heb een zus',
      'tiles': ['Ik', 'heb', 'een', 'zus', 'broer', 'heeft', 'huis'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "She has a car"?',
      'options': ['Zij ben een auto.', 'Zij hebt een auto.', 'Zij heeft een auto.', 'Zij zijn een auto.'],
      'correct': 2,
    },
  ],

  'nl_u2_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "broer" mean?',
      'options': ['sister', 'father', 'brother', 'son'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My mother is kind."',
      'target': 'Mijn moeder is aardig',
      'tiles': ['Mijn', 'moeder', 'is', 'aardig', 'vader', 'lief', 'broer'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Mijn ___ heet Sofie.',
      'correct': 'zus',
      'hint': 'sister',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"grootouders" means?',
      'options': ['parents', 'grandparents', 'children', 'siblings'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have two children."',
      'target': 'Ik heb twee kinderen',
      'tiles': ['Ik', 'heb', 'twee', 'kinderen', 'één', 'kind', 'heeft'],
    },
  ],

  'nl_u2_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is the correct form of "werken" for "ik"?',
      'options': ['werkt', 'werken', 'werk', 'werkten'],
      'correct': 2,
    },
    {
      'type': 'conjugationTable',
      'verb': 'werken',
      'tense': 'present tense',
      'pronouns': ['ik', 'jij/je', 'hij/zij', 'wij/we', 'jullie', 'zij/ze'],
      'answers': ['werk', 'werkt', 'werkt', 'werken', 'werken', 'werken'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Hij ___ elke dag hard.',
      'correct': 'werkt',
      'hint': 'werken — hij form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We live in Amsterdam."',
      'target': 'Wij wonen in Amsterdam',
      'tiles': ['Wij', 'wonen', 'in', 'Amsterdam', 'werken', 'leven', 'zijn'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "spelen" mean?',
      'options': ['to speak', 'to sleep', 'to play', 'to swim'],
      'correct': 2,
    },
  ],

  'nl_u2_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Mijn hobby is lezen." means?',
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
      'target': 'Ik zwem graag',
      'tiles': ['Ik', 'zwem', 'graag', 'speel', 'lees', 'wil', 'fietsen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Hij speelt gitaar ___ keer per week.',
      'correct': 'drie',
      'hint': 'three times a week',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "fietsen" mean?',
      'options': ['to run', 'to cycle', 'to swim', 'to cook'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "What is your hobby?"',
      'target': 'Wat is jouw hobby?',
      'tiles': ['Wat', 'is', 'jouw', 'hobby', 'doe', 'jij', 'graag'],
    },
  ],

  'nl_u2_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My name is Jan and I am 25."',
      'target': 'Ik heet Jan en ik ben 25',
      'tiles': ['Ik', 'heet', 'Jan', 'en', 'ik', 'ben', '25', 'heb', 'naam'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Ik kom uit Rotterdam." means?',
      'options': [
        'I live in Rotterdam.',
        'I come from Rotterdam.',
        'I work in Rotterdam.',
        'I visit Rotterdam.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ als leraar op een school.',
      'correct': 'werk',
      'hint': 'werken (to work) — ik form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My hobby is cycling."',
      'target': 'Mijn hobby is fietsen',
      'tiles': ['Mijn', 'hobby', 'is', 'fietsen', 'zwemmen', 'werken', 'lezen'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "I have two brothers"?',
      'options': [
        'Ik ben twee broers.',
        'Ik heb twee broers.',
        'Ik hebt twee broers.',
        'Ik hebben twee broers.',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 3 — Eten & Café
  // ─────────────────────────────────────────────

  'nl_u3_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"brood" means?',
      'options': ['meat', 'bread', 'cake', 'fruit'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I would like a coffee, please."',
      'target': 'Ik wil graag een koffie',
      'tiles': ['Ik', 'wil', 'graag', 'een', 'koffie', 'thee', 'alstublieft'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Een ___ met kaas, alstublieft.',
      'correct': 'broodje',
      'hint': 'bread roll',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"appelsap" means?',
      'options': ['orange juice', 'apple sauce', 'apple juice', 'mineral water'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you have tea?"',
      'target': 'Heeft u thee?',
      'tiles': ['Heeft', 'u', 'thee', 'koffie', 'water', 'jij', 'hebben'],
    },
  ],

  'nl_u3_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ik vind het lekker." means?',
      'options': [
        'I think it\'s ugly.',
        'I find it boring.',
        'I think it\'s delicious.',
        'I like to cook.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I don\'t like fish."',
      'target': 'Ik lust geen vis',
      'tiles': ['Ik', 'lust', 'geen', 'vis', 'vlees', 'niet', 'vind'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik vind stroopwafel ___.',
      'correct': 'lekker',
      'hint': 'delicious',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Mag ik de rekening?" means?',
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
      'prompt': 'Say "I like Dutch cheese."',
      'target': 'Ik vind Nederlandse kaas lekker',
      'tiles': ['Ik', 'vind', 'Nederlandse', 'kaas', 'lekker', 'vies', 'houd'],
    },
  ],

  'nl_u3_l3': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "One coffee, please."',
      'target': 'Één koffie alstublieft',
      'tiles': ['Één', 'koffie', 'alstublieft', 'twee', 'thee', 'graag'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Wat kan ik voor u doen?" means?',
      'options': [
        'What do you recommend?',
        'What can I do for you?',
        'What would you like to eat?',
        'Can I take your order?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ graag een stuk taart.',
      'correct': 'wil',
      'hint': 'I would like',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Heeft u een tafeltje voor twee?" means?',
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
      'target': 'De rekening alstublieft',
      'tiles': ['De', 'rekening', 'alstublieft', 'menu', 'bestelling', 'graag'],
    },
  ],

  'nl_u3_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ik kan goed koken." means?',
      'options': [
        'I like to cook.',
        'I must cook now.',
        'I can cook well.',
        'I want to cook.',
      ],
      'correct': 2,
    },
    {
      'type': 'conjugationTable',
      'verb': 'kunnen',
      'tense': 'present tense',
      'pronouns': ['ik', 'jij/je', 'hij/zij', 'wij/we', 'jullie', 'zij/ze'],
      'answers': ['kan', 'kunt', 'kan', 'kunnen', 'kunnen', 'kunnen'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jij ___ morgen komen.',
      'correct': 'moet',
      'hint': 'moeten (must) — jij form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We must go now."',
      'target': 'Wij moeten nu gaan',
      'tiles': ['Wij', 'moeten', 'nu', 'gaan', 'kunnen', 'komen', 'later'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which is correct for "She must study"?',
      'options': [
        'Zij kunnen studeren.',
        'Zij moeten studeren.',
        'Zij moet studeren.',
        'Zij kunt studeren.',
      ],
      'correct': 2,
    },
  ],

  'nl_u3_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Good morning, do you have a table for two?"',
      'target': 'Goedemorgen heeft u een tafel voor twee',
      'tiles': ['Goedemorgen', 'heeft', 'u', 'een', 'tafel', 'voor', 'twee', 'tafeltje'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Wilt u iets drinken?" means?',
      'options': [
        'Do you want something to eat?',
        'Can I take your order?',
        'Would you like something to drink?',
        'What is today\'s special?',
      ],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ graag een cappuccino en een stuk appeltaart.',
      'correct': 'wil',
      'hint': 'I would like',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "It was delicious, thank you."',
      'target': 'Het was heel lekker dank u wel',
      'tiles': ['Het', 'was', 'heel', 'lekker', 'dank', 'u', 'wel', 'niet'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'You want to pay. What do you say?',
      'options': [
        '"Mag ik de kaart?"',
        '"Mag ik de rekening?"',
        '"Mag ik de bestelling?"',
        '"Mag ik de keuken?"',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 4 — Richtingen & Vervoer
  // ─────────────────────────────────────────────

  'nl_u4_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "dertien" in numerals?',
      'options': ['12', '30', '13', '3'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am seventeen years old."',
      'target': 'Ik ben zeventien jaar oud',
      'tiles': ['Ik', 'ben', 'zeventien', 'jaar', 'oud', 'zestien', 'achttien'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Het is ___ graden buiten.',
      'correct': 'twaalf',
      'hint': 'twelve degrees outside',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which number comes after "negentien"?',
      'options': ['achttien', 'twintig', 'eenentwintig', 'zestien'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have fifteen euros."',
      'target': 'Ik heb vijftien euro',
      'tiles': ['Ik', 'heb', 'vijftien', 'euro', 'tien', 'twintig', 'negen'],
    },
  ],

  'nl_u4_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ga rechtdoor" means?',
      'options': ['Turn right', 'Turn left', 'Go straight ahead', 'Stop here'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Turn left at the traffic lights."',
      'target': 'Sla links af bij het stoplicht',
      'tiles': ['Sla', 'links', 'af', 'bij', 'het', 'stoplicht', 'rechts', 'rechtdoor'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Het station is ___ de hoek.',
      'correct': 'om',
      'hint': 'around the corner',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Hoe ver is het?" means?',
      'options': [
        'What time is it?',
        'How long does it take?',
        'How far is it?',
        'Where is the stop?',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The museum is on the right."',
      'target': 'Het museum is aan de rechterkant',
      'tiles': ['Het', 'museum', 'is', 'aan', 'de', 'rechterkant', 'linkerkant', 'links'],
    },
  ],

  'nl_u4_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ik neem de trein." means?',
      'options': ['I take the bus.', 'I take the tram.', 'I take the train.', 'I take the subway.'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Where is the tram stop?"',
      'target': 'Waar is de tramhalte?',
      'tiles': ['Waar', 'is', 'de', 'tramhalte', 'bushalte', 'trein', 'fiets'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ___ elke dag met de fiets naar mijn werk.',
      'correct': 'ga',
      'hint': 'gaan (to go) — ik form',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"een enkel kaartje" means?',
      'options': [
        'a return ticket',
        'a student ticket',
        'a first class ticket',
        'a single ticket',
      ],
      'correct': 3,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "A return ticket to Utrecht, please."',
      'target': 'Een retourkaartje naar Utrecht alstublieft',
      'tiles': ['Een', 'retourkaartje', 'naar', 'Utrecht', 'alstublieft', 'enkel', 'Amsterdam'],
    },
  ],

  'nl_u4_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"De sleutels liggen op tafel." means?',
      'options': [
        'The keys are under the table.',
        'The keys are on the table.',
        'The keys are next to the table.',
        'The keys are behind the table.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The bakery is next to the station."',
      'target': 'De bakkerij is naast het station',
      'tiles': ['De', 'bakkerij', 'is', 'naast', 'het', 'station', 'tegenover', 'bank'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'De kat zit ___ de stoel.',
      'correct': 'onder',
      'hint': 'under / beneath',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which preposition means "in front of"?',
      'options': ['achter', 'naast', 'voor', 'tussen'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The hotel is opposite the church."',
      'target': 'Het hotel is tegenover de kerk',
      'tiles': ['Het', 'hotel', 'is', 'tegenover', 'de', 'kerk', 'naast', 'voor'],
    },
  ],

  'nl_u4_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Excuse me, where is the station?"',
      'target': 'Pardon waar is het station?',
      'tiles': ['Pardon', 'waar', 'is', 'het', 'station', 'bushalte', 'museum'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Het is op loopafstand." means?',
      'options': [
        'It is far away.',
        'It is within walking distance.',
        'You need to take the bus.',
        'It is on the right.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': '___ lang moet ik lopen?',
      'correct': 'Hoe',
      'hint': 'How long (question word)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Take the number 4 tram."',
      'target': 'Neem tram vier',
      'tiles': ['Neem', 'tram', 'vier', 'bus', 'trein', 'vijf', 'metro'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Dank u voor uw hulp." means?',
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
  // UNIT 5 — Dagelijks Leven & Tijd
  // ─────────────────────────────────────────────

  'nl_u5_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"Hoe laat is het?" means?',
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
      'prompt': 'Say "It is quarter past eight."',
      'target': 'Het is kwart over acht',
      'tiles': ['Het', 'is', 'kwart', 'over', 'acht', 'voor', 'half'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'De trein vertrekt om ___ uur.',
      'correct': 'drie',
      'hint': 'three o\'clock (write the word)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Het is kwart voor vijf." means?',
      'options': ['4:15', '4:45', '5:15', '5:45'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The store closes at six o\'clock."',
      'target': 'De winkel sluit om zes uur',
      'tiles': ['De', 'winkel', 'sluit', 'om', 'zes', 'uur', 'vijf', 'opent'],
    },
  ],

  'nl_u5_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ik sta elke dag om zeven uur op." means?',
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
      'prompt': 'Say "After showering I have breakfast."',
      'target': 'Na het douchen ontbijt ik',
      'tiles': ['Na', 'het', 'douchen', 'ontbijt', 'ik', 'slaap', 'ga'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Ik ga ___ om tien uur naar bed.',
      'correct': 'altijd',
      'hint': 'always',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"lunchen" means?',
      'options': ['to have breakfast', 'to have lunch', 'to have dinner', 'to have a snack'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I go to work by bike."',
      'target': 'Ik ga met de fiets naar mijn werk',
      'tiles': ['Ik', 'ga', 'met', 'de', 'fiets', 'naar', 'mijn', 'werk', 'auto'],
    },
  ],

  'nl_u5_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Ik sta om zes uur op." — What is the base verb?',
      'options': ['staan', 'opstaan', 'opzetten', 'stoppen'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "He calls her back." (terugbellen)',
      'target': 'Hij belt haar terug',
      'tiles': ['Hij', 'belt', 'haar', 'terug', 'op', 'bellen', 'af'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Wij komen morgen ___ thuis.',
      'correct': 'aan',
      'hint': 'aankomen — we arrive home tomorrow',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"afwassen" means?',
      'options': ['to do laundry', 'to do the dishes', 'to vacuum', 'to iron'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "She hangs up the phone." (ophangen)',
      'target': 'Zij hangt de telefoon op',
      'tiles': ['Zij', 'hangt', 'de', 'telefoon', 'op', 'af', 'weg'],
    },
  ],

  'nl_u5_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What day comes after "woensdag"?',
      'options': ['dinsdag', 'donderdag', 'vrijdag', 'maandag'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I work from Monday to Friday."',
      'target': 'Ik werk van maandag tot vrijdag',
      'tiles': ['Ik', 'werk', 'van', 'maandag', 'tot', 'vrijdag', 'zaterdag', 'dinsdag'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Mijn verjaardag is in ___.',
      'correct': 'maart',
      'hint': 'March',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"februari" is?',
      'options': ['January', 'February', 'March', 'April'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you on Saturday!"',
      'target': 'Tot zaterdag',
      'tiles': ['Tot', 'zaterdag', 'zondag', 'vrijdag', 'ziens', 'later'],
    },
  ],

  'nl_u5_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Are you free this weekend?"',
      'target': 'Ben jij dit weekend vrij?',
      'tiles': ['Ben', 'jij', 'dit', 'weekend', 'vrij', 'bezig', 'thuis'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Ik heb een afspraak." means?',
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
      'sentence': 'Zullen we ___ in de stad afspreken?',
      'correct': 'ergens',
      'hint': 'somewhere in the city',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Suggest "Let\'s go to the cinema on Friday."',
      'target': 'Zullen we vrijdag naar de bioscoop gaan?',
      'tiles': ['Zullen', 'we', 'vrijdag', 'naar', 'de', 'bioscoop', 'gaan?', 'zaterdag'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Dat klinkt goed!" means?',
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
