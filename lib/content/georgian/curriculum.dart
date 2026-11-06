import 'package:koala/services/curriculum_generator.dart';

const List<CurriculumUnit> georgianUnits = [
  CurriculumUnit(
    id: 'ka_u1',
    title: 'Unit 1 — Survival Georgian',
    description: 'Get around, greet people, count money, and ask for help',
    lessons: [
      CurriculumLesson(id: 'ka_u1_l1', title: 'Greetings & Basics'),
      CurriculumLesson(id: 'ka_u1_l2', title: 'Getting Around'),
      CurriculumLesson(id: 'ka_u1_l3', title: 'Numbers & Money'),
      CurriculumLesson(id: 'ka_u1_l4', title: 'Getting Help'),
    ],
  ),
  CurriculumUnit(
    id: 'ka_u2',
    title: 'Unit 2 — Food & Wine',
    description: 'Order Georgian dishes, navigate wine culture, pay the bill',
    lessons: [
      CurriculumLesson(id: 'ka_u2_l1', title: 'Georgian Dishes'),
      CurriculumLesson(id: 'ka_u2_l2', title: 'Ordering Food'),
      CurriculumLesson(id: 'ka_u2_l3', title: 'Drinks & Wine Culture'),
      CurriculumLesson(id: 'ka_u2_l4', title: 'Paying the Bill'),
    ],
  ),
  CurriculumUnit(
    id: 'ka_u3',
    title: 'Unit 3 — Connecting with Locals',
    description: 'Introduce yourself, share origins, enjoy a supra feast',
    lessons: [
      CurriculumLesson(id: 'ka_u3_l1', title: 'Introductions'),
      CurriculumLesson(id: 'ka_u3_l2', title: 'Where Are You From?'),
      CurriculumLesson(id: 'ka_u3_l3', title: 'Reactions & Compliments'),
      CurriculumLesson(id: 'ka_u3_l4', title: 'At a Supra Feast'),
    ],
  ),
];

const Map<String, List<Map<String, dynamic>>> georgianLessonExercises = {
  // ─── Unit 1, Lesson 1: Greetings & Basics ──────────────────────────────
  'ka_u1_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "gamarjoba" mean?',
      'options': ['Goodbye', 'Hello', 'Thank you', 'Please'],
      'correct': 1,
      'ttsText': 'გამარჯობა',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "thank you very much"',
      'target': 'didi madloba',
      'tiles': ['didi', 'madloba', 'gamarjoba', 'ara'],
      'ttsText': 'დიდი მადლობა',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you say "goodbye" in Georgian?',
      'options': ['gamarjoba', 'madloba', 'nakhvamdis', 'bodishi'],
      'correct': 2,
      'ttsText': 'ნახვამდის',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ (excuse me/sorry)',
      'correct': 'bodishi',
      'hint': 'excuse me / sorry',
      'ttsText': 'ბოდიში',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "please" (if it is possible)',
      'target': 'tu sheidzleba',
      'tiles': ['tu', 'sheidzleba', 'madloba', 'diakh'],
      'ttsText': 'თუ შეიძლება',
    },
  ],

  // ─── Unit 1, Lesson 2: Getting Around ──────────────────────────────────
  'ka_u1_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "sad aris?" mean?',
      'options': ['How much?', 'Where is?', 'What is this?', 'Who are you?'],
      'correct': 1,
      'ttsText': 'სად არის?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask "where is the hotel?"',
      'target': 'sad aris sastumo?',
      'tiles': ['sad', 'aris', 'sastumo?', 'taksi', 'metro'],
      'ttsText': 'სად არის სასტუმრო?',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "martskhniv" mean?',
      'options': ['Right', 'Straight ahead', 'Left', 'Stop'],
      'correct': 2,
      'ttsText': 'მარცხნივ',
    },
    {
      'type': 'fillBlank',
      'sentence': 'Go ___ (straight ahead)',
      'correct': 'pirdapir',
      'hint': 'straight ahead',
      'ttsText': 'პირდაპირ',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which word means "taxi"?',
      'options': ['metro', 'sastumo', 'taksi', 'lari'],
      'correct': 2,
      'ttsText': 'ტაქსი',
    },
  ],

  // ─── Unit 1, Lesson 3: Numbers & Money ────────────────────────────────
  'ka_u1_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "ra ghirs?" mean?',
      'options': ['What is this?', 'How much?', 'Where is it?', 'Is it good?'],
      'correct': 1,
      'ttsText': 'რა ღირს?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Count from one to three',
      'target': 'erti ori sami',
      'tiles': ['erti', 'ori', 'sami', 'otkhi', 'khuti'],
      'ttsText': 'ერთი ორი სამი',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is the Georgian currency?',
      'options': ['euro', 'lira', 'lari', 'ruble'],
      'correct': 2,
      'ttsText': 'ლარი',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ ghirs? (how much does it cost?)',
      'correct': 'ra',
      'hint': 'what / how much',
      'ttsText': 'რა ღირს?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Count from six to eight',
      'target': 'ekvsi shvidi rva',
      'tiles': ['ekvsi', 'shvidi', 'rva', 'tskhra', 'ati'],
      'ttsText': 'ექვსი შვიდი რვა',
    },
  ],

  // ─── Unit 1, Lesson 4: Getting Help ───────────────────────────────────
  'ka_u1_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "ar gavige" mean?',
      'options': ['I understand', 'I didn\'t understand', 'Speak slowly', 'Please repeat'],
      'correct': 1,
      'ttsText': 'არ გავიგე',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "speak slowly"',
      'target': 'nela ilaparakt',
      'tiles': ['nela', 'ilaparakt', 'ar', 'gavige'],
      'ttsText': 'ნელა ილაპარაკეთ',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you ask "do you speak English?"',
      'options': [
        'gamarjoba inglisuri?',
        'inglisurád laparakóbt?',
        'sad aris inglisi?',
        'madloba inglisuri'
      ],
      'correct': 1,
      'ttsText': 'ინგლისურად ლაპარაკობთ?',
    },
    {
      'type': 'fillBlank',
      'sentence': 'ar ___ (I didn\'t understand)',
      'correct': 'gavige',
      'hint': 'understand (past)',
      'ttsText': 'არ გავიგე',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "diakh" mean?',
      'options': ['No', 'Maybe', 'Yes', 'Please'],
      'correct': 2,
      'ttsText': 'დიახ',
    },
  ],

  // ─── Unit 2, Lesson 1: Georgian Dishes ────────────────────────────────
  'ka_u2_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What are "khinkali"?',
      'options': ['Cheese bread', 'Grilled meat', 'Georgian dumplings', 'Bean bread'],
      'correct': 2,
      'ttsText': 'ხინკალი',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is "khachapuri"?',
      'options': ['A wine', 'Cheese bread', 'Chicken stew', 'Eggplant dish'],
      'correct': 1,
      'ttsText': 'ხაჭაპური',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Name two classic Georgian dishes',
      'target': 'khinkali khachapuri',
      'tiles': ['khinkali', 'khachapuri', 'ludi', 'ghvino'],
      'ttsText': 'ხინკალი ხაჭაპური',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is "mtsvadi"?',
      'options': ['Eggplant with walnut', 'Grilled meat on skewers', 'Chicken stew', 'Bean-filled bread'],
      'correct': 1,
      'ttsText': 'მწვადი',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ is eggplant with walnut paste',
      'correct': 'badrijani',
      'hint': 'Georgian eggplant dish',
      'ttsText': 'ბადრიჯანი',
    },
  ],

  // ─── Unit 2, Lesson 2: Ordering Food ──────────────────────────────────
  'ka_u2_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "minda" mean?',
      'options': ['I have', 'I want', 'I like', 'I need'],
      'correct': 1,
      'ttsText': 'მინდა',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "bring me khinkali"',
      'target': 'momitanet khinkali',
      'tiles': ['momitanet', 'khinkali', 'minda', 'ghvino'],
      'ttsText': 'მომიტანეთ ხინკალი',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "gemrielia!" mean?',
      'options': ['Cheers!', 'Thank you!', 'Delicious!', 'Goodbye!'],
      'correct': 2,
      'ttsText': 'გემრიელია!',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ khachapuri (I want khachapuri)',
      'correct': 'minda',
      'hint': 'I want',
      'ttsText': 'მინდა ხაჭაპური',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "bring me water please"',
      'target': 'momitanet tskali tu sheidzleba',
      'tiles': ['momitanet', 'tskali', 'tu', 'sheidzleba', 'ludi'],
      'ttsText': 'მომიტანეთ წყალი თუ შეიძლება',
    },
  ],

  // ─── Unit 2, Lesson 3: Drinks & Wine Culture ──────────────────────────
  'ka_u2_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is "ghvino"?',
      'options': ['Beer', 'Tea', 'Wine', 'Coffee'],
      'correct': 2,
      'ttsText': 'ღვინო',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask for red wine',
      'target': 'tsiteli ghvino',
      'tiles': ['tsiteli', 'ghvino', 'tetri', 'ludi'],
      'ttsText': 'წითელი ღვინო',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "gaumarjos!" mean?',
      'options': ['Goodbye!', 'Cheers!', 'Delicious!', 'Welcome!'],
      'correct': 1,
      'ttsText': 'გაუმარჯოს!',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ ghvino (white wine)',
      'correct': 'tetri',
      'hint': 'white',
      'ttsText': 'თეთრი ღვინო',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is "ludi"?',
      'options': ['Wine', 'Tea', 'Water', 'Beer'],
      'correct': 3,
      'ttsText': 'ლუდი',
    },
  ],

  // ─── Unit 2, Lesson 4: Paying the Bill ────────────────────────────────
  'ka_u2_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "angarishi" mean?',
      'options': ['Menu', 'Waiter', 'The bill', 'Receipt'],
      'correct': 2,
      'ttsText': 'ანგარიში',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask for the bill please',
      'target': 'angarishi tu sheidzleba',
      'tiles': ['angarishi', 'tu', 'sheidzleba', 'minda', 'madloba'],
      'ttsText': 'ანგარიში თუ შეიძლება',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'How do you ask "how much?"',
      'options': ['sad aris?', 'ra ghirs?', 'diakh?', 'ara?'],
      'correct': 1,
      'ttsText': 'რა ღირს?',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ aris? (how much is it?)',
      'correct': 'ra',
      'hint': 'what / how much',
      'ttsText': 'რა ღირს?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "thank you very much"',
      'target': 'didi madloba',
      'tiles': ['didi', 'madloba', 'bodishi', 'nakhvamdis'],
      'ttsText': 'დიდი მადლობა',
    },
  ],

  // ─── Unit 3, Lesson 1: Introductions ─────────────────────────────────
  'ka_u3_l1': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "me mkviya" mean?',
      'options': ['I am from', 'My name is', 'Nice to meet you', 'I like'],
      'correct': 1,
      'ttsText': 'მე მქვია',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Introduce yourself: "My name is Alex"',
      'target': 'me mkviya Alex',
      'tiles': ['me', 'mkviya', 'Alex', 'var', 'siamovnebit'],
      'ttsText': 'მე მქვია Alex',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "siamovnebit" mean?',
      'options': ['Goodbye', 'Hello', 'Nice to meet you', 'Thank you'],
      'correct': 2,
      'ttsText': 'სიამოვნებით',
    },
    {
      'type': 'fillBlank',
      'sentence': 'me ___ (my name is...)',
      'correct': 'mkviya',
      'hint': 'name is (verb)',
      'ttsText': 'მე მქვია',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "nice to meet you"',
      'target': 'siamovnebit',
      'tiles': ['siamovnebit', 'gamarjoba', 'madloba', 'nakhvamdis'],
      'ttsText': 'სიამოვნებით',
    },
  ],

  // ─── Unit 3, Lesson 2: Where Are You From? ───────────────────────────
  'ka_u3_l2': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "saidan khart?" mean?',
      'options': ['How are you?', 'Where are you from?', 'Where are you going?', 'What do you want?'],
      'correct': 1,
      'ttsText': 'საიდან ხართ?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I am from America"',
      'target': 'me var amerikidan',
      'tiles': ['me', 'var', 'amerikidan', 'saidan', 'khart'],
      'ttsText': 'მე ვარ ამერიკიდან',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "me var" mean?',
      'options': ['My name is', 'I want', 'I am', 'I have'],
      'correct': 2,
      'ttsText': 'მე ვარ',
    },
    {
      'type': 'fillBlank',
      'sentence': 'saidan ___? (where are you from?)',
      'correct': 'khart',
      'hint': 'are you (plural/formal)',
      'ttsText': 'საიდან ხართ?',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Ask someone where they are from',
      'target': 'saidan khart?',
      'tiles': ['saidan', 'khart?', 'sad', 'aris', 'mkviya'],
      'ttsText': 'საიდან ხართ?',
    },
  ],

  // ─── Unit 3, Lesson 3: Reactions & Compliments ───────────────────────
  'ka_u3_l3': [
    {
      'type': 'multipleChoice',
      'prompt': 'What does "mshvenierіa!" mean?',
      'options': ['Delicious!', 'Cheers!', 'It\'s beautiful!', 'Thank you!'],
      'correct': 2,
      'ttsText': 'მშვენიერია!',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "I love it very much"',
      'target': 'dzalian mikvars',
      'tiles': ['dzalian', 'mikvars', 'mshvenierіa', 'gemrielia'],
      'ttsText': 'ძალიან მიყვარს',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What does "gemrielia!" mean?',
      'options': ['It\'s beautiful!', 'Cheers!', 'I love it!', 'Delicious!'],
      'correct': 3,
      'ttsText': 'გემრიელია!',
    },
    {
      'type': 'fillBlank',
      'sentence': 'dzalian ___ (I love it very much)',
      'correct': 'mikvars',
      'hint': 'I love / I like',
      'ttsText': 'ძალიან მიყვარს',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'Which phrase expresses that something is beautiful?',
      'options': ['gemrielia', 'gaumarjos', 'mshvenieria', 'madloba'],
      'correct': 2,
      'ttsText': 'მშვენიერია!',
    },
  ],

  // ─── Unit 3, Lesson 4: At a Supra Feast ──────────────────────────────
  'ka_u3_l4': [
    {
      'type': 'multipleChoice',
      'prompt': 'What is a "supra"?',
      'options': ['A type of wine', 'A Georgian feast / table tradition', 'A dish of grilled meat', 'A toast glass'],
      'correct': 1,
      'ttsText': 'სუფრა',
    },
    {
      'type': 'multipleChoice',
      'prompt': 'What is a "tamada"?',
      'options': ['A Georgian dumpling', 'A wine region', 'The toastmaster at a supra', 'A type of bread'],
      'correct': 2,
      'ttsText': 'ტამადა',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Give the toast "to Georgia!"',
      'target': 'gaumarjos sakartvelos!',
      'tiles': ['gaumarjos', 'sakartvelos!', 'ghvino', 'tamada'],
      'ttsText': 'გაუმარჯოს საქართველოს!',
    },
    {
      'type': 'fillBlank',
      'sentence': '___ is the toastmaster at a Georgian feast',
      'correct': 'tamada',
      'hint': 'leads the toasts',
      'ttsText': 'ტამადა',
    },
    {
      'type': 'tapToBuild',
      'prompt': 'Say "cheers!" at the supra',
      'target': 'gaumarjos!',
      'tiles': ['gaumarjos!', 'madloba', 'nakhvamdis', 'bodishi'],
      'ttsText': 'გაუმარჯოს!',
    },
  ],
};
