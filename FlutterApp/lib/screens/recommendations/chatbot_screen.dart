import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/field.dart';
import '../../config/app_theme.dart';

class ChatBotScreen extends StatefulWidget {
  final Field? initialField;

  const ChatBotScreen({super.key, this.initialField});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _messages.add({
      'role': 'bot',
      'text': 'Hello! I am AgriBot, your personal farming AI.\nI have real-time access to your farm\'s sensors. Ask me anything about watering, conditions, or crop choices!',
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });
    
    _messageController.clear();
    
    try {
      final response = await _apiService.sendChatMessage(text, fieldId: widget.initialField?.fieldId);
      if (response['success'] == true && mounted) {
        setState(() {
          _messages.add({'role': 'bot', 'text': response['reply']});
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add({'role': 'bot', 'text': 'Oops! Something went wrong reaching the AI engine.'});
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildSuggestionChip(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: ActionChip(
        label: Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.primaryGreen, fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
        ),
        onPressed: () {
          if (_isLoading) return;
          _messageController.text = text;
          _sendMessage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('🤖'),
            const SizedBox(width: 10),
            const Text('AgriBot AI'),
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    margin: EdgeInsets.only(bottom: 12, left: isUser ? 40 : 0, right: isUser ? 0 : 40),
                    decoration: BoxDecoration(
                      color: isUser ? AppTheme.primaryGreen : Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
                        bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : AppTheme.textPrimary,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) 
             const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                     SizedBox(width: 16),
                     SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryGreen)),
                     SizedBox(width: 12),
                     Text('AgriBot is typing...', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                  ]
                )
             ),
             
          // Fast Suggested Questions (Quick Actions)
          Container(
            height: 45,
            margin: const EdgeInsets.only(bottom: 4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSuggestionChip('Should I turn on the pump?'),
                _buildSuggestionChip('What crop should I grow?'),
                _buildSuggestionChip('Give me a health report'),
                _buildSuggestionChip('Is my field too hot?'),
                _buildSuggestionChip('Is my soil too dry?'),
                _buildSuggestionChip('How is the humidity?'),
                _buildSuggestionChip('Can I grow wheat now?'),
                _buildSuggestionChip('What type of soil do I have?'),
                _buildSuggestionChip('Can I grow rice?'),
                _buildSuggestionChip('When to plant cotton?'),
                _buildSuggestionChip('Will it rain today?'),
                _buildSuggestionChip('Help me with my farm'),
              ],
            ),
          ),
             
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -2), blurRadius: 10),
              ]
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask about sensors or crops...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppTheme.backgroundColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded, color: Colors.white),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
