import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koala/core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  int? _selectedGoalXp;
  String? _selectedLanguage;

  static const _languages = [
    ('German', 'de', '🇩🇪'),
    ('Dutch', 'nl', '🇳🇱'),
    ('Danish', 'da', '🇩🇰'),
    ('Indonesian', 'id', '🇮🇩'),
    ('Spanish', 'es', '🇪🇸'),
    ('French', 'fr', '🇫🇷'),
    ('Italian', 'it', '🇮🇹'),
    ('Japanese', 'ja', '🇯🇵'),
  ];

  Future<void> _completeOnboarding() async {
    final box = await Hive.openBox('settings');
    await box.put('onboardingComplete', true);
    await box.put('dailyGoalXp', _selectedGoalXp ?? 20);
    await box.put('onboardingLanguage', _selectedLanguage ?? 'de');
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (_step) {
            0 => _WelcomeStep(key: const ValueKey(0), onNext: () => setState(() => _step = 1)),
            1 => _GoalStep(
                key: const ValueKey(1),
                selectedXp: _selectedGoalXp,
                onSelect: (xp) => setState(() => _selectedGoalXp = xp),
                onNext: () => setState(() => _step = 2),
              ),
            _ => _LanguageStep(
                key: const ValueKey(2),
                selectedCode: _selectedLanguage,
                languages: _languages,
                onSelect: (code) => setState(() => _selectedLanguage = code),
                onDone: _completeOnboarding,
              ),
          },
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final VoidCallback onNext;
  const _WelcomeStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🐨', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 24),
          Text(
            'Welcome to Koala',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Learn to speak a new language fast — with real phrases from day one.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onNext,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Let's go", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalStep extends StatelessWidget {
  final int? selectedXp;
  final ValueChanged<int> onSelect;
  final VoidCallback onNext;

  const _GoalStep({
    super.key,
    required this.selectedXp,
    required this.onSelect,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    const goals = [
      (label: 'Casual', description: '10 XP / day — just browsing', xp: 10, icon: Icons.wb_sunny),
      (label: 'Regular', description: '20 XP / day — steady progress', xp: 20, icon: Icons.directions_run),
      (label: 'Serious', description: '30 XP / day — full immersion', xp: 30, icon: Icons.local_fire_department),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set your daily goal',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'How much time can you practice each day?',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          ...goals.map((g) {
            final selected = selectedXp == g.xp;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => onSelect(g.xp),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
                    border: Border.all(
                      color: selected ? AppColors.primary : Colors.grey.shade300,
                      width: selected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(g.icon, color: selected ? AppColors.primary : AppColors.textSecondary, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(g.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selected ? AppColors.primary : AppColors.textPrimary,
                                )),
                            Text(g.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                )),
                          ],
                        ),
                      ),
                      if (selected) const Icon(Icons.check_circle, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: selectedXp != null ? onNext : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageStep extends StatelessWidget {
  final String? selectedCode;
  final List<(String, String, String)> languages;
  final ValueChanged<String> onSelect;
  final VoidCallback onDone;

  const _LanguageStep({
    super.key,
    required this.selectedCode,
    required this.languages,
    required this.onSelect,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What do you want to learn?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pick your target language.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          ...languages.map((lang) {
            final (name, code, flag) = lang;
            final selected = selectedCode == code;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => onSelect(code),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.surface,
                    border: Border.all(
                      color: selected ? AppColors.primary : Colors.grey.shade300,
                      width: selected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(flag, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: selected ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (selected) const Icon(Icons.check_circle, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: selectedCode != null ? onDone : null,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Start learning', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
