part of 'lesson_screen.dart';

// ─── Multiple Choice ───────────────────────────────────────────────────────

class _MultipleChoice extends StatelessWidget {
  final Map<String, dynamic> exercise;
  final String? selectedAnswer;
  final bool answered;
  final void Function(String, bool) onAnswer;

  const _MultipleChoice({
    super.key,
    required this.exercise,
    required this.selectedAnswer,
    required this.answered,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final options = List<String>.from(exercise['options']);
    final correctIndex = exercise['correct'] as int;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose the correct answer',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 12),
        Text(exercise['prompt'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 32),
        ...options.asMap().entries.map((entry) {
          final i = entry.key;
          final option = entry.value;
          Color borderColor = Colors.grey[300]!;
          Color bgColor = Colors.white;

          if (answered) {
            if (i == correctIndex) {
              borderColor = AppColors.correct;
              bgColor = AppColors.correct.withOpacity(0.1);
            } else if (option == selectedAnswer) {
              borderColor = AppColors.incorrect;
              bgColor = AppColors.incorrect.withOpacity(0.1);
            }
          } else if (option == selectedAnswer) {
            borderColor = AppColors.primary;
            bgColor = AppColors.primary.withOpacity(0.05);
          }

          return GestureDetector(
            onTap: answered ? null : () => onAnswer(option, i == correctIndex),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(option,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          );
        }),
      ],
    );
  }
}

// ─── Tap to Build ──────────────────────────────────────────────────────────

class _TapToBuild extends StatefulWidget {
  final Map<String, dynamic> exercise;
  final bool answered;
  final void Function(bool) onAnswer;

  const _TapToBuild(
      {super.key, required this.exercise, required this.answered, required this.onAnswer});

  @override
  State<_TapToBuild> createState() => _TapToBuildState();
}

class _TapToBuildState extends State<_TapToBuild> {
  final List<String> _selected = [];
  late final List<String> _shuffledTiles;

  @override
  void initState() {
    super.initState();
    _shuffledTiles = List<String>.from(widget.exercise['tiles'])..shuffle();
  }

  void _tap(String word) {
    if (widget.answered) return;
    setState(() => _selected.add(word));
    final script = CurriculumService().phoneticToScript(word);
    AudioService().speak(script, langCode: CurriculumService().currentCode);
  }

  void _remove(int i) {
    if (widget.answered) return;
    setState(() => _selected.removeAt(i));
  }

  void _check() {
    String normalize(String s) =>
        s.replaceAll(RegExp(r'[.,!?;:]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
    final answer = _selected.join(' ');
    widget.onAnswer(normalize(answer) == normalize(widget.exercise['target'] as String));
  }

  @override
  Widget build(BuildContext context) {
    final available =
        _shuffledTiles.where((t) => !_selected.contains(t)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tap the words in the correct order',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(widget.exercise['prompt'],
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, color: AppColors.textSecondary),
              onPressed: () => AudioService().speak(widget.exercise['ttsText'] as String? ?? widget.exercise['target'] as String),
              tooltip: 'Hear the answer',
            ),
          ],
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 60),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selected.asMap().entries.map((e) => GestureDetector(
              onTap: () => _remove(e.key),
              child: Chip(
                  label: Text(e.value),
                  backgroundColor: AppColors.primary.withOpacity(0.15)),
            )).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: available
              .map((t) => GestureDetector(
                    onTap: () => _tap(t),
                    child: Chip(
                        label: Text(t),
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey)),
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),
        if (!widget.answered && _selected.isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _check,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Check',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }
}

// ─── Fill in the Blank ─────────────────────────────────────────────────────

class _FillBlank extends StatefulWidget {
  final Map<String, dynamic> exercise;
  final bool answered;
  final void Function(bool) onAnswer;

  const _FillBlank(
      {super.key, required this.exercise, required this.answered, required this.onAnswer});

  @override
  State<_FillBlank> createState() => _FillBlankState();
}

class _FillBlankState extends State<_FillBlank> {
  final _controller = TextEditingController();
  bool _isCorrect = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    final answer = _controller.text.trim().toLowerCase();
    final correct =
        answer == (widget.exercise['correct'] as String).toLowerCase();
    setState(() => _isCorrect = correct);
    widget.onAnswer(correct);
  }

  @override
  Widget build(BuildContext context) {
    final sentence = widget.exercise['sentence'] as String;
    final hint = widget.exercise['hint'] as String?;
    final correct = widget.exercise['correct'] as String;
    final parts = sentence.split('___');

    Color fieldColor = Colors.white;
    if (widget.answered) {
      fieldColor = _isCorrect
          ? AppColors.correct.withOpacity(0.1)
          : AppColors.incorrect.withOpacity(0.1);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fill in the blank',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 32),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            if (parts[0].isNotEmpty)
              Text(parts[0],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            Container(
              width: 120,
              height: 48,
              decoration: BoxDecoration(
                color: fieldColor,
                border: Border.all(
                    color: widget.answered
                        ? (_isCorrect ? AppColors.correct : AppColors.incorrect)
                        : AppColors.primary,
                    width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: widget.answered
                  ? Center(
                      child: Text(
                        _isCorrect ? _controller.text.trim() : correct,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isCorrect ? AppColors.correct : AppColors.incorrect,
                        ),
                      ),
                    )
                  : TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero),
                      onSubmitted: (_) => _check(),
                    ),
            ),
            if (parts.length > 1 && parts[1].isNotEmpty)
              Text(parts[1],
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        if (hint != null) ...[
          const SizedBox(height: 16),
          Text('Hint: $hint',
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                  fontSize: 14)),
        ],
        const SizedBox(height: 32),
        if (!widget.answered)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _check,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Check',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }
}

// ─── Conjugation Table ─────────────────────────────────────────────────────

class _ConjugationTable extends StatefulWidget {
  final Map<String, dynamic> exercise;
  final bool answered;
  final void Function(bool) onAnswer;

  const _ConjugationTable(
      {super.key, required this.exercise, required this.answered, required this.onAnswer});

  @override
  State<_ConjugationTable> createState() => _ConjugationTableState();
}

class _ConjugationTableState extends State<_ConjugationTable> {
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    final count = (widget.exercise['pronouns'] as List).length;
    _controllers = List.generate(count, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  void _check() {
    final answers = List<String>.from(widget.exercise['answers']);
    bool allCorrect = true;
    for (int i = 0; i < _controllers.length; i++) {
      if (_controllers[i].text.trim().toLowerCase() !=
          answers[i].toLowerCase()) {
        allCorrect = false;
        break;
      }
    }
    widget.onAnswer(allCorrect);
  }

  @override
  Widget build(BuildContext context) {
    final verb = widget.exercise['verb'] as String;
    final tense = widget.exercise['tense'] as String;
    final pronouns = List<String>.from(widget.exercise['pronouns']);
    final answers = List<String>.from(widget.exercise['answers']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Complete the conjugation table',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 12),
        Text('$verb — $tense',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: pronouns.asMap().entries.map((entry) {
              final i = entry.key;
              final pronoun = entry.value;
              final isLast = i == pronouns.length - 1;
              final isCorrect = widget.answered &&
                  _controllers[i].text.trim().toLowerCase() ==
                      answers[i].toLowerCase();

              return Container(
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                          bottom:
                              BorderSide(color: Colors.grey[200]!, width: 1)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(pronoun,
                          style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: widget.answered
                          ? Text(
                              answers[i],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isCorrect
                                    ? AppColors.correct
                                    : AppColors.incorrect,
                              ),
                            )
                          : TextField(
                              controller: _controllers[i],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: '...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                isDense: true,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        if (!widget.answered)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _check,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Check',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
      ],
    );
  }
}
