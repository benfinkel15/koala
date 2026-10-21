import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text, {String langCode = 'de'}) async {
    final locale = langCode == 'nl' ? 'nl-NL' : langCode == 'da' ? 'da-DK' : 'de-DE';
    await _tts.stop();
    await _tts.setLanguage(locale);
    await _tts.setSpeechRate(0.75);
    await _tts.setVolume(1.0);
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
