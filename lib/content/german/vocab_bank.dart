class VocabEntry {
  final String german;
  final String english;
  final String gender;
  final String partOfSpeech;
  final String exampleSentence;

  const VocabEntry({
    required this.german,
    required this.english,
    required this.gender,
    required this.partOfSpeech,
    required this.exampleSentence,
  });
}

const Map<String, List<VocabEntry>> lessonVocab = {
  'u1_l1': [
    VocabEntry(german: 'Hallo', english: 'Hello', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Hallo! Wie heißt du?'),
    VocabEntry(german: 'Guten Morgen', english: 'Good morning', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Guten Morgen! Wie geht es Ihnen?'),
    VocabEntry(german: 'Guten Tag', english: 'Good day / Hello', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Guten Tag! Kann ich Ihnen helfen?'),
    VocabEntry(german: 'Guten Abend', english: 'Good evening', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Guten Abend! Schön, Sie zu sehen.'),
    VocabEntry(german: 'Gute Nacht', english: 'Good night', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Gute Nacht! Schlaf gut.'),
    VocabEntry(german: 'Auf Wiedersehen', english: 'Goodbye (formal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Auf Wiedersehen! Bis morgen.'),
    VocabEntry(german: 'Tschüss', english: 'Bye (informal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Tschüss! Bis bald.'),
  ],
  'u1_l2': [
    VocabEntry(german: 'heißen', english: 'to be called / named', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich heiße Anna.'),
    VocabEntry(german: 'Freut mich', english: 'Nice to meet you', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Freut mich! Ich heiße Max.'),
    VocabEntry(german: 'Mich auch', english: 'Me too / Likewise', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Freut mich! — Mich auch!'),
    VocabEntry(german: 'der Name', english: 'name', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Wie ist Ihr Name?'),
    VocabEntry(german: 'Wie heißt du?', english: 'What is your name? (informal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Wie heißt du? — Ich heiße Lena.'),
    VocabEntry(german: 'Wie heißen Sie?', english: 'What is your name? (formal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Wie heißen Sie? — Ich heiße Herr Müller.'),
  ],
  'u1_l3': [
    VocabEntry(german: 'sein', english: 'to be', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich bin müde.'),
    VocabEntry(german: 'müde', english: 'tired', gender: '—', partOfSpeech: 'adjective', exampleSentence: 'Er ist heute sehr müde.'),
    VocabEntry(german: 'nett', english: 'nice / kind', gender: '—', partOfSpeech: 'adjective', exampleSentence: 'Ihr seid sehr nett.'),
    VocabEntry(german: 'bin', english: 'am (ich form of sein)', gender: '—', partOfSpeech: 'verb form', exampleSentence: 'Ich bin aus Berlin.'),
    VocabEntry(german: 'sind', english: 'are (wir / sie form of sein)', gender: '—', partOfSpeech: 'verb form', exampleSentence: 'Wir sind Freunde.'),
  ],
  'u1_l4': [
    VocabEntry(german: 'kommen', english: 'to come', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich komme aus Deutschland.'),
    VocabEntry(german: 'Deutschland', english: 'Germany', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Sie kommt aus Deutschland.'),
    VocabEntry(german: 'Österreich', english: 'Austria', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Er kommt aus Österreich.'),
    VocabEntry(german: 'woher', english: 'from where', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Woher kommst du?'),
    VocabEntry(german: 'aus', english: 'from / out of', gender: '—', partOfSpeech: 'preposition', exampleSentence: 'Ich komme aus der Schweiz.'),
  ],
  'u1_l5': [
    VocabEntry(german: 'und', english: 'and', gender: '—', partOfSpeech: 'conjunction', exampleSentence: 'Ich heiße Felix und ich komme aus Wien.'),
    VocabEntry(german: 'gut', english: 'good / well', gender: '—', partOfSpeech: 'adjective', exampleSentence: 'Es geht mir gut.'),
    VocabEntry(german: 'danke', english: 'thank you', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Danke! Und dir?'),
    VocabEntry(german: 'bitte', english: "please / you're welcome", gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Danke! — Bitte!'),
    VocabEntry(german: 'auch', english: 'also / too', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Mich auch! Freut mich.'),
  ],
  'u2_l1': [
    VocabEntry(german: 'haben', english: 'to have', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich habe einen Hund.'),
    VocabEntry(german: 'der Hund', english: 'dog', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Mein Hund ist sehr groß.'),
    VocabEntry(german: 'die Zeit', english: 'time', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Wir haben keine Zeit.'),
    VocabEntry(german: 'kein / keine', english: 'no / not any', gender: '—', partOfSpeech: 'article', exampleSentence: 'Ich habe keine Zeit.'),
    VocabEntry(german: 'einen', english: 'a / an (masculine accusative)', gender: '—', partOfSpeech: 'article', exampleSentence: 'Ich habe einen Bruder.'),
  ],
  'u2_l2': [
    VocabEntry(german: 'die Familie', english: 'family', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Meine Familie ist groß.'),
    VocabEntry(german: 'die Mutter', english: 'mother', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Meine Mutter ist nett.'),
    VocabEntry(german: 'der Vater', english: 'father', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Mein Vater ist Arzt.'),
    VocabEntry(german: 'die Schwester', english: 'sister', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Ich habe eine Schwester.'),
    VocabEntry(german: 'der Bruder', english: 'brother', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Er hat einen Bruder.'),
    VocabEntry(german: 'die Geschwister', english: 'siblings', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Ich habe zwei Geschwister.'),
  ],
  'u2_l3': [
    VocabEntry(german: 'spielen', english: 'to play', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich spiele gerne Fußball.'),
    VocabEntry(german: 'lernen', english: 'to learn', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Wir lernen Deutsch.'),
    VocabEntry(german: 'wohnen', english: 'to live / reside', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Sie wohnt in Berlin.'),
    VocabEntry(german: 'kochen', english: 'to cook', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Sie kocht jeden Tag.'),
    VocabEntry(german: 'jeden Tag', english: 'every day', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Er arbeitet jeden Tag.'),
  ],
  'u2_l4': [
    VocabEntry(german: 'gerne', english: 'gladly / like to', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Ich lese gerne.'),
    VocabEntry(german: 'lesen', english: 'to read', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich lese gerne Bücher.'),
    VocabEntry(german: 'der Fußball', english: 'football / soccer', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Er spielt gerne Fußball.'),
    VocabEntry(german: 'Tennis spielen', english: 'to play tennis', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Er spielt gerne Tennis.'),
    VocabEntry(german: 'Was machst du gerne?', english: 'What do you like to do?', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Was machst du gerne? — Ich spiele gerne Gitarre.'),
  ],
  'u2_l5': [
    VocabEntry(german: 'alt', english: 'old', gender: '—', partOfSpeech: 'adjective', exampleSentence: 'Ich bin 20 Jahre alt.'),
    VocabEntry(german: 'das Jahr', english: 'year', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Ich bin 25 Jahre alt.'),
    VocabEntry(german: 'vorstellen', english: 'to introduce', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Darf ich mich vorstellen?'),
    VocabEntry(german: 'ich bin ... Jahre alt', english: 'I am ... years old', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Ich bin zwanzig Jahre alt.'),
    VocabEntry(german: 'zwei', english: 'two', gender: '—', partOfSpeech: 'numeral', exampleSentence: 'Ich habe zwei Brüder.'),
  ],
  'u3_l1': [
    VocabEntry(german: 'der Kaffee', english: 'coffee', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Der Kaffee ist sehr gut.'),
    VocabEntry(german: 'der Tee', english: 'tea', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Ich trinke gerne Tee.'),
    VocabEntry(german: 'das Brot', english: 'bread', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Das Brot ist frisch.'),
    VocabEntry(german: 'das Wasser', english: 'water', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Das Wasser ist kalt.'),
    VocabEntry(german: 'der Kuchen', english: 'cake', gender: 'der', partOfSpeech: 'noun', exampleSentence: 'Ich esse gerne Kuchen.'),
    VocabEntry(german: 'trinken', english: 'to drink', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich trinke Kaffee.'),
    VocabEntry(german: 'essen', english: 'to eat', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Er isst gerne Brot.'),
  ],
  'u3_l2': [
    VocabEntry(german: 'mögen', english: 'to like', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich mag Schokolade.'),
    VocabEntry(german: 'die Schokolade', english: 'chocolate', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Magst du Schokolade?'),
    VocabEntry(german: 'mag', english: 'like (ich / er form of mögen)', gender: '—', partOfSpeech: 'verb form', exampleSentence: 'Ich mag Kaffee sehr.'),
    VocabEntry(german: 'nicht mögen', english: 'to not like', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Ich mag Tee nicht.'),
    VocabEntry(german: 'Magst du?', english: 'Do you like? (informal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Magst du Kuchen?'),
  ],
  'u3_l3': [
    VocabEntry(german: 'möchten', english: 'would like', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich möchte einen Kaffee.'),
    VocabEntry(german: 'die Rechnung', english: 'bill / check', gender: 'die', partOfSpeech: 'noun', exampleSentence: 'Die Rechnung, bitte.'),
    VocabEntry(german: 'das Stück', english: 'piece', gender: 'das', partOfSpeech: 'noun', exampleSentence: 'Ein Stück Kuchen, bitte.'),
    VocabEntry(german: 'Was möchten Sie?', english: 'What would you like? (formal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Was möchten Sie? — Einen Tee, bitte.'),
    VocabEntry(german: 'Ich möchte...', english: 'I would like...', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Ich möchte ein Stück Kuchen.'),
  ],
  'u3_l4': [
    VocabEntry(german: 'können', english: 'can / to be able to', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Ich kann Deutsch sprechen.'),
    VocabEntry(german: 'müssen', english: 'must / to have to', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Du musst jetzt bezahlen.'),
    VocabEntry(german: 'bezahlen', english: 'to pay', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Du musst jetzt bezahlen.'),
    VocabEntry(german: 'jetzt', english: 'now', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Du musst jetzt gehen.'),
    VocabEntry(german: 'morgen', english: 'tomorrow', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Wir müssen morgen früh aufstehen.'),
  ],
  'u3_l5': [
    VocabEntry(german: 'helfen', english: 'to help', gender: '—', partOfSpeech: 'verb', exampleSentence: 'Kann ich Ihnen helfen?'),
    VocabEntry(german: 'leider', english: 'unfortunately', gender: '—', partOfSpeech: 'adverb', exampleSentence: 'Ich kann leider nicht kommen.'),
    VocabEntry(german: 'sehr gut', english: 'very good', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Der Kaffee ist sehr gut.'),
    VocabEntry(german: 'Kann ich Ihnen helfen?', english: 'Can I help you? (formal)', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Kann ich Ihnen helfen? — Ja, bitte!'),
    VocabEntry(german: 'ein Stück Kuchen', english: 'a piece of cake', gender: '—', partOfSpeech: 'phrase', exampleSentence: 'Ich möchte ein Stück Kuchen.'),
  ],
};
