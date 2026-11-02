import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/content/german/curriculum.dart';
import 'package:koala/services/audio_service.dart';
import 'package:koala/services/curriculum_generator.dart';
import 'package:koala/services/progress_service.dart';
import 'package:koala/services/streak_service.dart';

part 'exercise_widgets.dart';

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
  String _speakText = '';
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

  void _onAnswer(bool correct, {required String correctAnswer, String explanation = '', String speakText = ''}) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _lastCorrect = correct;
      _correctAnswer = correctAnswer;
      _explanation = explanation;
      _speakText = speakText;
      if (correct) {
        _xp += 10;
      } else {
        _hearts = (_hearts - 1).clamp(0, 5);
        if (!_requeuedIndices.contains(_currentIndex)) {
          _requeuedIndices.add(_currentIndex);
          _exercises.add(_exercises[_currentIndex]);
        }
      }
    });
    if (speakText.isNotEmpty) AudioService().speak(speakText);
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
    await StreakService.recordPractice();
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
              speakText: _speakText,
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
            _onAnswer(correct, correctAnswer: correctText, explanation: explanation, speakText: correctText);
          },
        );
      case 'tapToBuild':
        return _TapToBuild(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          answered: _answered,
          onAnswer: (correct) {
            final explanation = exercise['explanation'] as String? ?? '';
            final target = exercise['target'] as String;
            _onAnswer(correct, correctAnswer: target, explanation: explanation, speakText: target);
          },
        );
      case 'fillBlank':
        return _FillBlank(
          key: ValueKey(_currentIndex),
          exercise: exercise,
          answered: _answered,
          onAnswer: (correct) {
            final explanation = exercise['explanation'] as String? ?? '';
            final correctWord = exercise['correct'] as String;
            final fullSentence = (exercise['sentence'] as String).replaceFirst('___', correctWord);
            _onAnswer(correct, correctAnswer: correctWord, explanation: explanation, speakText: fullSentence);
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

// ─── Answer Footer ─────────────────────────────────────────────────────────

enum _SpeakState { idle, listening, result }

class _AnswerFooter extends StatefulWidget {
  final bool correct;
  final String correctAnswer;
  final String explanation;
  final String speakText;
  final VoidCallback onNext;

  const _AnswerFooter({
    required this.correct,
    required this.correctAnswer,
    required this.explanation,
    required this.speakText,
    required this.onNext,
  });

  @override
  State<_AnswerFooter> createState() => _AnswerFooterState();
}

class _AnswerFooterState extends State<_AnswerFooter> {
  final _stt = SpeechToText();
  _SpeakState _speakState = _SpeakState.idle;
  double _score = 0;
  bool _sttAvailable = false;

  @override
  void initState() {
    super.initState();
    if (widget.speakText.isNotEmpty) _initStt();
  }

  Future<void> _initStt() async {
    final available = await _stt.initialize(
      onStatus: (status) {
        if (!mounted) return;
        if ((status == 'done' || status == 'notListening') &&
            _speakState == _SpeakState.listening) {
          setState(() => _speakState = _SpeakState.idle);
        }
      },
    );
    if (mounted) setState(() => _sttAvailable = available);
  }

  Future<void> _startListening() async {
    setState(() => _speakState = _SpeakState.listening);
    await _stt.listen(
      onResult: (result) {
        if (!result.finalResult || !mounted) return;
        final score = StringSimilarity.compareTwoStrings(
          widget.speakText.toLowerCase(),
          result.recognizedWords.toLowerCase(),
        );
        setState(() {
          _score = score;
          _speakState = _SpeakState.result;
        });
      },
      listenFor: const Duration(seconds: 7),
      pauseFor: const Duration(seconds: 3),
      localeId: 'de_DE',
    );
  }

  @override
  void dispose() {
    _stt.cancel();
    super.dispose();
  }

  Widget _buildSpeakRow() {
    switch (_speakState) {
      case _SpeakState.idle:
        return Row(
          children: [
            const Text('Say it aloud:',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _startListening,
              child: const Icon(Icons.mic, color: AppColors.primary, size: 22),
            ),
          ],
        );
      case _SpeakState.listening:
        return const Row(
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: AppColors.primary),
            ),
            SizedBox(width: 8),
            Text('Listening…',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ],
        );
      case _SpeakState.result:
        final label = _score >= 0.85
            ? 'Excellent!'
            : _score >= 0.6
                ? 'Good try!'
                : 'Keep practicing';
        final color = _score >= 0.85
            ? AppColors.correct
            : _score >= 0.6
                ? AppColors.xpGold
                : AppColors.incorrect;
        return Row(
          children: [
            Icon(Icons.record_voice_over, color: color, size: 18),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color)),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => setState(() => _speakState = _SpeakState.idle),
              child: const Icon(Icons.refresh,
                  size: 16, color: AppColors.textSecondary),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.correct
          ? AppColors.correct.withOpacity(0.1)
          : AppColors.incorrect.withOpacity(0.1),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                  widget.correct ? Icons.check_circle : Icons.cancel,
                  color: widget.correct ? AppColors.correct : AppColors.incorrect,
                  size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.correct ? 'Correct! +10 XP' : 'Not quite!',
                          style: TextStyle(
                            color: widget.correct
                                ? AppColors.correct
                                : AppColors.incorrect,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (widget.speakText.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => AudioService().speak(widget.speakText),
                            child: Icon(Icons.volume_up,
                                color: widget.correct
                                    ? AppColors.correct
                                    : AppColors.incorrect,
                                size: 22),
                          ),
                        ],
                      ],
                    ),
                    if (!widget.correct && widget.correctAnswer.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Correct answer: ${widget.correctAnswer}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                    if (!widget.correct && widget.explanation.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.explanation,
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
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.correct ? AppColors.correct : AppColors.incorrect,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Next',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          if (widget.speakText.isNotEmpty && _sttAvailable) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildSpeakRow(),
            ),
          ],
        ],
      ),
    );
  }
}
