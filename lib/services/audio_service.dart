import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'audio_player_stub.dart'
    if (dart.library.html) 'audio_player_web.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final Map<String, Uint8List> _cache = {};
  bool _stopRequested = false;

  static const _proxyBase = 'https://koala-proxy.koala-proxy.workers.dev';

  Future<void> speak(String text, {String langCode = 'de'}) async {
    _stopRequested = false;
    await stopPlayback();

    final bytes = await _fetchAudio(text, langCode);
    if (bytes == null || _stopRequested) return;

    await playBytes(bytes);
  }

  Future<void> prefetch(List<String> texts, {String langCode = 'de'}) async {
    await Future.wait(texts.map((t) => _fetchAudio(t, langCode)));
  }

  Future<void> stop() async {
    _stopRequested = true;
    await stopPlayback();
  }

  Future<Uint8List?> _fetchAudio(String text, String langCode) async {
    final key = '$langCode|$text';
    if (_cache.containsKey(key)) return _cache[key];

    try {
      final res = await http.post(
        Uri.parse('$_proxyBase/tts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text, 'lang': langCode}),
      ).timeout(const Duration(seconds: 12));

      if (res.statusCode == 200) {
        _cache[key] = res.bodyBytes;
        return res.bodyBytes;
      }
    } catch (_) {}
    return null;
  }
}
