import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:koala/content/danish/passages.dart';
import 'package:koala/content/dutch/passages.dart';
import 'package:koala/content/german/passages.dart';
import 'package:koala/content/indonesian/passages.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/widgets/word_drill_sheet.dart';

class PassageScreen extends StatefulWidget {
  final String passageId;
  const PassageScreen({super.key, required this.passageId});

  @override
  State<PassageScreen> createState() => _PassageScreenState();
}

class _PassageScreenState extends State<PassageScreen> {
  GermanPassage? _passage;
  final FlutterTts _tts = FlutterTts();
  bool _playing = false;
  int _currentSentence = -1;

  String get _ttsLocale => _passage?.language == 'nl' ? 'nl-NL' : _passage?.language == 'da' ? 'da-DK' : _passage?.language == 'id' ? 'id-ID' : 'de-DE';
  String get _langCode => _passage?.language ?? 'de';

  @override
  void initState() {
    super.initState();
    try {
      _passage = [...germanPassages, ...dutchPassages, ...danishPassages, ...indonesianPassages]
          .firstWhere((p) => p.id == widget.passageId);
    } catch (_) {}
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage(_ttsLocale);
    await _tts.setSpeechRate(0.72);
    await _tts.setVolume(1.0);
    _tts.setCompletionHandler(() {
      if (!mounted) return;
      final next = _currentSentence + 1;
      if (next < (_passage?.sentences.length ?? 0)) {
        setState(() => _currentSentence = next);
        _tts.speak(_passage!.sentences[next]);
      } else {
        setState(() { _playing = false; _currentSentence = -1; });
      }
    });
  }

  Future<void> _togglePlay() async {
    if (_playing) {
      await _tts.stop();
      setState(() { _playing = false; _currentSentence = -1; });
    } else {
      if (_passage == null) return;
      await _tts.setLanguage(_ttsLocale);
      setState(() { _playing = true; _currentSentence = 0; });
      await _tts.speak(_passage!.sentences[0]);
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passage = _passage;
    if (passage == null) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text('Passage not found')));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(passage.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(passage.topic,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(_playing ? Icons.stop_circle : Icons.play_circle,
                  color: AppColors.primary, size: 32),
              onPressed: _togglePlay,
              tooltip: _playing ? 'Stop' : 'Read aloud',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.touch_app, size: 14, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text('Tap any word for translation and grammar',
                      style: TextStyle(color: AppColors.primary, fontSize: 13)),
                ],
              ),
            ),
            ...passage.sentences.asMap().entries.map((e) {
              final i = e.key;
              final sentence = e.value;
              final isActive = _currentSentence == i;
              return _SentenceBlock(
                sentence: sentence,
                isActive: isActive,
                onWordTap: (word) => _showWordSheet(context, word, sentence),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showWordSheet(BuildContext context, String word, String sentence) {
    WordDrillSheet.show(context, word, sentence, langCode: _langCode);
  }
}

// ─── Sentence Block ────────────────────────────────────────────────────────

class _SentenceBlock extends StatelessWidget {
  final String sentence;
  final bool isActive;
  final void Function(String) onWordTap;

  const _SentenceBlock({
    required this.sentence,
    required this.isActive,
    required this.onWordTap,
  });

  @override
  Widget build(BuildContext context) {
    final words = sentence.split(' ');
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color:
            isActive ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: Wrap(
        spacing: 0,
        runSpacing: 4,
        children: words.map((word) {
          final clean = word.replaceAll(RegExp(r'[.,!?;:"""„]'), '');
          return GestureDetector(
            onTap: clean.isEmpty ? null : () => onWordTap(clean),
            child: Text(
              '$word ',
              style: TextStyle(
                fontSize: 18,
                height: 1.7,
                color: isActive ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                decoration:
                    clean.isNotEmpty ? TextDecoration.underline : null,
                decorationColor: Colors.grey[300],
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
