import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/widgets/city_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScenarioConfig {
  final String id;
  final String title;
  final String description;
  final String character;
  final String difficulty;
  final IconData icon;
  final String systemPrompt;
  final String language; // 'de', 'nl', 'da', or 'id'

  const ScenarioConfig({
    required this.id,
    required this.title,
    required this.description,
    required this.character,
    required this.difficulty,
    required this.icon,
    required this.systemPrompt,
    required this.language,
  });
}

const allScenarios = [
  // ─── German ──────────────────────────────────────────────────────────────
  ScenarioConfig(
    id: 'cafe',
    language: 'de',
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
    language: 'de',
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
    language: 'de',
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
    language: 'de',
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
    language: 'de',
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
    language: 'de',
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
    language: 'de',
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
    language: 'de',
    title: 'Renting a Flat',
    description: 'Ask about an apartment and discuss the details',
    character: 'Landlord',
    difficulty: 'Advanced',
    icon: Icons.apartment,
    systemPrompt:
        'You are a German landlord showing an apartment to a potential tenant. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
  ),

  // ─── Indonesian ──────────────────────────────────────────────────────────
  ScenarioConfig(
    id: 'id_cafe',
    language: 'id',
    title: 'Di Warung Kopi',
    description: 'Pesan kopi dan makanan ringan di warung lokal',
    character: 'Indonesian café owner',
    difficulty: 'Beginner',
    icon: Icons.coffee,
    systemPrompt:
        'You are a friendly owner of a cozy Indonesian warung kopi called "Warung Bu Sari". Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_meeting',
    language: 'id',
    title: 'Berkenalan',
    description: 'Perkenalkan dirimu dan kenal orang baru',
    character: 'Indonesian acquaintance',
    difficulty: 'Beginner',
    icon: Icons.waving_hand,
    systemPrompt:
        'You are a friendly Indonesian person meeting someone new at a community event. Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_market',
    language: 'id',
    title: 'Di Pasar',
    description: 'Beli buah dan sayuran segar di pasar tradisional',
    character: 'Market vendor',
    difficulty: 'Beginner',
    icon: Icons.storefront,
    systemPrompt:
        'You are a cheerful vendor at a traditional Indonesian pasar (market) selling fresh fruit and vegetables. Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_train',
    language: 'id',
    title: 'Di Stasiun',
    description: 'Beli tiket dan temukan peron yang benar',
    character: 'KAI station staff',
    difficulty: 'Intermediate',
    icon: Icons.train,
    systemPrompt:
        'You are a helpful ticket agent at an Indonesian train station (KAI — Kereta Api Indonesia). Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_plans',
    language: 'id',
    title: 'Buat Rencana',
    description: 'Atur janji dengan teman untuk akhir pekan',
    character: 'Indonesian friend',
    difficulty: 'Intermediate',
    icon: Icons.calendar_today,
    systemPrompt:
        'You are a good Indonesian friend making plans for the weekend. Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_doctor',
    language: 'id',
    title: 'Ke Dokter',
    description: 'Ceritakan gejalamu ke dokter Indonesia',
    character: 'Dokter umum',
    difficulty: 'Intermediate',
    icon: Icons.local_hospital,
    systemPrompt:
        'You are a friendly dokter umum (GP) at an Indonesian clinic (puskesmas). Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_interview',
    language: 'id',
    title: 'Wawancara Kerja',
    description: 'Jawab pertanyaan tentang dirimu dan pengalamanmu',
    character: 'HR manager',
    difficulty: 'Advanced',
    icon: Icons.work,
    systemPrompt:
        'You are a professional HR manager at an Indonesian company conducting a job interview. Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'id_apartment',
    language: 'id',
    title: 'Sewa Apartemen',
    description: 'Lihat apartemen dan diskusikan detailnya',
    character: 'Pemilik kost',
    difficulty: 'Advanced',
    icon: Icons.apartment,
    systemPrompt:
        'You are an Indonesian landlord showing a kost (rental room) to a potential tenant. Speak only in Indonesian (Bahasa Indonesia). After every response add a blank line then an English translation in italics (prefix with "🇮🇩 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tips:". Keep responses short — 1 to 3 sentences.',
  ),

  // ─── Danish ──────────────────────────────────────────────────────────────
  ScenarioConfig(
    id: 'da_cafe',
    language: 'da',
    title: 'På caféen',
    description: 'Bestil kaffe og kage hos en venlig tjener',
    character: 'Danish café waiter',
    difficulty: 'Beginner',
    icon: Icons.coffee,
    systemPrompt:
        'You are a friendly waiter at a cozy Danish café called "Den Lille Kop". Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_meeting',
    language: 'da',
    title: 'At møde nogen',
    description: 'Præsenter dig selv og lær en ny person at kende',
    character: 'Danish acquaintance',
    difficulty: 'Beginner',
    icon: Icons.waving_hand,
    systemPrompt:
        'You are a friendly Danish person meeting someone new at a community event. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_market',
    language: 'da',
    title: 'På markedet',
    description: 'Køb friske grøntsager og brød ved en markedsstand',
    character: 'Market vendor',
    difficulty: 'Beginner',
    icon: Icons.storefront,
    systemPrompt:
        'You are a cheerful vendor at a Danish farmers market selling fresh produce and bread. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_train',
    language: 'da',
    title: 'På stationen',
    description: 'Køb en billet og find dit perron',
    character: 'DSB station staff',
    difficulty: 'Intermediate',
    icon: Icons.train,
    systemPrompt:
        'You are a helpful ticket agent at a Danish train station (DSB). Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_plans',
    language: 'da',
    title: 'Laver planer',
    description: 'Aftale at mødes med en ven i weekenden',
    character: 'Danish friend',
    difficulty: 'Intermediate',
    icon: Icons.calendar_today,
    systemPrompt:
        'You are a good Danish friend making plans for the weekend. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_doctor',
    language: 'da',
    title: 'Hos lægen',
    description: 'Beskriv dine symptomer til en dansk læge',
    character: 'Praktiserende læge',
    difficulty: 'Intermediate',
    icon: Icons.local_hospital,
    systemPrompt:
        'You are a friendly praktiserende læge (GP) at a Danish medical practice. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_interview',
    language: 'da',
    title: 'Jobsamtale',
    description: 'Besvar spørgsmål om dig selv og din erfaring',
    character: 'HR manager',
    difficulty: 'Advanced',
    icon: Icons.work,
    systemPrompt:
        'You are a professional HR manager at a Danish company conducting a job interview. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'da_apartment',
    language: 'da',
    title: 'At leje en lejlighed',
    description: 'Se en lejlighed og diskutér detaljerne',
    character: 'Udlejer',
    difficulty: 'Advanced',
    icon: Icons.apartment,
    systemPrompt:
        'You are a Danish landlord showing an apartment to a potential tenant. Speak only in Danish. After every response add a blank line then an English translation in italics (prefix with "🇩🇰 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),

  // ─── Dutch ────────────────────────────────────────────────────────────────
  ScenarioConfig(
    id: 'nl_cafe',
    language: 'nl',
    title: 'Bij het café',
    description: 'Order koffie en appeltaart bij een vriendelijke ober',
    character: 'Dutch café waiter',
    difficulty: 'Beginner',
    icon: Icons.coffee,
    systemPrompt:
        'You are a friendly waiter at a cozy Dutch café called "Het Bruine Paard". Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_meeting',
    language: 'nl',
    title: 'Iemand ontmoeten',
    description: 'Stel jezelf voor en leer iemand kennen',
    character: 'Dutch acquaintance',
    difficulty: 'Beginner',
    icon: Icons.waving_hand,
    systemPrompt:
        'You are a friendly Dutch person meeting someone new at a neighbourhood event. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_market',
    language: 'nl',
    title: 'Op de markt',
    description: 'Koop verse groenten en kaas bij een kraam',
    character: 'Market vendor',
    difficulty: 'Beginner',
    icon: Icons.storefront,
    systemPrompt:
        'You are a cheerful vendor at a Dutch market (markt) selling fresh produce and cheese. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_train',
    language: 'nl',
    title: 'Op het station',
    description: 'Koop een kaartje en vind je perron',
    character: 'NS station staff',
    difficulty: 'Intermediate',
    icon: Icons.train,
    systemPrompt:
        'You are a helpful ticket agent at a Dutch train station (NS). Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_plans',
    language: 'nl',
    title: 'Plannen maken',
    description: 'Spreek af met een vriend voor het weekend',
    character: 'Dutch friend',
    difficulty: 'Intermediate',
    icon: Icons.calendar_today,
    systemPrompt:
        'You are a good Dutch friend making plans for the weekend. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_doctor',
    language: 'nl',
    title: 'Bij de dokter',
    description: 'Beschrijf je klachten bij een Nederlandse dokter',
    character: 'Huisarts',
    difficulty: 'Intermediate',
    icon: Icons.local_hospital,
    systemPrompt:
        'You are a friendly huisarts (GP) at a Dutch medical practice. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_interview',
    language: 'nl',
    title: 'Sollicitatiegesprek',
    description: 'Beantwoord vragen over jezelf en je werkervaring',
    character: 'HR manager',
    difficulty: 'Advanced',
    icon: Icons.work,
    systemPrompt:
        'You are a professional HR manager at a Dutch company conducting a job interview. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
  ScenarioConfig(
    id: 'nl_apartment',
    language: 'nl',
    title: 'Een appartement huren',
    description: 'Bekijk een appartement en bespreek de details',
    character: 'Verhuurder',
    difficulty: 'Advanced',
    icon: Icons.apartment,
    systemPrompt:
        'You are a Dutch landlord showing an apartment to a potential tenant. Speak only in Dutch. After every response add a blank line then an English translation in italics (prefix with "🇳🇱 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tip:". Keep responses short — 1 to 3 sentences.',
  ),
];

const _difficultyColors = {
  'Beginner': Color(0xFF5B8C6A),
  'Intermediate': Color(0xFFC4A44A),
  'Advanced': Color(0xFFC4714A),
};

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  String _lang = 'de';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('scenario_language') ?? 'de';
    if (mounted) setState(() => _lang = saved);
  }

  Future<void> _setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('scenario_language', lang);
    setState(() => _lang = lang);
  }

  @override
  Widget build(BuildContext context) {
    final scenarios = allScenarios.where((s) => s.language == _lang).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.surface,
            floating: true,
            title: const Text('Learn'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _LanguagePicker(selected: _lang, onSelect: _setLanguage),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CityBanner(langCode: _lang),
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
                (context, i) => _ScenarioCard(scenario: scenarios[i]),
                childCount: scenarios.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  final String selected;
  final void Function(String) onSelect;
  const _LanguagePicker({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _LangChip(flag: '🇩🇪', label: 'German', code: 'de', selected: selected, onTap: onSelect),
          const SizedBox(width: 8),
          _LangChip(flag: '🇳🇱', label: 'Dutch', code: 'nl', selected: selected, onTap: onSelect),
          const SizedBox(width: 8),
          _LangChip(flag: '🇩🇰', label: 'Danish', code: 'da', selected: selected, onTap: onSelect),
          const SizedBox(width: 8),
          _LangChip(flag: '🇮🇩', label: 'Indonesian', code: 'id', selected: selected, onTap: onSelect),
        ],
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
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withValues(alpha: 0.06),
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
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(scenario.icon, color: AppColors.primary, size: 20),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    scenario.difficulty,
                    style: TextStyle(
                        color: color, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(scenario.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 4),
            Text(scenario.description,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
