import 'package:hive_flutter/hive_flutter.dart';

class StreakService {
  static const _boxName = 'streak';
  static const _key = 'data';

  static String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static DateTime? _parseDate(String? s) {
    if (s == null || s.isEmpty) return null;
    final parts = s.split('-');
    if (parts.length != 3) return null;
    return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  static Future<Map<String, dynamic>> getStreak() async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(_key);
    if (raw is Map) return Map<String, dynamic>.from(raw);
    return {'currentDays': 0, 'longestDays': 0, 'lastCompletedDate': ''};
  }

  static Future<void> recordPractice() async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(_key);
    final data = raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};

    final today = _todayString();
    final last = data['lastCompletedDate'] as String? ?? '';

    if (last == today) return;

    int current = data['currentDays'] as int? ?? 0;
    int longest = data['longestDays'] as int? ?? 0;

    final lastDate = _parseDate(last);
    if (lastDate != null) {
      final todayDate = _parseDate(today)!;
      final diff = todayDate.difference(lastDate).inDays;
      if (diff == 1) {
        current += 1;
      } else {
        current = 1;
      }
    } else {
      current = 1;
    }

    if (current > longest) longest = current;

    await box.put(_key, {
      'currentDays': current,
      'longestDays': longest,
      'lastCompletedDate': today,
    });
  }
}
