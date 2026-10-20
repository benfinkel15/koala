import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
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
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      },
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
  ];
}
