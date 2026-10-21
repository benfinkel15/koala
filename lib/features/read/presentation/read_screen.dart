import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/content/danish/passages.dart';
import 'package:koala/content/dutch/passages.dart';
import 'package:koala/content/german/passages.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _levelColors = {
  'Beginner': Color(0xFF5B8C6A),
  'Intermediate': Color(0xFFC4A44A),
  'Advanced': Color(0xFFC4714A),
};

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String _lang = 'de';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('read_language') ?? 'de';
    if (mounted) setState(() => _lang = saved);
  }

  Future<void> _setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('read_language', lang);
    setState(() => _lang = lang);
  }

  @override
  Widget build(BuildContext context) {
    final passages = _lang == 'nl' ? dutchPassages : _lang == 'da' ? danishPassages : germanPassages;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Read'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                _LangChip(flag: '🇩🇪', label: 'German', code: 'de', selected: _lang, onTap: _setLanguage),
                const SizedBox(width: 8),
                _LangChip(flag: '🇳🇱', label: 'Dutch', code: 'nl', selected: _lang, onTap: _setLanguage),
                const SizedBox(width: 8),
                _LangChip(flag: '🇩🇰', label: 'Danish', code: 'da', selected: _lang, onTap: _setLanguage),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: passages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _PassageCard(passage: passages[i]),
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String flag, label, code, selected;
  final void Function(String) onTap;
  const _LangChip({
    required this.flag,
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = selected == code;
    return GestureDetector(
      onTap: () => onTap(code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.textSecondary.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: active ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
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
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
                color: Colors.brown.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2)),
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
                      style: TextStyle(
                          color: color, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(passage.topic,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 10),
            Text(
              preview,
              style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
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
