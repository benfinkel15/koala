import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/content/german/curriculum.dart';
import 'package:koala/services/curriculum_generator.dart';
import 'package:koala/services/progress_service.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;
  const LessonScreen({super.key, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentIndex = 0;
  String? _selectedAnswer;
  bool _answered = false;
  bool _lastCorrect = false;
  String _correctAnswer = '';
  String _explanation = '';
  int _hearts = 5;
  int _xp = 0;
  late List<Map<String, dynamic>> _exercises;
  final Set<int> _requeuedIndices = {};

  @override
  void initState() {
    super.initState();
    final activeExercises =
        CurriculumService().current?.exercises[widget.lessonId] ??
            lessonExercises[widget.lessonId] ??
            [];
    _exercises = List<Map<String, dynamic>>.from(activeExercises);
  }

  void _onAnswer(bool correct, {required String correctAnswer, String explanation = ''}) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _lastCorrect = correct;
      _correctAnswer = correctAnswer;
      _explanation = explanation;
      if (correct) {
        _xp += 10;
      } else {
        _hearts = (_hearts - 1).clamp(0, 5);
        // Re-queue this exercise at the end if not already re-queued
        if (!_requeuedIndices.contains(_currentIndex)) {
          _requeuedIndices.add(_currentIndex);
          _exercises.add(_exercises[_currentIndex]);
        }
      }
    });
  }

  void _onNext() {
    if (_currentIndex < _exercises.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
        _lastCorrect = false;
      });
    } else {
      _showComplete();
    }
  }

  void _showComplete() async {
    final stars = ProgressService.starsForHearts(_hearts);
    await ProgressService.saveLesson(
      lessonId: widget.lessonId,
      stars: stars,
      xp: _xp,
    );
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Lesson Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You earned $_xp XP!'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Icon(
                  i < stars ? Icons.star : Icons.star_border,
                  color: AppColors.xpGold,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              context.go('/home');
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_exercises.isEmpty) {
      return Scaffold(
        appBar: AppBar(leading: BackButton(onPressed: () => context.go('/home'))),
        body: const Center(child: Text('No exercises found for this lesson.')),
      );
    }

    final exercise = _exercises[_currentIndex];
    final progress = (_currentIndex + 1) / _exercises.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          onPressed: () => context.go('/home'),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.heartRed, size: 20),
                const SizedBox(width: 4),
                Text('$_hearts', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildExercise(exercise),
            ),
          ),
          if (_answered)
            _AnswerFooter(
              correct: _lastCorrect,
              correctAnswer: _correctAnswer,
              explanation: _explanation,
              onNext: _onNext,
            ),
        ],
      ),
    );
  }

  Widget _buildExercise(Map<String, dynamic> exercise) {
    switch (exercise['type']) {
      case 'multipleChoice':
        return _MultipleChoice(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          selectedAnswer: _selectedAnswer,
          answered: _answered,
          onAnswer: (answer, correct) {
            setState(() => _selectedAnswer = answer);
            final options = List<String>.from(exercise['options']);
            final correctText = options[exercise['correct'] as int];
            final explanation = exercise['explanation'] as String? ?? '';
            _onAnswer(correct, correctAnswer: correctText, explanation: explanation);
          },
        );
      case 'tapToBuild':
        return _TapToBuild(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          answered: _answered,
          onAnswer: (correct) {
            final explanation = exercise['explanation'] as String? ?? '';
            _onAnswer(correct,
                correctAnswer: exercise['target'] as String,
                explanation: explanation);
          },
        );
      case 'fillBlank':
        return _FillBlank(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          answered: _answered,
          onAnswer: (correct) {
            final explanation = exercise['explanation'] as String? ?? '';
            _onAnswer(correct,
                correctAnswer: exercise['correct'] as String,
                explanation: explanation);
          },
        );
      case 'conjugationTable':
        return _ConjugationTable(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          answered: _answered,
          onAnswer: (correct) {
            final answers = List<String>.from(exercise['answers']);
            final pronouns = List<String>.from(exercise['pronouns']);
            final table = pronouns.asMap().entries
                .map((e) => '${e.value} → ${answers[e.key]}')
                .join(',  ');
            final explanation = exercise['explanation'] as String? ??
                'The full conjugation of "${exercise['verb']}" is: $table';
            _onAnswer(correct, correctAnswer: table, explanation: explanation);
          },
        );
      default:
        return Text('Unknown exercise type: ${exercise['type']}');
    }
  }
}

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
  }

  void _remove(int i) {
    if (widget.answered) return;
    setState(() => _selected.removeAt(i));
  }

  void _check() {
    final answer = _selected.fold<String>('', (buf, tile) {
      if (buf.isEmpty) return tile;
      const punct = {'.', ',', '!', '?', ':', ';'};
      return punct.contains(tile) ? '$buf$tile' : '$buf $tile';
    });
    widget.onAnswer(answer == widget.exercise['target']);
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
        Text(widget.exercise['prompt'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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

// ─── Answer Footer ─────────────────────────────────────────────────────────

class _AnswerFooter extends StatelessWidget {
  final bool correct;
  final String correctAnswer;
  final String explanation;
  final VoidCallback onNext;

  const _AnswerFooter({
    required this.correct,
    required this.correctAnswer,
    required this.explanation,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: correct
          ? AppColors.correct.withOpacity(0.1)
          : AppColors.incorrect.withOpacity(0.1),
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
              correct ? Icons.check_circle : Icons.cancel,
              color: correct ? AppColors.correct : AppColors.incorrect,
              size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  correct ? 'Correct! +10 XP' : 'Not quite!',
                  style: TextStyle(
                    color: correct ? AppColors.correct : AppColors.incorrect,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (!correct && correctAnswer.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    'Correct answer: $correctAnswer',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
                if (!correct && explanation.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: correct ? AppColors.correct : AppColors.incorrect,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Next',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
