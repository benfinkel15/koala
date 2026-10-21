import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/features/learn/presentation/learn_screen.dart';
import 'package:koala/services/audio_service.dart';
import 'package:koala/widgets/word_drill_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScenarioScreen extends StatefulWidget {
  final String scenarioId;
  const ScenarioScreen({super.key, required this.scenarioId});

  @override
  State<ScenarioScreen> createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  ScenarioConfig? _scenario;
  String? _apiKey;
  final List<_Msg> _messages = [];
  bool _loading = false;
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scenario = _findScenario();
    _loadKey();
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  ScenarioConfig? _findScenario() {
    // ignore: invalid_use_of_visible_for_testing_member
    const scenarios = [
      ScenarioConfig(
        id: 'cafe', title: 'At the Café', description: '', character: 'German waiter', difficulty: 'Beginner', icon: Icons.coffee,
        systemPrompt: 'You are a friendly waiter at a cozy German café called "Zum alten Markt". Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'meeting', title: 'Meeting Someone', description: '', character: 'New acquaintance', difficulty: 'Beginner', icon: Icons.waving_hand,
        systemPrompt: 'You are a friendly German person meeting someone new at a community event. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'market', title: 'At the Market', description: '', character: 'Market vendor', difficulty: 'Beginner', icon: Icons.storefront,
        systemPrompt: 'You are a cheerful vendor at a German farmers market selling fresh fruit and vegetables. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'train', title: 'Train Station', description: '', character: 'Station staff', difficulty: 'Intermediate', icon: Icons.train,
        systemPrompt: 'You are a helpful ticket agent at a German train station (Deutsche Bahn). Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'plans', title: 'Making Plans', description: '', character: 'German friend', difficulty: 'Intermediate', icon: Icons.calendar_today,
        systemPrompt: 'You are a good German friend planning a weekend together. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'doctor', title: "Doctor's Visit", description: '', character: 'Doctor', difficulty: 'Intermediate', icon: Icons.local_hospital,
        systemPrompt: 'You are a friendly doctor at a German medical practice. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'interview', title: 'Job Interview', description: '', character: 'HR manager', difficulty: 'Advanced', icon: Icons.work,
        systemPrompt: 'You are a professional HR manager at a German company conducting a job interview. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
      ScenarioConfig(
        id: 'apartment', title: 'Renting a Flat', description: '', character: 'Landlord', difficulty: 'Advanced', icon: Icons.apartment,
        systemPrompt: 'You are a German landlord showing an apartment to a potential tenant. Speak only in German. After every response add a blank line then an English translation in italics (prefix with "🇬🇧 "). If the user makes a grammar mistake, respond naturally first, then gently note the correction at the end with "💡 Tipp:". Keep responses short — 1 to 3 sentences.',
      ),
    ];
    try {
      return scenarios.firstWhere((s) => s.id == widget.scenarioId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadKey() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getString('anthropic_api_key');
    if (!mounted) return;
    setState(() => _apiKey = key);
    if (key == null) _showKeyDialog();
    else _sendOpener();
  }

  void _showKeyDialog({bool isChange = false}) async {
    final c = TextEditingController(text: isChange ? _apiKey : null);
    await showDialog<void>(
      context: context,
      barrierDismissible: isChange,
      builder: (ctx) => AlertDialog(
        title: const Text('Anthropic API Key'),
        content: TextField(
          controller: c,
          obscureText: true,
          decoration: const InputDecoration(hintText: 'sk-ant-...', labelText: 'API Key'),
        ),
        actions: [
          if (isChange)
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              final key = c.text.trim();
              if (key.isNotEmpty) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('anthropic_api_key', key);
                if (!mounted) return;
                setState(() => _apiKey = key);
              }
              if (ctx.mounted) Navigator.pop(ctx);
              if (_messages.isEmpty) _sendOpener();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendOpener() async {
    if (_scenario == null || _apiKey == null) return;
    setState(() => _loading = true);
    final reply = await _callApi('Bitte starte das Gespräch mit einer kurzen, natürlichen Eröffnung passend zur Situation.');
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (reply != null) _messages.add(_Msg(role: _Role.assistant, content: reply));
    });
    _scrollToBottom();
    if (reply != null) {
      final german = reply.split('\n').first.trim();
      if (german.isNotEmpty) AudioService().speak(german);
    }
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _loading || _apiKey == null) return;
    _input.clear();
    setState(() {
      _messages.add(_Msg(role: _Role.user, content: text));
      _loading = true;
    });
    _scrollToBottom();
    final reply = await _callApi(text);
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (reply != null) _messages.add(_Msg(role: _Role.assistant, content: reply));
    });
    _scrollToBottom();
    if (reply != null) {
      final german = reply.split('\n').first.trim();
      if (german.isNotEmpty) AudioService().speak(german);
    }
  }

  Future<String?> _callApi(String userContent) async {
    if (_scenario == null || _apiKey == null) return null;
    try {
      final history = _messages
          .map((m) => {'role': m.role == _Role.user ? 'user' : 'assistant', 'content': m.content})
          .toList();
      history.add({'role': 'user', 'content': userContent});

      final res = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'x-api-key': _apiKey!,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'model': 'claude-haiku-4-5-20251001',
          'max_tokens': 300,
          'system': _scenario!.systemPrompt,
          'messages': history,
        }),
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return (data['content'] as List).first['text'] as String;
      }
    } catch (_) {}
    return null;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scenario = _scenario;
    if (scenario == null) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text('Scenario not found')));
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scenario.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('with ${scenario.character}',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.key_outlined, color: AppColors.textSecondary),
            onPressed: () => _showKeyDialog(isChange: true),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_loading ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (i == _messages.length) return const _TypingIndicator();
                return _MessageBubble(message: _messages[i]);
              },
            ),
          ),
          _InputBar(
            controller: _input,
            loading: _loading,
            onSend: _send,
          ),
        ],
      ),
    );
  }
}

// ─── Message Bubble ────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final _Msg message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == _Role.user;
    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, left: 48),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(message.content,
              style: const TextStyle(color: Colors.white, fontSize: 15)),
        ),
      );
    }

    // Split assistant message into German part and English translation
    final parts = message.content.split('\n\n');
    final germanPart = parts.isNotEmpty ? parts[0].trim() : message.content;
    final englishPart = parts.length > 1 ? parts.sublist(1).join('\n\n').trim() : null;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 48),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TappableText(text: germanPart, sentence: germanPart),
            if (englishPart != null && englishPart.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                englishPart,
                style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () => AudioService().speak(germanPart),
              child: Icon(Icons.volume_up, size: 16, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tappable Text ─────────────────────────────────────────────────────────

class _TappableText extends StatelessWidget {
  final String text;
  final String sentence;
  const _TappableText({required this.text, required this.sentence});

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: words
          .map((word) => GestureDetector(
                onTap: () => _showExplanation(context, word, sentence),
                child: Text(
                  '$word ',
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ))
          .toList(),
    );
  }

  void _showExplanation(BuildContext context, String word, String sentence) {
    final clean = word.replaceAll(RegExp(r'[.,!?;:"""„]'), '');
    if (clean.isEmpty) return;
    WordDrillSheet.show(context, clean, sentence);
  }
}

// ─── Typing Indicator ─────────────────────────────────────────────────────

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 40,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

// ─── Input Bar ─────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final bool loading;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.loading,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 16, right: 8, top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Schreib auf Deutsch…',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: loading ? null : onSend,
            icon: const Icon(Icons.send),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

// ─── Internal types ────────────────────────────────────────────────────────

enum _Role { user, assistant }

class _Msg {
  final _Role role;
  final String content;
  const _Msg({required this.role, required this.content});
}
