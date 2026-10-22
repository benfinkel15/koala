import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koala/core/constants/app_colors.dart';
import 'package:koala/features/learn/presentation/learn_screen.dart';
import 'package:koala/services/audio_service.dart';
import 'package:koala/services/usage_tracker.dart';
import 'package:koala/widgets/word_drill_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScenarioScreen extends StatefulWidget {
  final String scenarioId;
  const ScenarioScreen({super.key, required this.scenarioId});

  @override
  State<ScenarioScreen> createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends State<ScenarioScreen> {
  static const _embedded = String.fromEnvironment('ANTHROPIC_KEY', defaultValue: '');

  ScenarioConfig? _scenario;
  String? _apiKey;
  final List<_Msg> _messages = [];
  bool _loading = false;
  bool _overLimit = false;
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    try {
      _scenario = allScenarios.firstWhere((s) => s.id == widget.scenarioId);
    } catch (_) {}
    _loadKey();
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _loadKey() async {
    // Stored key takes priority so the user can override a bad embedded key
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('anthropic_api_key');
    final key = (stored != null && stored.isNotEmpty) ? stored : (_embedded.isNotEmpty ? _embedded : null);
    if (!mounted) return;
    setState(() => _apiKey = key);
    if (key == null) {
      _showKeyDialog();
    } else {
      _sendOpener();
    }
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
          decoration:
              const InputDecoration(hintText: 'sk-ant-...', labelText: 'API Key'),
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
    if (await UsageTracker.isOverLimit()) {
      if (mounted) setState(() => _overLimit = true);
      return;
    }
    setState(() => _loading = true);
    final opener = _scenario!.language == 'nl'
        ? 'Begin het gesprek met een korte, natuurlijke openingszin die past bij de situatie.'
        : _scenario!.language == 'da'
            ? 'Start samtalen med en kort, naturlig åbningssætning, der passer til situationen.'
            : 'Bitte starte das Gespräch mit einer kurzen, natürlichen Eröffnung passend zur Situation.';
    final reply = await _callApi(opener);
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (reply != null) _messages.add(_Msg(role: _Role.assistant, content: reply));
    });
    _scrollToBottom();
    if (reply != null) {
      final firstLine = reply.split('\n').first.trim();
      if (firstLine.isNotEmpty) AudioService().speak(firstLine, langCode: _scenario!.language);
    }
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty || _loading || _apiKey == null) return;
    if (await UsageTracker.isOverLimit()) {
      if (mounted) setState(() => _overLimit = true);
      return;
    }
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
      final firstLine = reply.split('\n').first.trim();
      if (firstLine.isNotEmpty) AudioService().speak(firstLine, langCode: _scenario!.language);
    }
  }

  Future<String?> _callApi(String userContent) async {
    if (_scenario == null || _apiKey == null) return null;
    try {
      final history = _messages
          .map((m) => {
                'role': m.role == _Role.user ? 'user' : 'assistant',
                'content': m.content
              })
          .toList();
      history.add({'role': 'user', 'content': userContent});

      final res = await http.post(
        Uri.parse('https://api.anthropic.com/v1/messages'),
        headers: {
          'x-api-key': _apiKey!,
          'anthropic-version': '2023-06-01',
          'content-type': 'application/json',
          'anthropic-dangerous-direct-browser-access': 'true',
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
        final usage = data['usage'] as Map<String, dynamic>?;
        if (usage != null) {
          await UsageTracker.record(
            usage['input_tokens'] as int? ?? 0,
            usage['output_tokens'] as int? ?? 0,
          );
        }
        return (data['content'] as List).first['text'] as String;
      }
      if (mounted) {
        final body = res.body.length > 200 ? '${res.body.substring(0, 200)}…' : res.body;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('API error ${res.statusCode}: $body'),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 10),
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connection error — check your API key (🔑): $e'),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 10),
        ));
      }
    }
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
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(scenario.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          if (_apiKey == null)
            GestureDetector(
              onTap: () => _showKeyDialog(isChange: true),
              child: Container(
                width: double.infinity,
                color: AppColors.accent.withValues(alpha: 0.15),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.key, size: 16, color: AppColors.accent),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Tap here to enter your Anthropic API key and start chatting.',
                        style: TextStyle(fontSize: 13, color: AppColors.accent),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.accent, size: 18),
                  ],
                ),
              ),
            ),
          if (_overLimit)
            Container(
              width: double.infinity,
              color: AppColors.incorrect.withValues(alpha: 0.12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.block, size: 16, color: AppColors.incorrect),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Monthly \$${UsageTracker.limitDollars.toStringAsFixed(0)} AI limit reached — resets on the 1st.',
                      style: const TextStyle(
                          color: AppColors.incorrect, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_loading ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (i == _messages.length) return const _TypingIndicator();
                return _MessageBubble(
                    message: _messages[i], language: scenario.language);
              },
            ),
          ),
          _InputBar(
            controller: _input,
            loading: _loading || _overLimit,
            onSend: _send,
            language: scenario.language,
          ),
        ],
      ),
    );
  }
}

// ─── Message Bubble ────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final _Msg message;
  final String language;
  const _MessageBubble({required this.message, required this.language});

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

    final parts = message.content.split('\n\n');
    final targetLangPart = parts.isNotEmpty ? parts[0].trim() : message.content;
    final englishPart =
        parts.length > 1 ? parts.sublist(1).join('\n\n').trim() : null;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 48),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
                color: Colors.brown.withValues(alpha: 0.05), blurRadius: 4)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TappableText(
                text: targetLangPart, sentence: targetLangPart, language: language),
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
              onTap: () => AudioService().speak(targetLangPart, langCode: language),
              child: Icon(Icons.volume_up,
                  size: 16, color: AppColors.textSecondary),
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
  final String language;
  const _TappableText(
      {required this.text, required this.sentence, required this.language});

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
    WordDrillSheet.show(context, clean, sentence, langCode: language);
  }
}

// ─── Typing Indicator ──────────────────────────────────────────────────────

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
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.08)),
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
  final String language;

  const _InputBar({
    required this.controller,
    required this.loading,
    required this.onSend,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final hint = language == 'nl'
        ? 'Schrijf in het Nederlands…'
        : language == 'da'
            ? 'Skriv på dansk…'
            : 'Schreib auf Deutsch…';
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.only(
        left: 16,
        right: 8,
        top: 8,
        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      BorderSide(color: Colors.brown.withValues(alpha: 0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      BorderSide(color: Colors.brown.withValues(alpha: 0.2)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
