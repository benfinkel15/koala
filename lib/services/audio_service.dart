import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  final Map<String, Uint8List> _cache = {};
  bool _stopRequested = false;

  static const _proxyBase = 'https://koala-proxy.koala-proxy.workers.dev';

  Future<void> speak(String text, {String langCode = 'de'}) async {
    _stopRequested = false;
    await _player.stop();

    final bytes = await _fetchAudio(text, langCode);
    if (bytes == null || _stopRequested) return;

    try {
      final base64Audio = base64Encode(bytes);
      final uri = Uri.parse('data:audio/mpeg;base64,$base64Audio');
      await _player.setAudioSource(AudioSource.uri(uri));
      await _player.play();
    } catch (_) {}
  }

  Future<void> stop() async {
    _stopRequested = true;
    await _player.stop();
  }

  bool get isPlaying => _player.playing;

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
