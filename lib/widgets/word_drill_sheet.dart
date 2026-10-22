import 'package:flutter/material.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/services/audio_service.dart';
import 'package:koala/services/word_explainer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Phase { loading, explanation, drill, result }

class WordDrillSheet extends StatefulWidget {
  final String word;
  final String sentence;
  final String langCode;

  const WordDrillSheet({
    super.key,
    required this.word,
    required this.sentence,
    this.langCode = 'de',
  });

  static Future<void> show(
    BuildContext context,
    String word,
    String sentence, {
    String langCode = 'de',
  }) {
    AudioService().speak(word, langCode: langCode);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) =>
          WordDrillSheet(word: word, sentence: sentence, langCode: langCode),
    );
  }

  @override
  State<WordDrillSheet> createState() => _WordDrillSheetState();
}

class _WordDrillSheetState extends State<WordDrillSheet> {
  _Phase _phase = _Phase.loading;
  WordExplanation? _explanation;
  String? _errorMsg;

  final _answer = TextEditingController();
  bool? _correct;

  String get _blankSentence {
    final pattern = RegExp(RegExp.escape(widget.word), caseSensitive: false);
    return widget.sentence.replaceFirst(pattern, '___');
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _answer.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final result = await WordExplainerService.explain(
        widget.word,
        widget.sentence,
        langCode: widget.langCode,
      );
      if (mounted) setState(() { _explanation = result; _phase = _Phase.explanation; });
    } catch (e) {
      if (mounted) setState(() { _errorMsg = e.toString().replaceFirst('Exception: ', ''); _phase = _Phase.explanation; });
    }
  }

  Future<void> _showKeyDialog() async {
    final controller = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Anthropic API Key'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'sk-ant-...', labelText: 'API Key'),
          obscureText: true,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final key = controller.text.trim();
              if (key.isEmpty) return;
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('anthropic_api_key', key);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (!mounted) return;
    setState(() { _phase = _Phase.loading; _errorMsg = null; });
    _load();
  }

  void _check() {
    final correct =
        _answer.text.trim().toLowerCase() == widget.word.toLowerCase();
    setState(() { _correct = correct; _phase = _Phase.result; });
    if (correct) AudioService().speak(widget.word, langCode: widget.langCode);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildPhase(),
      ),
    );
  }

  Widget _buildPhase() {
    switch (_phase) {
      case _Phase.loading:
        return const SizedBox(
          key: ValueKey('loading'),
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        );
      case _Phase.explanation:
        return _buildExplanation();
      case _Phase.drill:
        return _buildDrill();
      case _Phase.result:
        return _buildResult();
    }
  }

  Widget _buildExplanation() {
    return Column(
      key: const ValueKey('explanation'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.word,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.volume_up, color: AppColors.primary),
              onPressed: () =>
                  AudioService().speak(widget.word, langCode: widget.langCode),
            ),
          ],
        ),
        if (_errorMsg != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.incorrect.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.incorrect.withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_errorMsg!, style: const TextStyle(fontSize: 13)),
                if (_errorMsg!.contains('key') || _errorMsg!.contains('401') || _errorMsg!.contains('403')) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _showKeyDialog,
                      icon: const Icon(Icons.key, size: 18),
                      label: const Text('Update API key'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ] else if (_explanation == null) ...[
          const SizedBox(height: 8),
          const Text('Could not load explanation.'),
        ] else ...[
          _InfoRow(
              label: 'Meaning',
              value: _explanation!.translation,
              valueStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          _InfoRow(label: 'Type', value: _explanation!.partOfSpeech),
          const SizedBox(height: 8),
          _InfoRow(label: 'Grammar', value: _explanation!.note),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _phase = _Phase.drill),
            icon: const Icon(Icons.fitness_center, size: 18),
            label: const Text('Practice this word'),
          ),
        ),
      ],
    );
  }

  Widget _buildDrill() {
    return Column(
      key: const ValueKey('drill'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fill in the blank',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 4),
        Text('Type the missing word',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _blankSentence,
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _answer,
          autofocus: true,
          onSubmitted: (_) => _check(),
          decoration: const InputDecoration(
            hintText: 'Type your answer…',
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _check,
            child: const Text('Check',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildResult() {
    final correct = _correct == true;
    return Column(
      key: const ValueKey('result'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
                correct ? Icons.check_circle : Icons.cancel,
                color: correct ? AppColors.correct : AppColors.incorrect,
                size: 32),
            const SizedBox(width: 12),
            Text(correct ? 'Correct!' : 'Not quite!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: correct ? AppColors.correct : AppColors.incorrect)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: correct
                ? AppColors.correct.withValues(alpha: 0.08)
                : AppColors.incorrect.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.sentence,
                  style: const TextStyle(fontSize: 16, height: 1.5)),
              if (!correct) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('Answer: ${widget.word}',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _answer.clear();
                  setState(() { _correct = null; _phase = _Phase.drill; });
                },
                icon: const Icon(Icons.replay, size: 18),
                label: const Text('Try again'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Resume'),
              ),
            ),
          ],
        ),
      ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
          Expanded(
              child:
                  Text(value, style: valueStyle ?? const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
