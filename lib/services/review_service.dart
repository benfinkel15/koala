import 'package:hive_flutter/hive_flutter.dart';
import 'package:koala/content/german/vocab_bank.dart';
import 'package:koala/services/progress_service.dart';

class ReviewItem {
  final String lessonId;
  final String hiveKey;
  final VocabEntry entry;

  const ReviewItem({
    required this.lessonId,
    required this.hiveKey,
    required this.entry,
  });
}

class ReviewService {
  static const _boxName = 'srs';

  static String _key(String lessonId, String german) =>
      '${lessonId}__${german.replaceAll(' ', '_')}';

  static String _dateStr(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-'
      '${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')}';

  static Future<List<ReviewItem>> getDueItems() async {
    final box = await Hive.openBox(_boxName);
    final completedIds = await ProgressService.completedLessonIds();
    final todayStr = _dateStr(DateTime.now());

    final due = <ReviewItem>[];
    for (final lessonId in completedIds) {
      final entries = lessonVocab[lessonId] ?? [];
      for (final entry in entries) {
        final key = _key(lessonId, entry.german);
        final data = box.get(key);
        if (data == null) {
          due.add(ReviewItem(lessonId: lessonId, hiveKey: key, entry: entry));
        } else {
          final nextReview = data['nextReview'] as String? ?? '';
          if (nextReview.isEmpty || nextReview.compareTo(todayStr) <= 0) {
            due.add(ReviewItem(lessonId: lessonId, hiveKey: key, entry: entry));
          }
        }
      }
    }
    due.shuffle();
    return due.take(20).toList();
  }

  static Future<void> recordAnswer(String key, bool correct) async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(key);
    final data = raw != null
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{'interval': 0, 'ef': 2.5, 'reps': 0};

    int interval = data['interval'] as int? ?? 0;
    double ef = (data['ef'] as num?)?.toDouble() ?? 2.5;
    int reps = data['reps'] as int? ?? 0;

    if (correct) {
      if (reps == 0) {
        interval = 1;
      } else if (reps == 1) {
        interval = 6;
      } else {
        interval = (interval * ef).round();
      }
      ef = (ef + 0.1).clamp(1.3, 4.0);
      reps++;
    } else {
      interval = 0;
      ef = (ef - 0.2).clamp(1.3, 4.0);
      reps = 0;
    }

    final nextReview = correct
        ? _dateStr(DateTime.now().add(Duration(days: interval)))
        : _dateStr(DateTime.now());

    await box.put(key, {
      'interval': interval,
      'ef': ef,
      'reps': reps,
      'nextReview': nextReview,
    });
  }
}
