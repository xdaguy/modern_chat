import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/models/chat_message.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/chat_bubble.dart';
import 'package:modern_chat/modern_chat/widgets/message_input.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    // Sample messages for UI demonstration
    ChatMessage(
      id: '1',
      message: 'Hey! How are you?',
      senderId: '1',
      receiverId: '2',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage(
      id: '2',
      message: 'I\'m good, thanks! How about you?',
      senderId: '2',
      receiverId: '1',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      id: '3',
      message: 'I\'m doing great! Working on a new project.',
      senderId: '1',
      receiverId: '2',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const UserAvatar(
              isOnline: true,
              size: 36,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: AppTextStyles.heading2.copyWith(fontSize: 16),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.online,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  message: message.message,
                  isSent: message.senderId == '1',
                  timestamp: message.timestamp,
                );
              },
            ),
          ),
          MessageInput(
            controller: _messageController,
            onSend: () {
              if (_messageController.text.trim().isNotEmpty) {
                // Add message handling logic here
                _messageController.clear();
              }
            },
            onAttachment: () {
              // Add attachment handling logic here
            },
          ),
        ],
      ),
    );
  }
} 