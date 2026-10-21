import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WordExplanation {
  final String word;
  final String translation;
  final String partOfSpeech;
  final String note;

  const WordExplanation({
    required this.word,
    required this.translation,
    required this.partOfSpeech,
    required this.note,
  });
}

class WordExplainerService {
  static Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('anthropic_api_key');
  }

  static Future<WordExplanation?> explain(
    String word,
    String sentence, {
    String langCode = 'de',
  }) async {
    final apiKey = await getApiKey();
    if (apiKey == null || apiKey.isEmpty) return null;

    final clean = word.replaceAll(RegExp(r'[.,!?;:"""„]'), '');
    if (clean.isEmpty) return null;

    final langName = langCode == 'nl' ? 'Dutch' : 'German';

    try {
      final response = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'x-api-key': apiKey,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': 'claude-haiku-4-5-20251001',
          'max_tokens': 200,
          'system':
              'You are a concise $langName language tutor. Given a $langName word and its sentence context, respond ONLY with valid JSON (no markdown, no explanation): {"translation":"English meaning","type":"noun|verb|adjective|adverb|preposition|conjunction|other","note":"one clear sentence about grammar or usage"}',
          'messages': [
            {
              'role': 'user',
              'content': 'Word: $clean\nSentence: $sentence',
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final text = (data['content'] as List).first['text'] as String;
        final json = jsonDecode(text) as Map<String, dynamic>;
        return WordExplanation(
          word: clean,
          translation: json['translation'] as String,
          partOfSpeech: json['type'] as String,
          note: json['note'] as String,
        );
      }
    } catch (_) {}
    return null;
  }
}
