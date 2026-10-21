import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/content/german/passages.dart';
import 'package:koala/core/constants/app_colors.dart';

const _levelColors = {
  'Beginner': Color(0xFF4CAF50),
  'Intermediate': Color(0xFFFF9800),
  'Advanced': Color(0xFFF44336),
};

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Read', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'Tap any word to translate it and understand its grammar',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: germanPassages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _PassageCard(passage: germanPassages[i]),
      ),
    );
  }
}

class _PassageCard extends StatelessWidget {
  final GermanPassage passage;
  const _PassageCard({required this.passage});

  @override
  Widget build(BuildContext context) {
    final color = _levelColors[passage.level] ?? AppColors.primary;
    final preview = passage.sentences.first;

    return GestureDetector(
      onTap: () => context.push('/passage/${passage.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(passage.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(passage.level,
                      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(passage.topic,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 10),
            Text(
              preview,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontStyle: FontStyle.italic),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.article_outlined, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${passage.sentences.length} sentences',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(width: 16),
                Icon(Icons.volume_up_outlined, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('Tap to read aloud',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
