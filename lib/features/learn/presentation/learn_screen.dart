import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants/app_colors.dart';

class ScenarioConfig {
  final String id;
  final String title;
  final String description;
  final String character;
  final String difficulty;
  final IconData icon;
  final String systemPrompt;

  const ScenarioConfig({
    required this.id,
    required this.title,
    required this.description,
    required this.character,
    required this.difficulty,
    required this.icon,
    required this.systemPrompt,
  });
}

const _scenarios = [
  ScenarioConfig(
    id: 'cafe',
    title: 'At the Café',
    description: 'Order coffee and cake from a friendly waiter',
    character: 'German waiter',
    difficulty: 'Beginner',
    icon: Icons.coffee,
    systemPrompt:
        'You are a friendly waiter at a cozy German café called "Zum alten Markt". Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'meeting',
    title: 'Meeting Someone',
    description: 'Introduce yourself and get to know a new person',
    character: 'New acquaintance',
    difficulty: 'Beginner',
    icon: Icons.waving_hand,
    systemPrompt:
        'You are a friendly German person meeting someone new at a community event. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'market',
    title: 'At the Market',
    description: 'Buy fresh fruit and vegetables from a market stall',
    character: 'Market vendor',
    difficulty: 'Beginner',
    icon: Icons.storefront,
    systemPrompt:
        'You are a cheerful vendor at a German farmers market selling fresh fruit and vegetables. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'train',
    title: 'Train Station',
    description: 'Buy a ticket and find your platform',
    character: 'Station staff',
    difficulty: 'Intermediate',
    icon: Icons.train,
    systemPrompt:
        'You are a helpful ticket agent at a German train station (Deutsche Bahn). Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'plans',
    title: 'Making Plans',
    description: 'Arrange to meet a friend for the weekend',
    character: 'German friend',
    difficulty: 'Intermediate',
    icon: Icons.calendar_today,
    systemPrompt:
        'You are a good German friend planning a weekend together. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'doctor',
    title: "Doctor's Visit",
    description: 'Describe your symptoms to a German doctor',
    character: 'Doctor',
    difficulty: 'Intermediate',
    icon: Icons.local_hospital,
    systemPrompt:
        'You are a friendly doctor at a German medical practice (Arztpraxis). Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'interview',
    title: 'Job Interview',
    description: 'Answer questions about yourself and your experience',
    character: 'HR manager',
    difficulty: 'Advanced',
    icon: Icons.work,
    systemPrompt:
        'You are a professional HR manager at a German company conducting a job interview. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'apartment',
    title: 'Renting a Flat',
    description: 'Ask about an apartment and discuss the details',
    character: 'Landlord',
    difficulty: 'Advanced',
    icon: Icons.apartment,
    systemPrompt:
        'You are a German landlord showing an apartment to a potential tenant. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),
];

const _difficultyColors = {
  'Beginner': Color(0xFF4CAF50),
  'Intermediate': Color(0xFFFF9800),
  'Advanced': Color(0xFFF44336),
};

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            floating: true,
            title: const Text('Learn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  'Pick a scenario and start speaking German',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 14),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisExtent: 160,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ScenarioCard(scenario: _scenarios[i]),
                childCount: _scenarios.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final ScenarioConfig scenario;
  const _ScenarioCard({required this.scenario});

  @override
  Widget build(BuildContext context) {
    final color = _difficultyColors[scenario.difficulty] ?? AppColors.primary;
    return GestureDetector(
      onTap: () => context.push('/scenario/${scenario.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(scenario.icon, color: AppColors.primary, size: 22),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    scenario.difficulty,
                    style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(scenario.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(scenario.description,
                style: TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
