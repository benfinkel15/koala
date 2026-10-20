import 'package:flutter/material.dart';
import 'package:koala/content/german/vocab_bank.dart';
import 'package:koala/core/constants/app_colors.dart';

class VocabScreen extends StatefulWidget {
  const VocabScreen({super.key});

  @override
  State<VocabScreen> createState() => _VocabScreenState();
}

class _VocabScreenState extends State<VocabScreen> {
  static const _completedLessons = ['u1_l1', 'u1_l2'];
  String _query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, List<VocabEntry>> _filteredByUnit() {
    final q = _query.toLowerCase();
    final result = <String, List<VocabEntry>>{};
    for (final lessonId in _completedLessons) {
      final unit = lessonId.substring(0, 2);
      final entries = lessonVocab[lessonId] ?? [];
      final filtered = q.isEmpty
          ? entries
          : entries
              .where((e) =>
                  e.german.toLowerCase().contains(q) ||
                  e.english.toLowerCase().contains(q))
              .toList();
      if (filtered.isNotEmpty) {
        result.putIfAbsent(unit, () => []).addAll(filtered);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final byUnit = _filteredByUnit();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text('Vocabulary'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search words...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: byUnit.isEmpty
                ? const Center(
                    child: Text(
                      'No words found.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.only(bottom: 16),
                    children: byUnit.entries
                        .map((e) => _UnitSection(unitKey: e.key, entries: e.value))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _UnitSection extends StatelessWidget {
  final String unitKey;
  final List<VocabEntry> entries;

  const _UnitSection({required this.unitKey, required this.entries});

  Color get _color => switch (unitKey) {
        'u1' => AppColors.unitColors[0],
        'u2' => AppColors.unitColors[1],
        'u3' => AppColors.unitColors[2],
        _ => AppColors.primary,
      };

  String get _name => switch (unitKey) {
        'u1' => 'Unit 1 — Greetings & Introductions',
        'u2' => 'Unit 2 — Family & Hobbies',
        'u3' => 'Unit 3 — Food & Café',
        _ => unitKey,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          _name,
          style: TextStyle(fontWeight: FontWeight.bold, color: _color),
        ),
        subtitle: Text(
          '${entries.length} words',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        children: entries.map((e) => _VocabEntryTile(entry: e)).toList(),
      ),
    );
  }
}

class _VocabEntryTile extends StatelessWidget {
  final VocabEntry entry;
  const _VocabEntryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      title: Text(
        entry.german,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        entry.english,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      ),
      trailing: _GenderChip(gender: entry.gender),
      onTap: () => _showWordDetail(context, entry),
    );
  }
}

class _GenderChip extends StatelessWidget {
  final String gender;
  const _GenderChip({required this.gender});

  @override
  Widget build(BuildContext context) {
    final color = switch (gender) {
      'der' => const Color(0xFF1565C0),
      'die' => const Color(0xFFC62828),
      'das' => const Color(0xFF2E7D32),
      _ => AppColors.textSecondary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        gender,
        style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

void _showWordDetail(BuildContext context, VocabEntry entry) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    entry.german,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                _GenderChip(gender: entry.gender),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              entry.partOfSpeech,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            Text(entry.english, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.exampleSentence,
                style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
