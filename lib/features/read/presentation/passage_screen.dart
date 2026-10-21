import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:koala/content/german/passages.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/services/audio_service.dart';
import 'package:koala/services/word_explainer_service.dart';

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

  @override
  void initState() {
    super.initState();
    try {
      _passage = germanPassages.firstWhere((p) => p.id == widget.passageId);
    } catch (_) {}
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('de-DE');
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
            Text(passage.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(passage.topic, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
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
    AudioService().speak(word);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _WordSheet(word: word, sentence: sentence),
    );
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
        color: isActive ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? AppColors.primary.withValues(alpha: 0.3) : Colors.transparent,
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
                decoration: clean.isNotEmpty ? TextDecoration.underline : null,
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

// ─── Word Explanation Sheet ────────────────────────────────────────────────

class _WordSheet extends StatefulWidget {
  final String word;
  final String sentence;
  const _WordSheet({required this.word, required this.sentence});

  @override
  State<_WordSheet> createState() => _WordSheetState();
}

class _WordSheetState extends State<_WordSheet> {
  WordExplanation? _explanation;
  bool _loading = true;
  bool _noKey = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final key = await WordExplainerService.getApiKey();
    if (key == null || key.isEmpty) {
      if (mounted) setState(() { _loading = false; _noKey = true; });
      return;
    }
    final result = await WordExplainerService.explain(widget.word, widget.sentence);
    if (mounted) setState(() { _explanation = result; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.word,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.volume_up, color: AppColors.primary),
                onPressed: () => AudioService().speak(widget.word),
              ),
            ],
          ),
          Text(
            '"${widget.sentence}"',
            style: TextStyle(
                color: AppColors.textSecondary, fontSize: 13, fontStyle: FontStyle.italic),
          ),
          const Divider(height: 24),
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_noKey)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Enter your Anthropic API key in the scenario chat to enable word explanations.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          else if (_explanation == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text('Could not load explanation.'),
            )
          else ...[
            _InfoRow(label: 'Translation', value: _explanation!.translation, valueStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _InfoRow(label: 'Type', value: _explanation!.partOfSpeech),
            const SizedBox(height: 12),
            _InfoRow(label: 'Grammar', value: _explanation!.note),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;
  const _InfoRow({required this.label, required this.value, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value, style: valueStyle ?? const TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}
