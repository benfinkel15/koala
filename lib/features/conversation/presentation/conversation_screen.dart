import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:koala/core/constants/app_colors.dart';

const _proxyUrl = 'https://koala-proxy.koala-proxy.workers.dev';

enum _Role { user, assistant }

class _ChatMessage {
  final _Role role;
  final String content;
  const _ChatMessage({required this.role, required this.content});
}

const _scenarioPrompts = {
  'Café': 'You are a German waiter at a cozy Bavarian café. Always reply in German. After your German response, write a blank line and then an English translation. If the user makes a grammar mistake, respond naturally but add a brief gentle correction at the end.',
  'Meeting someone': 'You are a friendly German local meeting someone new at a park. Always reply in German. After your German response, write a blank line and then an English translation. If the user makes a grammar mistake, respond naturally but add a brief gentle correction at the end.',
  'At the market': 'You are a vendor at a German farmers market. Always reply in German. After your German response, write a blank line and then an English translation. If the user makes a grammar mistake, respond naturally but add a brief gentle correction at the end.',
  'Free chat': 'You are a friendly German conversation partner. Always reply in German. After your German response, write a blank line and then an English translation. If the user makes a grammar mistake, respond naturally but add a brief gentle correction at the end.',
};

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  String? _selectedScenario;
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading || _selectedScenario == null) {
      return;
    }
    final userMessage = _ChatMessage(role: _Role.user, content: text.trim());
    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });
    _inputController.clear();
    _scrollToBottom();

    try {
      final apiMessages = _messages
          .map((m) => {
                'role': m.role == _Role.user ? 'user' : 'assistant',
                'content': m.content,
              })
          .toList();

      final response = await http.post(
        Uri.parse('https://koala-proxy.koala-proxy.workers.dev'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'model': 'claude-haiku-5-5',
          'max_tokens': 1024,
          'system': _scenarioPrompts[_selectedScenario]!,
          'messages': apiMessages,
        }),
      );

      if (!mounted) return;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final content = (data['content'] as List).first['text'] as String;
        setState(() {
          _messages.add(_ChatMessage(role: _Role.assistant, content: content));
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('API error ${response.statusCode}')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connection error')),
      );
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_selectedScenario ?? 'Chat'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_selectedScenario != null)
            IconButton(
              icon: const Icon(Icons.swap_horiz),
              tooltip: 'Change scenario',
              onPressed: () => setState(() {
                _selectedScenario = null;
                _messages.clear();
              }),
            ),
        ],
      ),
      body: _selectedScenario == null ? _buildScenarioPicker() : _buildChat(),
    );
  }

  Widget _buildScenarioPicker() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a scenario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Practice speaking German in a real-life situation.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _ScenarioCard(
                  title: 'Café',
                  icon: Icons.coffee,
                  color: AppColors.unitColors[0],
                  onTap: () => setState(() => _selectedScenario = 'Café'),
                ),
                _ScenarioCard(
                  title: 'Meeting someone',
                  icon: Icons.people,
                  color: AppColors.unitColors[1],
                  onTap: () => setState(() => _selectedScenario = 'Meeting someone'),
                ),
                _ScenarioCard(
                  title: 'At the market',
                  icon: Icons.storefront,
                  color: AppColors.unitColors[2],
                  onTap: () => setState(() => _selectedScenario = 'At the market'),
                ),
                _ScenarioCard(
                  title: 'Free chat',
                  icon: Icons.chat_bubble,
                  color: AppColors.unitColors[3],
                  onTap: () => setState(() => _selectedScenario = 'Free chat'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChat() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length) {
                return const _TypingIndicator();
              }
              return _MessageBubble(message: _messages[index]);
            },
          ),
        ),
        _buildInputBar(),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _inputController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type in German...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white, size: 18),
                onPressed: () => _sendMessage(_inputController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ScenarioCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == _Role.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
        ),
        child: _buildContent(isUser),
      ),
    );
  }

  Widget _buildContent(bool isUser) {
    if (isUser) {
      return Text(
        message.content,
        style: const TextStyle(color: Colors.white),
      );
    }
    final parts = message.content.split('\n\n');
    if (parts.length >= 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(parts[0], style: const TextStyle(color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text(
            parts.sublist(1).join('\n\n'),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }
    return Text(
      message.content,
      style: const TextStyle(color: AppColors.textPrimary),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 40,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
