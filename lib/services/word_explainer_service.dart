import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koala/services/usage_tracker.dart';

const _proxyUrl = 'https://koala-proxy.koala-proxy.workers.dev';

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
  static Future<WordExplanation> explain(
    String word,
    String sentence, {
    String langCode = 'de',
  }) async {
    if (await UsageTracker.isOverLimit()) {
      throw Exception('Monthly \$1 usage limit reached — resets on the 1st.');
    }

    final clean = word.replaceAll(RegExp(r'[.,!?;:"""„]'), '');
    if (clean.isEmpty) throw Exception('Word is empty after cleaning punctuation.');

    final langName = langCode == 'nl' ? 'Dutch' : langCode == 'da' ? 'Danish' : 'German';

    final http.Response response;
    try {
      response = await http.post(
        Uri.parse(_proxyUrl),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'model': 'claude-haiku-4-5-20251001',
          'max_tokens': 200,
          'system':
              'You are a concise $langName language tutor. Given a $langName word and its sentence context, respond ONLY with valid JSON (no markdown, no explanation): {"translation":"English meaning","type":"noun|verb|adjective|adverb|preposition|conjunction|other","note":"one clear sentence about grammar or usage"}',
          'messages': [
            {'role': 'user', 'content': 'Word: $clean\nSentence: $sentence'},
          ],
        }),
      );
    } catch (e) {
      throw Exception('Network error: $e');
    }

    if (response.statusCode != 200) {
      final body = response.body.length > 300
          ? '${response.body.substring(0, 300)}…'
          : response.body;
      throw Exception('API ${response.statusCode}: $body');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final usage = data['usage'] as Map<String, dynamic>?;
    if (usage != null) {
      await UsageTracker.record(
        (usage['input_tokens'] as int? ?? 0),
        (usage['output_tokens'] as int? ?? 0),
      );
    }
    final text = (data['content'] as List).first['text'] as String;
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (match == null) throw Exception('Unexpected response format: $text');
    final json = jsonDecode(match.group(0)!) as Map<String, dynamic>;
    return WordExplanation(
      word: clean,
      translation: json['translation'] as String,
      partOfSpeech: json['type'] as String,
      note: json['note'] as String,
    );
  }
}
