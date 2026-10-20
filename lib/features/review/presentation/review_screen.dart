import 'dart:math';
import 'package:flutter/material.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/services/review_service.dart';

enum _Phase { question, result, done }

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<ReviewItem> _items = [];
  int _index = 0;
  bool _loading = true;
  _Phase _phase = _Phase.question;
  bool _germanToEnglish = true;
  bool _wasCorrect = false;
  int _correct = 0;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await ReviewService.getDueItems();
    if (mounted) {
      setState(() {
        _items = items;
        _loading = false;
        if (items.isEmpty) {
          _phase = _Phase.done;
        } else {
          _setDirection();
        }
      });
    }
  }

  void _setDirection() {
    _germanToEnglish = Random().nextBool();
  }

  bool _checkAnswer(String userAnswer, String correctAnswer) {
    final user = userAnswer.trim().toLowerCase();
    final options = correctAnswer
        .toLowerCase()
        .split(RegExp(r'\s*/\s*'))
        .map((s) => s.trim())
        .toList();
    return options.any((opt) => opt == user);
  }

  void _submit() {
    final answer = _controller.text.trim();
    if (answer.isEmpty) return;
    final entry = _items[_index].entry;
    final correct = _germanToEnglish
        ? _checkAnswer(answer, entry.english)
        : _checkAnswer(answer, entry.german);
    setState(() {
      _wasCorrect = correct;
      if (correct) _correct++;
      _phase = _Phase.result;
    });
    ReviewService.recordAnswer(_items[_index].hiveKey, correct);
  }

  void _next() {
    _controller.clear();
    if (_index + 1 >= _items.length) {
      setState(() => _phase = _Phase.done);
    } else {
      setState(() {
        _index++;
        _phase = _Phase.question;
        _setDirection();
      });
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Review'),
        actions: (!_loading && _phase != _Phase.done && _items.isNotEmpty)
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Text(
                      '${_index + 1} / ${_items.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _phase == _Phase.done
              ? _buildDone()
              : _buildExercise(),
    );
  }

  Widget _buildDone() {
    if (_items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: AppColors.correct),
              const SizedBox(height: 24),
              const Text(
                'Nothing to review!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Complete more lessons to unlock vocab for review.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }
    final pct = (_correct / _items.length * 100).round();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              pct >= 80 ? Icons.emoji_events : Icons.replay,
              size: 80,
              color: pct >= 80 ? AppColors.xpGold : AppColors.streakOrange,
            ),
            const SizedBox(height: 24),
            const Text(
              'Session complete!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '$_correct / ${_items.length} correct ($pct%)',
              style: const TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _index = 0;
                  _correct = 0;
                  _loading = true;
                  _phase = _Phase.question;
                });
                _loadItems();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Review Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercise() {
    final entry = _items[_index].entry;
    final prompt = _germanToEnglish ? entry.german : entry.english;
    final hint =
        _germanToEnglish ? 'Type the English translation' : 'Type the German word';
    final correctAnswer = _germanToEnglish ? entry.english : entry.german;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Text(
            _germanToEnglish ? 'Translate to English' : 'Translate to German',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              prompt,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: _phase == _Phase.question,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (_phase == _Phase.question && _controller.text.trim().isNotEmpty) {
                _submit();
              }
            },
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _wasCorrect ? AppColors.correct : AppColors.error,
                  width: 2,
                ),
              ),
            ),
          ),
          if (_phase == _Phase.result) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (_wasCorrect ? AppColors.correct : AppColors.error)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (_wasCorrect ? AppColors.correct : AppColors.error)
                      .withOpacity(0.4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _wasCorrect ? Icons.check_circle : Icons.cancel,
                    color: _wasCorrect ? AppColors.correct : AppColors.error,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _wasCorrect ? 'Correct!' : 'Incorrect',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _wasCorrect ? AppColors.correct : AppColors.error,
                          ),
                        ),
                        if (!_wasCorrect) ...[
                          const SizedBox(height: 4),
                          Text(
                            correctAnswer,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const Spacer(),
          if (_phase == _Phase.question)
            ElevatedButton(
              onPressed:
                  _controller.text.trim().isEmpty ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Check', style: TextStyle(fontSize: 16)),
            )
          else
            ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _index + 1 >= _items.length ? 'Finish' : 'Continue',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
