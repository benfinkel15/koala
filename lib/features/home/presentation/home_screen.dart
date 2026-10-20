import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/services/curriculum_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LanguageInfo _selectedLanguage = supportedLanguages.first;
  bool _isGenerating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _restoreLanguage();
  }

  Future<void> _restoreLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString('selected_language') ?? 'de';
    if (savedCode == 'de' || !mounted) return;
    final lang = supportedLanguages.firstWhere(
      (l) => l.code == savedCode,
      orElse: () => supportedLanguages.first,
    );
    await _loadLanguage(lang);
  }

  Future<void> _loadLanguage(LanguageInfo lang) async {
    setState(() {
      _selectedLanguage = lang;
      _error = null;
    });

    if (lang.code == 'de') {
      await CurriculumService().loadLanguage('de', 'German', '');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', 'de');
      if (mounted) setState(() {});
      return;
    }

    setState(() => _isGenerating = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final apiKey = prefs.getString('anthropic_api_key') ?? '';
      await CurriculumService().loadLanguage(lang.code, lang.name, apiKey);
      await prefs.setString('selected_language', lang.code);
      if (mounted) setState(() => _isGenerating = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _error =
              'Could not load ${lang.name} curriculum.\nMake sure your API key is set in the Chat tab.';
        });
      }
    }
  }

  Future<void> _showLanguagePicker() async {
    final picked = await showModalBottomSheet<LanguageInfo>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Select Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ...supportedLanguages.map(
              (lang) => ListTile(
                title: Text(lang.name),
                subtitle: Text(lang.nativeName,
                    style: const TextStyle(color: AppColors.textSecondary)),
                trailing: _selectedLanguage.code == lang.code
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () => Navigator.pop(ctx, lang),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (picked != null && picked.code != _selectedLanguage.code) {
      await _loadLanguage(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: const Text(
          'Koala',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          TextButton.icon(
            onPressed: _showLanguagePicker,
            icon: const Icon(Icons.language, color: Colors.white, size: 18),
            label: Text(
              _selectedLanguage.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.heartRed, size: 20),
                const SizedBox(width: 4),
                const Text('5',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                const Icon(Icons.local_fire_department,
                    color: AppColors.streakOrange, size: 20),
                const SizedBox(width: 4),
                const Text('3',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isGenerating) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                'Generating ${_selectedLanguage.name} curriculum…',
                style: const TextStyle(
                    fontSize: 16, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'This may take up to a minute.',
                style: TextStyle(
                    fontSize: 13, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 15),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _loadLanguage(_selectedLanguage),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => _loadLanguage(supportedLanguages.first),
                child: const Text('Switch back to German'),
              ),
            ],
          ),
        ),
      );
    }

    final units = CurriculumService().current?.units ?? [];
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      children: [
        const _XpProgressBar(xp: 340, levelXp: 450, level: 4),
        const SizedBox(height: 24),
        ...units.asMap().entries.map((entry) {
          final color =
              AppColors.unitColors[entry.key % AppColors.unitColors.length];
          return _UnitSection(unit: entry.value, color: color);
        }),
      ],
    );
  }
}

class _XpProgressBar extends StatelessWidget {
  final int xp;
  final int levelXp;
  final int level;

  const _XpProgressBar(
      {required this.xp, required this.levelXp, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Level $level',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary)),
            Text('$xp / $levelXp XP',
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12)),
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
  final CurriculumUnit unit;
  final Color color;

  const _UnitSection({required this.unit, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(unit.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(height: 4),
              Text(unit.description,
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...unit.lessons.asMap().entries.map((entry) {
          final i = entry.key;
          final lesson = entry.value;
          return _LessonNode(
            lesson: lesson,
            color: color,
            isLast: i == unit.lessons.length - 1,
          );
        }),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _LessonNode extends StatelessWidget {
  final CurriculumLesson lesson;
  final Color color;
  final bool isLast;

  const _LessonNode(
      {required this.lesson, required this.color, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () => context.push('/lesson/${lesson.id}'),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 28),
              ),
            ),
            if (!isLast) Container(width: 3, height: 32, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            lesson.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
