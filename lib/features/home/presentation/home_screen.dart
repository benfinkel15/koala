import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Koala', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.heartRed, size: 20),
                const SizedBox(width: 4),
                const Text('5', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                const Icon(Icons.local_fire_department, color: AppColors.streakOrange, size: 20),
                const SizedBox(width: 4),
                const Text('3', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          _XpProgressBar(xp: 340, levelXp: 450, level: 4),
          const SizedBox(height: 24),
          ..._units.map((unit) => _UnitSection(unit: unit)),
        ],
      ),
    );
  }
}

class _XpProgressBar extends StatelessWidget {
  final int xp;
  final int levelXp;
  final int level;

  const _XpProgressBar({required this.xp, required this.levelXp, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Level $level', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
            Text('$xp / $levelXp XP', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: xp / levelXp,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(AppColors.xpGold),
          ),
        ),
      ],
    );
  }
}

class _UnitSection extends StatelessWidget {
  final _UnitData unit;
  const _UnitSection({required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: unit.color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(unit.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(unit.description, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...unit.lessons.asMap().entries.map((entry) {
          final i = entry.key;
          final lesson = entry.value;
          return _LessonNode(lesson: lesson, color: unit.color, isLast: i == unit.lessons.length - 1);
        }),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _LessonNode extends StatelessWidget {
  final _LessonData lesson;
  final Color color;
  final bool isLast;

  const _LessonNode({required this.lesson, required this.color, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: lesson.isUnlocked ? () => context.push('/lesson/${lesson.id}') : null,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: lesson.isUnlocked ? color : Colors.grey[300],
                  shape: BoxShape.circle,
                  boxShadow: lesson.isUnlocked
                      ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))]
                      : null,
                ),
                child: Icon(
                  lesson.isCompleted
                      ? Icons.check
                      : lesson.isUnlocked
                          ? Icons.star
                          : Icons.lock,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            if (!isLast)
              Container(width: 3, height: 32, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            lesson.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: lesson.isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
        if (lesson.isCompleted)
          Row(
            children: List.generate(3, (i) => Icon(
              Icons.star,
              size: 16,
              color: i < lesson.stars ? AppColors.xpGold : Colors.grey[300],
            )),
          ),
      ],
    );
  }
}

// Temporary static data — will be replaced by real content/Firestore
class _UnitData {
  final String title;
  final String description;
  final Color color;
  final List<_LessonData> lessons;
  const _UnitData({required this.title, required this.description, required this.color, required this.lessons});
}

class _LessonData {
  final String id;
  final String title;
  final bool isUnlocked;
  final bool isCompleted;
  final int stars;
  const _LessonData({required this.id, required this.title, this.isUnlocked = false, this.isCompleted = false, this.stars = 0});
}

final _units = [
  _UnitData(
    title: 'Unit 1 — Greetings & Introductions',
    description: 'Say hello, introduce yourself, say where you\'re from',
    color: AppColors.unitColors[0],
    lessons: [
      _LessonData(id: 'u1_l1', title: 'Hello and Goodbye', isUnlocked: true),
      _LessonData(id: 'u1_l2', title: 'My Name Is…', isUnlocked: true),
      _LessonData(id: 'u1_l3', title: 'The verb "sein" (to be)', isUnlocked: true),
      _LessonData(id: 'u1_l4', title: 'Where Are You From?', isUnlocked: true),
      _LessonData(id: 'u1_l5', title: 'First Conversation', isUnlocked: true),
    ],
  ),
  _UnitData(
    title: 'Unit 2 — Family & Hobbies',
    description: 'Talk about family, hobbies, and regular verbs',
    color: AppColors.unitColors[1],
    lessons: [
      _LessonData(id: 'u2_l1', title: 'The verb "haben" (to have)', isUnlocked: true),
      _LessonData(id: 'u2_l2', title: 'Family Members', isUnlocked: true),
      _LessonData(id: 'u2_l3', title: 'Regular -en Verbs', isUnlocked: true),
      _LessonData(id: 'u2_l4', title: 'Hobbies', isUnlocked: true),
      _LessonData(id: 'u2_l5', title: 'Full Self-Introduction', isUnlocked: true),
    ],
  ),
  _UnitData(
    title: 'Unit 3 — Food & Café',
    description: 'Order food, express preferences, use modal verbs',
    color: AppColors.unitColors[2],
    lessons: [
      _LessonData(id: 'u3_l1', title: 'Food and Drink Vocabulary', isUnlocked: true),
      _LessonData(id: 'u3_l2', title: 'mögen — Expressing Preferences', isUnlocked: true),
      _LessonData(id: 'u3_l3', title: 'Ordering at a Café', isUnlocked: true),
      _LessonData(id: 'u3_l4', title: 'können and müssen', isUnlocked: true),
      _LessonData(id: 'u3_l5', title: 'At the Café — Full Interaction', isUnlocked: true),
    ],
  ),
];
