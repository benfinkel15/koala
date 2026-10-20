import 'package:hive_flutter/hive_flutter.dart';

class ProgressService {
  static const _boxName = 'progress';

  static int starsForHearts(int hearts) {
    if (hearts >= 5) return 3;
    if (hearts >= 3) return 2;
    return 1;
  }

  static Future<void> saveLesson({
    required String lessonId,
    required int stars,
    required int xp,
  }) async {
    final box = await Hive.openBox(_boxName);
    await box.put(lessonId, {
      'stars': stars,
      'xp': xp,
      'completedAt': DateTime.now().toIso8601String(),
    });
  }

  static Future<Map<String, Map<String, dynamic>>> allProgress() async {
    final box = await Hive.openBox(_boxName);
    final result = <String, Map<String, dynamic>>{};
    for (final key in box.keys) {
      if (key is String) {
        final raw = box.get(key);
        if (raw is Map) {
          result[key] = Map<String, dynamic>.from(raw);
        }
      }
    }
    return result;
  }

  static Future<int> totalXp() async {
    final progress = await allProgress();
    return progress.values.fold<int>(0, (sum, v) => sum + (v['xp'] as int? ?? 0));
  }

  static Future<Set<String>> completedLessonIds() async {
    final box = await Hive.openBox(_boxName);
    return box.keys.whereType<String>().toSet();
  }
}
