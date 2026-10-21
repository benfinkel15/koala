class GermanPassage {
  final String id;
  final String title;
  final String level;
  final String topic;
  final List<String> sentences;

  const GermanPassage({
    required this.id,
    required this.title,
    required this.level,
    required this.topic,
    required this.sentences,
  });

  String get fullText => sentences.join(' ');
}

const List<GermanPassage> germanPassages = [
  GermanPassage(
    id: 'p1',
    title: 'Mein Morgen',
    level: 'Beginner',
    topic: 'Daily Life',
    sentences: [
      'Ich heiße Anna und ich wohne in Berlin.',
      'Jeden Morgen stehe ich um sieben Uhr auf.',
      'Zuerst trinke ich einen Kaffee.',
      'Dann esse ich ein Brötchen mit Butter und Marmelade.',
      'Um acht Uhr fahre ich mit der U-Bahn zur Arbeit.',
      'Die Fahrt dauert ungefähr zwanzig Minuten.',
      'Am Abend koche ich gerne.',
      'Ich mag Pasta, Salat und Suppe.',
      'Um elf Uhr gehe ich schlafen.',
      'Morgen fange ich wieder von vorne an.',
    ],
  ),
  GermanPassage(
    id: 'p2',
    title: 'Im Café',
    level: 'Beginner',
    topic: 'Food & Drink',
    sentences: [
      'Heute gehe ich ins Café.',
      'Das Café heißt „Zum alten Markt" und liegt in der Stadtmitte.',
      'Ich setze mich an einen Tisch am Fenster.',
      'Der Kellner kommt und fragt: „Was möchten Sie?"',
      'Ich sage: „Einen Cappuccino und ein Stück Schokoladenkuchen, bitte."',
      'Der Kuchen ist frisch gebacken und schmeckt sehr gut.',
      'Der Cappuccino ist heiß und cremig.',
      'Ich lese ein Buch und genieße den ruhigen Nachmittag.',
      'Später kommt die Rechnung.',
      'Es kostet fünf Euro fünfzig.',
    ],
  ),
  GermanPassage(
    id: 'p3',
    title: 'Berlin',
    level: 'Intermediate',
    topic: 'Culture & Places',
    sentences: [
      'Berlin ist die Hauptstadt von Deutschland.',
      'Über drei Millionen Menschen leben in dieser lebendigen Stadt.',
      'Die Stadt hat viele berühmte Sehenswürdigkeiten.',
      'Das Brandenburger Tor ist das bekannteste Symbol Berlins.',
      'Früher war die Stadt durch eine Mauer geteilt.',
      'Die Berliner Mauer stand von 1961 bis 1989.',
      'Nach dem Fall der Mauer wurde die Stadt wiedervereint.',
      'Heute ist Berlin eine moderne, kreative und weltoffene Metropole.',
      'Jedes Jahr besuchen Millionen von Touristen die Stadt.',
      'Die Museen, Parks und Restaurants sind weltberühmt.',
    ],
  ),
  GermanPassage(
    id: 'p4',
    title: 'Das Wochenende',
    level: 'Intermediate',
    topic: 'Hobbies & Leisure',
    sentences: [
      'Letztes Wochenende habe ich viel gemacht.',
      'Am Samstag bin ich mit meiner Freundin auf den Markt gegangen.',
      'Wir haben frisches Gemüse, Obst und Käse gekauft.',
      'Das Wetter war sonnig und angenehm warm.',
      'Zu Mittag haben wir zusammen eine Gemüsesuppe gekocht.',
      'Am Nachmittag haben wir einen deutschen Film geschaut.',
      'Der Film war sehr interessant und ein bisschen traurig.',
      'Am Sonntag bin ich zu Hause geblieben.',
      'Ich habe Bücher gelesen und entspannende Musik gehört.',
      'Das war ein perfektes Wochenende.',
    ],
  ),
  GermanPassage(
    id: 'p5',
    title: 'Eine Reise nach München',
    level: 'Advanced',
    topic: 'Travel',
    sentences: [
      'Im letzten Sommer bin ich mit dem Zug nach München gefahren.',
      'Die Stadt liegt im Süden Deutschlands, mitten in Bayern.',
      'München ist bekannt für das Oktoberfest, das weltgrößte Volksfest.',
      'Ich habe das Deutsche Museum besucht, das größte Technikmuseum der Welt.',
      'Im Englischen Garten habe ich die Surfer gesehen, die auf der Isar reiten.',
      'In einem traditionellen Biergarten habe ich Weißwurst und Brezel gegessen.',
      'Die bayerische Küche ist reichhaltig, deftig und wirklich lecker.',
      'Abends bin ich durch die Altstadt geschlendert und habe das Glockenspiel am Marienplatz bewundert.',
      'München hat mich mit seiner Mischung aus Tradition und modernem Leben begeistert.',
      'Ich möchte unbedingt wieder dorthin fahren.',
    ],
  ),
  GermanPassage(
    id: 'p6',
    title: 'Warum Sprachen lernen?',
    level: 'Advanced',
    topic: 'Language & Learning',
    sentences: [
      'Eine neue Sprache zu lernen ist eine der wertvollsten Erfahrungen im Leben.',
      'Es öffnet Türen zu neuen Kulturen, Menschen und Perspektiven.',
      'Viele denken, dass Sprachenlernen sehr schwierig ist.',
      'Aber mit den richtigen Methoden kann jeder eine neue Sprache meistern.',
      'Das Wichtigste ist, die Sprache täglich zu benutzen.',
      'Man sollte so viel wie möglich lesen, hören und sprechen.',
      'Fehler zu machen ist völlig normal und sogar notwendig beim Lernen.',
      'Durch Fehler lernt man oft am schnellsten.',
      'Besonders hilfreich ist es, mit Muttersprachlern zu sprechen.',
      'Geduld, Neugier und Konsequenz sind die Schlüssel zum Erfolg.',
    ],
  ),
];
