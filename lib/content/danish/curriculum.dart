const Map<String, List<Map<String, dynamic>>> danishLessonExercises = {

  // ─────────────────────────────────────────────
  // UNIT 1 — Hej og farvel (Greetings & Introductions)
  // ─────────────────────────────────────────────

  'da_u1_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Godmorgen" mean?',
      'options': ['Good evening', 'Good morning', 'Good night', 'Good afternoon'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Goodbye" in Danish.',
      'target': 'Farvel og på gensyn',
      'tiles': ['Farvel', 'og', 'på', 'gensyn', 'Hej', 'Tak', 'Godnat'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which greeting is used in the evening?',
      'options': ['Godmorgen', 'Godmiddag', 'Godaften', 'Godnat'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'God___ og godnat!',
      'correct': 'aften',
      'hint': 'Good evening and good night',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good night, sleep well."',
      'target': 'Godnat sov godt',
      'tiles': ['Godnat', 'sov', 'godt', 'Farvel', 'Hej', 'vel'],
    },
  ],

  'da_u1_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "My name is Sofia" in Danish?',
      'options': [
        'Jeg er hedde Sofia.',
        'Mit navn er Sofia.',
        'Hvordan hedder Sofia?',
        'Sofia navn jeg.',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask someone\'s name informally.',
      'target': 'Hvad hedder du?',
      'tiles': ['Hvad', 'hedder', 'du', 'er', 'navn', 'hvem'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg ___ Mads.',
      'correct': 'hedder',
      'hint': 'at hedde (to be called) — jeg form',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Dejligt at møde dig" means?',
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
      'prompt': 'Say "My name is Lars."',
      'target': 'Mit navn er Lars',
      'tiles': ['Mit', 'navn', 'er', 'Lars', 'hedder', 'jeg', 'han'],
    },
  ],

  'da_u1_l3': [
    {
      'type': 'conjugationTable',
      'verb': 'at være',
      'tense': 'nutid (present tense)',
      'pronouns': ['jeg', 'du', 'han/hun', 'vi', 'I', 'de'],
      'answers': ['er', 'er', 'er', 'er', 'er', 'er'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Du er klog." mean?',
      'options': ['You have talent.', 'You are smart.', 'You feel good.', 'You are tired.'],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Vi ___ gode venner.',
      'correct': 'er',
      'hint': 'at være — vi form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am tired."',
      'target': 'Jeg er træt',
      'tiles': ['Jeg', 'er', 'træt', 'glad', 'sulten', 'ikke'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Choose the correct translation of "She is happy."',
      'options': ['Hun har glad.', 'Hun være glad.', 'Hun er glad.', 'Hun hed glad.'],
      'correct': 2,
    },
  ],

  'da_u1_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "Hvor kommer du fra?" mean?',
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
      'prompt': 'Say "I come from Denmark."',
      'target': 'Jeg kommer fra Danmark',
      'tiles': ['Jeg', 'kommer', 'fra', 'Danmark', 'er', 'bor', 'Sverige'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg ___ i København.',
      'correct': 'bor',
      'hint': 'at bo (to live) — jeg form',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg taler lidt dansk." means?',
      'options': [
        'I speak a lot of Danish.',
        'I speak a little Danish.',
        'I don\'t speak Danish.',
        'Do you speak Danish?',
      ],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you speak Danish?"',
      'target': 'Taler du dansk?',
      'tiles': ['Taler', 'du', 'dansk', 'engelsk', 'Snakker', 'jeg'],
    },
  ],

  'da_u1_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Hello, how are you?"',
      'target': 'Hej hvordan har du det',
      'tiles': ['Hej', 'hvordan', 'har', 'du', 'det', 'er', 'godt'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Det går godt, tak." means?',
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
      'sentence': 'Hyggeligt at møde ___!',
      'correct': 'dig',
      'hint': 'Nice to meet you (object pronoun)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you later!"',
      'target': 'Vi ses senere',
      'tiles': ['Vi', 'ses', 'senere', 'Farvel', 'Hej', 'snart'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which is the most casual goodbye?',
      'options': ['Farvel', 'Godaften', 'Hej hej', 'Godmorgen'],
      'correct': 2,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 2 — Familie & Hobby (Family & Hobbies)
  // ─────────────────────────────────────────────

  'da_u2_l1': [
    {
      'type': 'conjugationTable',
      'verb': 'at have',
      'tense': 'nutid (present tense)',
      'pronouns': ['jeg', 'du', 'han/hun', 'vi', 'I', 'de'],
      'answers': ['har', 'har', 'har', 'har', 'har', 'har'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Han har en hund." means?',
      'options': ['He wants a dog.', 'He had a dog.', 'He has a dog.', 'He likes a dog.'],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'I ___ en stor have.',
      'correct': 'har',
      'hint': 'at have — I form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have a sister."',
      'target': 'Jeg har en søster',
      'tiles': ['Jeg', 'har', 'en', 'søster', 'bror', 'er', 'hus'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "She has a car"?',
      'options': ['Hun er en bil.', 'Hun har en bil.', 'Hun er bil.', 'Hun have en bil.'],
      'correct': 1,
    },
  ],

  'da_u2_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "bror" mean?',
      'options': ['sister', 'father', 'brother', 'son'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My mother is kind."',
      'target': 'Min mor er sød',
      'tiles': ['Min', 'mor', 'er', 'sød', 'far', 'bror', 'søster'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Min ___ hedder Sofie.',
      'correct': 'søster',
      'hint': 'sister',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"bedsteforældre" means?',
      'options': ['parents', 'grandparents', 'children', 'siblings'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have two children."',
      'target': 'Jeg har to børn',
      'tiles': ['Jeg', 'har', 'to', 'børn', 'tre', 'barn', 'søskende'],
    },
  ],

  'da_u2_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is the correct form of "arbejde" for "jeg"?',
      'options': ['arbejder', 'arbejde', 'arbejdes', 'arbejdet'],
      'correct': 0,
    },
    {
      'type': 'conjugationTable',
      'verb': 'arbejde',
      'tense': 'nutid (present tense)',
      'pronouns': ['jeg', 'du', 'han/hun', 'vi', 'I', 'de'],
      'answers': ['arbejder', 'arbejder', 'arbejder', 'arbejder', 'arbejder', 'arbejder'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Han ___ hver dag hårdt.',
      'correct': 'arbejder',
      'hint': 'arbejde — han form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We live in Copenhagen."',
      'target': 'Vi bor i København',
      'tiles': ['Vi', 'bor', 'i', 'København', 'arbejder', 'er', 'Danmark'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "spille" mean?',
      'options': ['to speak', 'to sleep', 'to play', 'to swim'],
      'correct': 2,
    },
  ],

  'da_u2_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Min hobby er at læse." means?',
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
      'target': 'Jeg svømmer gerne',
      'tiles': ['Jeg', 'svømmer', 'gerne', 'spiller', 'læser', 'cykler'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Han spiller guitar ___ gange om ugen.',
      'correct': 'tre',
      'hint': 'three times a week',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "cykle" mean?',
      'options': ['to run', 'to cycle', 'to swim', 'to cook'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "What is your hobby?"',
      'target': 'Hvad er din hobby?',
      'tiles': ['Hvad', 'er', 'din', 'hobby', 'laver', 'du', 'gerne'],
    },
  ],

  'da_u2_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My name is Ida and I am 25."',
      'target': 'Jeg hedder Ida og er 25',
      'tiles': ['Jeg', 'hedder', 'Ida', 'og', 'er', '25', 'har', 'navn'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg kommer fra Odense." means?',
      'options': [
        'I live in Odense.',
        'I come from Odense.',
        'I work in Odense.',
        'I visit Odense.',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg ___ som lærer på en skole.',
      'correct': 'arbejder',
      'hint': 'at arbejde (to work) — jeg form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "My hobby is cycling."',
      'target': 'Min hobby er cykling',
      'tiles': ['Min', 'hobby', 'er', 'cykling', 'svømning', 'læsning'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "I have two brothers"?',
      'options': [
        'Jeg er to brødre.',
        'Jeg har to brødre.',
        'Jeg har to bror.',
        'Jeg have to brødre.',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 3 — Mad & Café (Food & Café)
  // ─────────────────────────────────────────────

  'da_u3_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"brød" means?',
      'options': ['meat', 'bread', 'cake', 'fruit'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I would like a coffee, please."',
      'target': 'Jeg vil gerne have en kaffe',
      'tiles': ['Jeg', 'vil', 'gerne', 'have', 'en', 'kaffe', 'te', 'tak'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Et ___ med ost, tak.',
      'correct': 'rundstykke',
      'hint': 'bread roll',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"æblejuice" means?',
      'options': ['orange juice', 'apple sauce', 'apple juice', 'mineral water'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Do you have tea?"',
      'target': 'Har I te?',
      'tiles': ['Har', 'I', 'te', 'kaffe', 'vand', 'du', 'have'],
    },
  ],

  'da_u3_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg kan godt lide det." means?',
      'options': [
        'I think it\'s ugly.',
        'I find it boring.',
        'I like it.',
        'I like to cook.',
      ],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I don\'t like fish."',
      'target': 'Jeg kan ikke lide fisk',
      'tiles': ['Jeg', 'kan', 'ikke', 'lide', 'fisk', 'kød', 'godt'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg kan godt lide ___ med smør.',
      'correct': 'rugbrød',
      'hint': 'rye bread with butter',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Må jeg få regningen?" means?',
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
      'prompt': 'Say "I like Danish pastry."',
      'target': 'Jeg kan godt lide wienerbrød',
      'tiles': ['Jeg', 'kan', 'godt', 'lide', 'wienerbrød', 'ikke', 'smørrebrød'],
    },
  ],

  'da_u3_l3': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "One coffee, please."',
      'target': 'En kaffe tak',
      'tiles': ['En', 'kaffe', 'tak', 'to', 'te', 'gerne'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Hvad må det være?" means?',
      'options': [
        'What do you recommend?',
        'What can I do for you?',
        'What will it be? / What can I get you?',
        'Can I take your order?',
      ],
      'correct': 2,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg vil ___ have et stykke kage.',
      'correct': 'gerne',
      'hint': 'I would like (gladly)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Har I et bord til to?" means?',
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
      'target': 'Regningen tak',
      'tiles': ['Regningen', 'tak', 'menuen', 'bestillingen', 'gerne'],
    },
  ],

  'da_u3_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg kan godt lide at lave mad." means?',
      'options': [
        'I must cook now.',
        'I can cook well.',
        'I like to cook.',
        'I want to eat.',
      ],
      'correct': 2,
    },
    {
      'type': 'conjugationTable',
      'verb': 'kan/skal',
      'tense': 'nutid — modaler (modal verbs)',
      'pronouns': ['jeg', 'du', 'han/hun', 'vi', 'I', 'de'],
      'answers': ['kan/skal', 'kan/skal', 'kan/skal', 'kan/skal', 'kan/skal', 'kan/skal'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Du ___ komme i morgen.',
      'correct': 'skal',
      'hint': 'skal (must/shall) — du form',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "We must go now."',
      'target': 'Vi skal gå nu',
      'tiles': ['Vi', 'skal', 'gå', 'nu', 'kan', 'komme', 'senere'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which is correct for "She must study"?',
      'options': [
        'Hun kan studere.',
        'Hun skal studere.',
        'Hun vil studere.',
        'Hun må studere.',
      ],
      'correct': 1,
    },
  ],

  'da_u3_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Good morning, a table for two please."',
      'target': 'Godmorgen et bord til to tak',
      'tiles': ['Godmorgen', 'et', 'bord', 'til', 'to', 'tak', 'tre', 'gerne'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Vil I gerne bestille?" means?',
      'options': [
        'Do you want something to eat?',
        'Can I take your order?',
        'Would you like something to drink?',
        'What is today\'s special?',
      ],
      'correct': 1,
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg vil ___ have en cappuccino og et stykke kage.',
      'correct': 'gerne',
      'hint': 'I would like (gladly)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "It was delicious, thank you."',
      'target': 'Det var rigtig godt tak',
      'tiles': ['Det', 'var', 'rigtig', 'godt', 'tak', 'ikke', 'lækkert'],
    },
    {
      'type': 'multipleChoice',
      'prompt': 'You want to pay. What do you say?',
      'options': [
        '"Må jeg få menuen?"',
        '"Må jeg få regningen?"',
        '"Må jeg få bestillingen?"',
        '"Må jeg få køkkenet?"',
      ],
      'correct': 1,
    },
  ],

  // ─────────────────────────────────────────────
  // UNIT 4 — Veje & Transport (Directions & Transport)
  // ─────────────────────────────────────────────

  'da_u4_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "tretten" in numerals?',
      'options': ['12', '30', '13', '3'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am seventeen years old."',
      'target': 'Jeg er sytten år gammel',
      'tiles': ['Jeg', 'er', 'sytten', 'år', 'gammel', 'seksten', 'atten'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Det er ___ grader udenfor.',
      'correct': 'tolv',
      'hint': 'twelve degrees outside',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which number comes after "nitten"?',
      'options': ['atten', 'tyve', "enogtyve", 'seksten'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I have fifteen kroner."',
      'target': 'Jeg har femten kroner',
      'tiles': ['Jeg', 'har', 'femten', 'kroner', 'ti', 'tyve', 'ni'],
    },
  ],

  'da_u4_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Gå ligeud" means?',
      'options': ['Turn right', 'Turn left', 'Go straight ahead', 'Stop here'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Turn left at the traffic lights."',
      'target': 'Drej til venstre ved lyskrydset',
      'tiles': ['Drej', 'til', 'venstre', 'ved', 'lyskrydset', 'højre', 'ligeud'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Stationen er ___ hjørnet.',
      'correct': 'om',
      'hint': 'around the corner',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Hvor langt er der?" means?',
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
      'target': 'Museet er på højre side',
      'tiles': ['Museet', 'er', 'på', 'højre', 'side', 'venstre', 'vej'],
    },
  ],

  'da_u4_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg tager toget." means?',
      'options': ['I take the bus.', 'I take the tram.', 'I take the train.', 'I take the subway.'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Where is the bus stop?"',
      'target': 'Hvor er busstoppet?',
      'tiles': ['Hvor', 'er', 'busstoppet', 'stationen', 'metroen', 'toget'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg ___ på cykel til arbejde hver dag.',
      'correct': 'kører',
      'hint': 'at køre (to ride/drive) — jeg form',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"en enkeltbillet" means?',
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
      'prompt': 'Say "A return ticket to Aarhus, please."',
      'target': 'En returbillet til Aarhus tak',
      'tiles': ['En', 'returbillet', 'til', 'Aarhus', 'tak', 'enkelt', 'København'],
    },
  ],

  'da_u4_l4': [
    {
      'type': 'multipleChoice',
      'prompt': '"Nøglerne ligger på bordet." means?',
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
      'target': 'Bageriet er ved siden af stationen',
      'tiles': ['Bageriet', 'er', 'ved', 'siden', 'af', 'stationen', 'overfor', 'banken'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Katten sidder ___ stolen.',
      'correct': 'under',
      'hint': 'under / beneath',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which preposition means "in front of"?',
      'options': ['bag ved', 'ved siden af', 'foran', 'mellem'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The hotel is opposite the church."',
      'target': 'Hotellet er overfor kirken',
      'tiles': ['Hotellet', 'er', 'overfor', 'kirken', 'ved', 'foran', 'siden'],
    },
  ],

  'da_u4_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Excuse me, where is the station?"',
      'target': 'Undskyld hvor er stationen?',
      'tiles': ['Undskyld', 'hvor', 'er', 'stationen', 'busstoppet', 'museet'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Det er inden for gåafstand." means?',
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
      'sentence': '___ langt skal jeg gå?',
      'correct': 'Hvor',
      'hint': 'How far (question word)',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "Take bus number 5."',
      'target': 'Tag bus nummer fem',
      'tiles': ['Tag', 'bus', 'nummer', 'fem', 'toget', 'fire', 'metro'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Tak for hjælpen." means?',
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
  // UNIT 5 — Dagligdag & Tid (Daily Life & Time)
  // ─────────────────────────────────────────────

  'da_u5_l1': [
    {
      'type': 'multipleChoice',
      'prompt': '"Hvad er klokken?" means?',
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
      'prompt': 'Say "It is quarter to nine." (8:45)',
      'target': 'Klokken er kvart i ni',
      'tiles': ['Klokken', 'er', 'kvart', 'i', 'ni', 'over', 'otte'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Toget afgår klokken ___.',
      'correct': 'tre',
      'hint': 'three o\'clock (write the word)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Klokken er kvart i fem." means?',
      'options': ['4:15', '4:45', '5:15', '5:45'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "The shop closes at six o\'clock."',
      'target': 'Butikken lukker klokken seks',
      'tiles': ['Butikken', 'lukker', 'klokken', 'seks', 'fem', 'åbner', 'syv'],
    },
  ],

  'da_u5_l2': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg står op klokken syv hver dag." means?',
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
      'target': 'Efter at bade spiser jeg morgenmad',
      'tiles': ['Efter', 'at', 'bade', 'spiser', 'jeg', 'morgenmad', 'sover', 'går'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Jeg går ___ i seng klokken ti.',
      'correct': 'altid',
      'hint': 'always',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"frokost" means?',
      'options': ['breakfast', 'lunch', 'dinner', 'snack'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I go to work by bike."',
      'target': 'Jeg cykler til arbejde',
      'tiles': ['Jeg', 'cykler', 'til', 'arbejde', 'kører', 'bus', 'går'],
    },
  ],

  'da_u5_l3': [
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg står op klokken seks." — What is the base verb?',
      'options': ['stå', 'stå op', 'opstå', 'stoppe'],
      'correct': 1,
    },
    {
      'type': 'conjugationTable',
      'verb': 'stå op / ringe op',
      'tense': 'nutid — partikelverber (particle verbs)',
      'pronouns': ['jeg', 'du', 'han/hun', 'vi', 'I', 'de'],
      'answers': ['står op', 'står op', 'står op', 'står op', 'står op', 'står op'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Hun ___ op til sin mor hver søndag.',
      'correct': 'ringer',
      'hint': 'at ringe op (to call) — hun form (particle stays at end)',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"slukke for" means?',
      'options': ['to turn on', 'to wash up', 'to turn off', 'to iron'],
      'correct': 2,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "She turns off the light." (slukke for)',
      'target': 'Hun slukker for lyset',
      'tiles': ['Hun', 'slukker', 'for', 'lyset', 'tænder', 'tv', 'af'],
    },
  ],

  'da_u5_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What day comes after "onsdag"?',
      'options': ['tirsdag', 'torsdag', 'fredag', 'mandag'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I work from Monday to Friday."',
      'target': 'Jeg arbejder fra mandag til fredag',
      'tiles': ['Jeg', 'arbejder', 'fra', 'mandag', 'til', 'fredag', 'lørdag', 'tirsdag'],
    },
    {
      'type': 'fillBlank',
      'sentence': 'Min fødselsdag er i ___.',
      'correct': 'marts',
      'hint': 'March',
    },
    {
      'type': 'multipleChoice',
      'prompt': '"februar" is?',
      'options': ['January', 'February', 'March', 'April'],
      'correct': 1,
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "See you on Saturday!"',
      'target': 'Vi ses på lørdag',
      'tiles': ['Vi', 'ses', 'på', 'lørdag', 'søndag', 'fredag', 'snart'],
    },
  ],

  'da_u5_l5': [
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "Are you free this weekend?"',
      'target': 'Er du fri i weekenden?',
      'tiles': ['Er', 'du', 'fri', 'i', 'weekenden', 'travl', 'hjemme'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Jeg har en aftale." means?',
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
      'sentence': 'Skal vi mødes ___ i byen?',
      'correct': 'et sted',
      'hint': 'somewhere in the city',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Suggest "Let\'s go to the cinema on Friday."',
      'target': 'Skal vi i biografen på fredag?',
      'tiles': ['Skal', 'vi', 'i', 'biografen', 'på', 'fredag?', 'lørdag', 'tivoli'],
    },
    {
      'type': 'multipleChoice',
      'prompt': '"Det lyder godt!" means?',
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
