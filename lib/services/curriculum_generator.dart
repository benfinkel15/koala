import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:koala/content/danish/curriculum.dart';
import 'package:koala/content/dutch/curriculum.dart';
import 'package:koala/content/german/curriculum.dart';

class LanguageInfo {
  final String code;
  final String name;
  final String nativeName;

  const LanguageInfo({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

const supportedLanguages = [
  LanguageInfo(code: 'de', name: 'German', nativeName: 'Deutsch'),
  LanguageInfo(code: 'nl', name: 'Dutch', nativeName: 'Nederlands'),
  LanguageInfo(code: 'da', name: 'Danish', nativeName: 'Dansk'),
  LanguageInfo(code: 'es', name: 'Spanish', nativeName: 'Español'),
  LanguageInfo(code: 'fr', name: 'French', nativeName: 'Français'),
  LanguageInfo(code: 'it', name: 'Italian', nativeName: 'Italiano'),
  LanguageInfo(code: 'ja', name: 'Japanese', nativeName: '日本語'),
];

class CurriculumUnit {
  final String id;
  final String title;
  final String description;
  final List<CurriculumLesson> lessons;

  const CurriculumUnit({
    required this.id,
    required this.title,
    required this.description,
    required this.lessons,
  });

  factory CurriculumUnit.fromJson(Map<String, dynamic> json) => CurriculumUnit(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        lessons: (json['lessons'] as List)
            .map((l) => CurriculumLesson.fromJson(l as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'lessons': lessons.map((l) => l.toJson()).toList(),
      };
}

class CurriculumLesson {
  final String id;
  final String title;

  const CurriculumLesson({required this.id, required this.title});

  factory CurriculumLesson.fromJson(Map<String, dynamic> json) =>
      CurriculumLesson(
        id: json['id'] as String,
        title: json['title'] as String,
      );

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}

class CurriculumData {
  final List<CurriculumUnit> units;
  final Map<String, List<Map<String, dynamic>>> exercises;

  const CurriculumData({required this.units, required this.exercises});
}

class CurriculumService {
  static final CurriculumService _instance = CurriculumService._internal();
  factory CurriculumService() => _instance;
  CurriculumService._internal() {
    _loadGerman();
  }

  CurriculumData? _current;
  String _currentCode = 'de';

  String get currentCode => _currentCode;
  CurriculumData? get current => _current;

  void _loadGerman() {
    _currentCode = 'de';
    _current = CurriculumData(units: _germanUnits, exercises: lessonExercises);
  }

  Future<CurriculumData> loadLanguage(
      String code, String name, String apiKey) async {
    if (code == 'de') {
      _loadGerman();
      return _current!;
    }

    if (code == 'nl') {
      _currentCode = 'nl';
      _current = CurriculumData(units: _dutchUnits, exercises: dutchLessonExercises);
      return _current!;
    }

    if (code == 'da') {
      _currentCode = 'da';
      _current = CurriculumData(units: _danishUnits, exercises: danishLessonExercises);
      return _current!;
    }

    final box = await Hive.openBox('curriculum');
    final cached = box.get(code) as String?;
    if (cached != null) {
      try {
        final data = _parseJson(jsonDecode(cached) as Map<String, dynamic>);
        _currentCode = code;
        _current = data;
        return data;
      } catch (_) {
        await box.delete(code);
      }
    }

    final data = await _generate(name, apiKey);
    await box.put(code, jsonEncode(_toJson(data)));
    _currentCode = code;
    _current = data;
    return data;
  }

  Future<CurriculumData> _generate(String name, String apiKey) async {
    final response = await http.post(
      Uri.parse('https://koala-proxy.koala-proxy.workers.dev'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'model': 'claude-sonnet-4-6',
        'max_tokens': 8192,
        'messages': [
          {'role': 'user', 'content': _buildPrompt(name)},
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('API error: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final text = (body['content'] as List).first['text'] as String;

    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (match == null) throw Exception('No JSON found in API response');

    return _parseJson(jsonDecode(match.group(0)!) as Map<String, dynamic>);
  }

  static String _buildPrompt(String name) =>
      'Generate a $name language learning curriculum as JSON with exactly this structure:\n\n'
      '{\n'
      '  "units": [\n'
      '    {\n'
      '      "id": "u1",\n'
      '      "title": "Unit 1 — [Theme]",\n'
      '      "description": "[What learners will say]",\n'
      '      "lessons": [\n'
      '        {"id": "u1_l1", "title": "[Title]"},\n'
      '        {"id": "u1_l2", "title": "[Title]"},\n'
      '        {"id": "u1_l3", "title": "[Title]"},\n'
      '        {"id": "u1_l4", "title": "[Title]"},\n'
      '        {"id": "u1_l5", "title": "[Title]"}\n'
      '      ]\n'
      '    }\n'
      '  ],\n'
      '  "exercises": {\n'
      '    "u1_l1": [\n'
      '      {"type":"multipleChoice","prompt":"...","options":["a","b","c","d"],"correct":0},\n'
      '      {"type":"tapToBuild","prompt":"...","target":"...","tiles":["w1","w2","w3","w4","w5"]},\n'
      '      {"type":"fillBlank","sentence":"___ ...","correct":"...","hint":"..."},\n'
      '      {"type":"conjugationTable","verb":"...","tense":"...","pronouns":["p1","p2","p3","p4","p5","p6"],"answers":["a1","a2","a3","a4","a5","a6"]},\n'
      '      {"type":"multipleChoice","prompt":"...","options":["a","b","c","d"],"correct":2}\n'
      '    ]\n'
      '  }\n'
      '}\n\n'
      'Rules:\n'
      '- 3 units, 5 lessons each: u1_l1 through u3_l5 (15 lessons total)\n'
      '- Each lesson has exactly 5 exercises\n'
      '- Use all 4 types: multipleChoice, tapToBuild, fillBlank, conjugationTable\n'
      '- Include at least one conjugationTable exercise per unit\n'
      '- Conversation-first: Unit 1=Greetings, Unit 2=Family & Daily Life, Unit 3=Food & Places\n'
      '- Output ONLY valid JSON, no other text';

  CurriculumData _parseJson(Map<String, dynamic> json) {
    final units = (json['units'] as List)
        .map((u) => CurriculumUnit.fromJson(u as Map<String, dynamic>))
        .toList();
    final exMap = json['exercises'] as Map<String, dynamic>;
    final exercises = exMap.map((k, v) => MapEntry(
          k,
          (v as List)
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList(),
        ));
    return CurriculumData(units: units, exercises: exercises);
  }

  Map<String, dynamic> _toJson(CurriculumData data) => {
        'units': data.units.map((u) => u.toJson()).toList(),
        'exercises': data.exercises,
      };

  static const _germanUnits = [
    CurriculumUnit(
      id: 'u1',
      title: 'Unit 1 — Greetings & Introductions',
      description: "Say hello, introduce yourself, say where you're from",
      lessons: [
        CurriculumLesson(id: 'u1_l1', title: 'Hello and Goodbye'),
        CurriculumLesson(id: 'u1_l2', title: 'My Name Is…'),
        CurriculumLesson(id: 'u1_l3', title: 'The verb "sein" (to be)'),
        CurriculumLesson(id: 'u1_l4', title: 'Where Are You From?'),
        CurriculumLesson(id: 'u1_l5', title: 'First Conversation'),
      ],
    ),
    CurriculumUnit(
      id: 'u2',
      title: 'Unit 2 — Family & Hobbies',
      description: 'Talk about family, hobbies, and regular verbs',
      lessons: [
        CurriculumLesson(id: 'u2_l1', title: 'The verb "haben" (to have)'),
        CurriculumLesson(id: 'u2_l2', title: 'Family Members'),
        CurriculumLesson(id: 'u2_l3', title: 'Regular -en Verbs'),
        CurriculumLesson(id: 'u2_l4', title: 'Hobbies'),
        CurriculumLesson(id: 'u2_l5', title: 'Full Self-Introduction'),
      ],
    ),
    CurriculumUnit(
      id: 'u3',
      title: 'Unit 3 — Food & Café',
      description: 'Order food, express preferences, use modal verbs',
      lessons: [
        CurriculumLesson(id: 'u3_l1', title: 'Food and Drink Vocabulary'),
        CurriculumLesson(id: 'u3_l2', title: 'mögen — Expressing Preferences'),
        CurriculumLesson(id: 'u3_l3', title: 'Ordering at a Café'),
        CurriculumLesson(id: 'u3_l4', title: 'können and müssen'),
        CurriculumLesson(id: 'u3_l5', title: 'At the Café — Full Interaction'),
      ],
    ),
    CurriculumUnit(
      id: 'u4',
      title: 'Unit 4 — Directions & Getting Around',
      description: 'Count, ask for directions, use transport, navigate the city',
      lessons: [
        CurriculumLesson(id: 'u4_l1', title: 'Numbers 1–20'),
        CurriculumLesson(id: 'u4_l2', title: 'Left, Right, Straight Ahead'),
        CurriculumLesson(id: 'u4_l3', title: 'Transport — Bus, Train, Car'),
        CurriculumLesson(id: 'u4_l4', title: 'Prepositions of Place'),
        CurriculumLesson(id: 'u4_l5', title: 'Getting Around — Full Conversation'),
      ],
    ),
    CurriculumUnit(
      id: 'u5',
      title: 'Unit 5 — Daily Life & Time',
      description: 'Tell the time, talk about routines, make plans',
      lessons: [
        CurriculumLesson(id: 'u5_l1', title: 'Telling the Time'),
        CurriculumLesson(id: 'u5_l2', title: 'Daily Routine'),
        CurriculumLesson(id: 'u5_l3', title: 'Separable Verbs'),
        CurriculumLesson(id: 'u5_l4', title: 'Days & Months'),
        CurriculumLesson(id: 'u5_l5', title: 'Making Plans — Full Conversation'),
      ],
    ),
  ];

  static const _danishUnits = [
    CurriculumUnit(
      id: 'da_u1',
      title: 'Unit 1 — Hej og farvel',
      description: 'Say hello, introduce yourself, say where you\'re from',
      lessons: [
        CurriculumLesson(id: 'da_u1_l1', title: 'Hello and Goodbye'),
        CurriculumLesson(id: 'da_u1_l2', title: 'My Name Is…'),
        CurriculumLesson(id: 'da_u1_l3', title: 'The verb "at være" (to be)'),
        CurriculumLesson(id: 'da_u1_l4', title: 'Where Are You From?'),
        CurriculumLesson(id: 'da_u1_l5', title: 'First Conversation'),
      ],
    ),
    CurriculumUnit(
      id: 'da_u2',
      title: 'Unit 2 — Familie & Fritid',
      description: 'Talk about family, hobbies, and regular verbs',
      lessons: [
        CurriculumLesson(id: 'da_u2_l1', title: 'The verb "at have" (to have)'),
        CurriculumLesson(id: 'da_u2_l2', title: 'Family Members'),
        CurriculumLesson(id: 'da_u2_l3', title: 'Regular -er Verbs'),
        CurriculumLesson(id: 'da_u2_l4', title: 'Hobbies'),
        CurriculumLesson(id: 'da_u2_l5', title: 'Full Self-Introduction'),
      ],
    ),
    CurriculumUnit(
      id: 'da_u3',
      title: 'Unit 3 — Mad & Café',
      description: 'Order food, express preferences, use modal verbs',
      lessons: [
        CurriculumLesson(id: 'da_u3_l1', title: 'Food and Drink Vocabulary'),
        CurriculumLesson(id: 'da_u3_l2', title: 'Kan godt lide — Expressing Preferences'),
        CurriculumLesson(id: 'da_u3_l3', title: 'Ordering at a Café'),
        CurriculumLesson(id: 'da_u3_l4', title: 'kan and skal'),
        CurriculumLesson(id: 'da_u3_l5', title: 'At the Café — Full Interaction'),
      ],
    ),
    CurriculumUnit(
      id: 'da_u4',
      title: 'Unit 4 — Vej & Transport',
      description: 'Count, ask for directions, use transport, navigate the city',
      lessons: [
        CurriculumLesson(id: 'da_u4_l1', title: 'Numbers 1–20'),
        CurriculumLesson(id: 'da_u4_l2', title: 'Left, Right, Straight Ahead'),
        CurriculumLesson(id: 'da_u4_l3', title: 'Transport — Bus, Train, Bike'),
        CurriculumLesson(id: 'da_u4_l4', title: 'Prepositions of Place'),
        CurriculumLesson(id: 'da_u4_l5', title: 'Getting Around — Full Conversation'),
      ],
    ),
    CurriculumUnit(
      id: 'da_u5',
      title: 'Unit 5 — Hverdag & Tid',
      description: 'Tell the time, talk about routines, make plans',
      lessons: [
        CurriculumLesson(id: 'da_u5_l1', title: 'Telling the Time'),
        CurriculumLesson(id: 'da_u5_l2', title: 'Daily Routine'),
        CurriculumLesson(id: 'da_u5_l3', title: 'Particle Verbs'),
        CurriculumLesson(id: 'da_u5_l4', title: 'Days & Months'),
        CurriculumLesson(id: 'da_u5_l5', title: 'Making Plans — Full Conversation'),
      ],
    ),
  ];

  static const _dutchUnits = [
    CurriculumUnit(
      id: 'nl_u1',
      title: 'Unit 1 — Groeten & Kennismaken',
      description: 'Zeg hallo, stel jezelf voor, zeg waar je vandaan komt',
      lessons: [
        CurriculumLesson(id: 'nl_u1_l1', title: 'Hallo en doei'),
        CurriculumLesson(id: 'nl_u1_l2', title: 'Mijn naam is…'),
        CurriculumLesson(id: 'nl_u1_l3', title: 'Het werkwoord "zijn"'),
        CurriculumLesson(id: 'nl_u1_l4', title: 'Waar kom je vandaan?'),
        CurriculumLesson(id: 'nl_u1_l5', title: 'Eerste gesprek'),
      ],
    ),
    CurriculumUnit(
      id: 'nl_u2',
      title: 'Unit 2 — Familie & Hobby\'s',
      description: 'Praat over familie, hobby\'s en gewone werkwoorden',
      lessons: [
        CurriculumLesson(id: 'nl_u2_l1', title: 'Het werkwoord "hebben"'),
        CurriculumLesson(id: 'nl_u2_l2', title: 'Familieleden'),
        CurriculumLesson(id: 'nl_u2_l3', title: 'Regelmatige -en werkwoorden'),
        CurriculumLesson(id: 'nl_u2_l4', title: 'Hobby\'s'),
        CurriculumLesson(id: 'nl_u2_l5', title: 'Volledige zelfintroductie'),
      ],
    ),
    CurriculumUnit(
      id: 'nl_u3',
      title: 'Unit 3 — Eten & Café',
      description: 'Bestel eten, druk voorkeuren uit, gebruik modale werkwoorden',
      lessons: [
        CurriculumLesson(id: 'nl_u3_l1', title: 'Eten en drinken'),
        CurriculumLesson(id: 'nl_u3_l2', title: 'Lekker vinden — Voorkeuren uitdrukken'),
        CurriculumLesson(id: 'nl_u3_l3', title: 'Bestellen in een café'),
        CurriculumLesson(id: 'nl_u3_l4', title: 'kunnen en moeten'),
        CurriculumLesson(id: 'nl_u3_l5', title: 'In het café — Volledig gesprek'),
      ],
    ),
    CurriculumUnit(
      id: 'nl_u4',
      title: 'Unit 4 — Richtingen & Vervoer',
      description: 'Tel, vraag de weg, gebruik vervoer, navigeer de stad',
      lessons: [
        CurriculumLesson(id: 'nl_u4_l1', title: 'Nummers 1–20'),
        CurriculumLesson(id: 'nl_u4_l2', title: 'Links, rechts, rechtdoor'),
        CurriculumLesson(id: 'nl_u4_l3', title: 'Vervoer — Bus, trein, fiets'),
        CurriculumLesson(id: 'nl_u4_l4', title: 'Plaatsvoorzetsels'),
        CurriculumLesson(id: 'nl_u4_l5', title: 'Rondkomen — Volledig gesprek'),
      ],
    ),
    CurriculumUnit(
      id: 'nl_u5',
      title: 'Unit 5 — Dagelijks Leven & Tijd',
      description: 'Vertel de tijd, praat over routines, maak plannen',
      lessons: [
        CurriculumLesson(id: 'nl_u5_l1', title: 'Hoe laat is het?'),
        CurriculumLesson(id: 'nl_u5_l2', title: 'Dagelijkse routine'),
        CurriculumLesson(id: 'nl_u5_l3', title: 'Scheidbare werkwoorden'),
        CurriculumLesson(id: 'nl_u5_l4', title: 'Dagen & Maanden'),
        CurriculumLesson(id: 'nl_u5_l5', title: 'Plannen maken — Volledig gesprek'),
      ],
    ),
  ];
}
