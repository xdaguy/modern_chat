import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_chat/modern_chat/models/chat_message.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/chat_bubble.dart';
import 'package:modern_chat/modern_chat/widgets/message_input.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';
import 'package:modern_chat/modern_chat/screens/profile_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;

  const ChatDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToBottom = false;
  bool _isAttachmentVisible = false;
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _messages = _getMessagesForUser(widget.user.id);
  }

  List<ChatMessage> _getMessagesForUser(String userId) {
    switch (userId) {
      case '1': // Emma Watson
        return [
          ChatMessage(
            id: '1',
            message: "Hey! I just reviewed the latest UI designs 🎨",
            senderId: '1',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          ),
          ChatMessage(
            id: '2',
            message: "What do you think about the color scheme?",
            senderId: '1',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
          ),
          ChatMessage(
            id: '3',
            message: "I love it! The new palette looks much more modern",
            senderId: 'me',
            receiverId: '1',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          ),
          ChatMessage(
            id: '4',
            message: "Great! I'll prepare the presentation for tomorrow then 📊",
            senderId: '1',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
          ),
        ];

      case '2': // James Rodriguez
        return [
          ChatMessage(
            id: '1',
            message: "Did you get a chance to check the code review? 💻",
            senderId: '2',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          ),
          ChatMessage(
            id: '2',
            message: "Yes, just finished. Great work on the optimization!",
            senderId: 'me',
            receiverId: '2',
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          ),
          ChatMessage(
            id: '3',
            message: "Thanks! I'll deploy it to staging now",
            senderId: '2',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          ),
        ];

      case '3': // Sophia Chen
        return [
          ChatMessage(
            id: '1',
            message: "Meeting in 30 minutes! 🕐",
            senderId: '3',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
          ),
          ChatMessage(
            id: '2',
            message: "I'll prepare the demo",
            senderId: 'me',
            receiverId: '3',
            timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
          ),
          ChatMessage(
            id: '3',
            message: "Perfect! Don't forget to include the new features",
            senderId: '3',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
          ),
          ChatMessage(
            id: '4',
            message: "Got it covered! See you soon 👍",
            senderId: 'me',
            receiverId: '3',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          ),
        ];

      case '4': // Marcus Johnson
        return [
          ChatMessage(
            id: '1',
            message: "The client loved our proposal! 🎉",
            senderId: '4',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
          ),
          ChatMessage(
            id: '2',
            message: "That's fantastic news! When do we start?",
            senderId: 'me',
            receiverId: '4',
            timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
          ),
          ChatMessage(
            id: '3',
            message: "Next week! I'll send the schedule shortly",
            senderId: '4',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
          ),
        ];

      case '5': // Isabella Martinez
        return [
          ChatMessage(
            id: '1',
            message: "How's the new feature coming along? 🛠️",
            senderId: '5',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          ),
          ChatMessage(
            id: '2',
            message: "Almost done! Just fixing some minor bugs",
            senderId: 'me',
            receiverId: '5',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
          ChatMessage(
            id: '3',
            message: "Great progress! Need any help?",
            senderId: '5',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ];

      case '6': // Alexander White
        return [
          ChatMessage(
            id: '1',
            message: "Team lunch today? 🍕",
            senderId: '6',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          ),
          ChatMessage(
            id: '2',
            message: "Count me in! Where are we going?",
            senderId: 'me',
            receiverId: '6',
            timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          ),
          ChatMessage(
            id: '3',
            message: "The new Italian place downtown, 1 PM?",
            senderId: '6',
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(hours: 3)),
          ),
        ];

      default:
        return [
          ChatMessage(
            id: '1',
            message: "Hi there! 👋",
            senderId: userId,
            receiverId: 'me',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          ),
          ChatMessage(
            id: '2',
            message: "Hello! How can I help you?",
            senderId: 'me',
            receiverId: userId,
            timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          ),
        ];
    }
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final showScrollToBottom =
          _scrollController.position.pixels > 500; // Adjust threshold as needed
      if (showScrollToBottom != _showScrollToBottom) {
        setState(() {
          _showScrollToBottom = showScrollToBottom;
        });
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/chat_bg.png'),
                          fit: BoxFit.cover,
                          opacity: 0.5,
                        ),
                      ),
                    ),
                    ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        return ChatBubble(
                          message: message.message,
                          isSent: message.senderId == 'me',
                          timestamp: message.timestamp,
                        );
                      },
                    ),
                    if (_showScrollToBottom)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: AppColors.primary,
                          onPressed: _scrollToBottom,
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                  ],
                ),
              ),
              if (_isAttachmentVisible) _buildAttachmentOptions(),
              MessageInput(
                controller: _messageController,
                onSend: _handleSendMessage,
                onAttachment: _toggleAttachmentOptions,
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(user: widget.user),
          ),
        ),
        child: Row(
          children: [
            UserAvatar(
              imageUrl: widget.user.avatarUrl,
              isOnline: widget.user.isOnline,
              size: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.user.isOnline ? 'online' : 'offline',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.call, color: Colors.white),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            // Handle menu selection
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view_contact',
              child: Text('View Contact'),
            ),
            const PopupMenuItem(
              value: 'media',
              child: Text('Media, links, and docs'),
            ),
            const PopupMenuItem(
              value: 'search',
              child: Text('Search'),
            ),
            const PopupMenuItem(
              value: 'mute',
              child: Text('Mute notifications'),
            ),
            const PopupMenuItem(
              value: 'wallpaper',
              child: Text('Wallpaper'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachmentOptions() {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _AttachmentOption(
            icon: Icons.image,
            label: 'Gallery',
            color: Colors.purple,
            onTap: () {},
          ),
          _AttachmentOption(
            icon: Icons.camera_alt,
            label: 'Camera',
            color: Colors.red,
            onTap: () {},
          ),
          _AttachmentOption(
            icon: Icons.insert_drive_file,
            label: 'Document',
            color: Colors.blue,
            onTap: () {},
          ),
          _AttachmentOption(
            icon: Icons.location_on,
            label: 'Location',
            color: Colors.green,
            onTap: () {},
          ),
          _AttachmentOption(
            icon: Icons.person,
            label: 'Contact',
            color: Colors.orange,
            onTap: () {},
          ),
          _AttachmentOption(
            icon: Icons.music_note,
            label: 'Audio',
            color: Colors.pink,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            id: DateTime.now().toString(),
            message: _messageController.text,
            senderId: 'me',
            receiverId: widget.user.id,
            timestamp: DateTime.now(),
          ),
        );
      });
      _messageController.clear();
    }
  }

  void _toggleAttachmentOptions() {
    setState(() {
      _isAttachmentVisible = !_isAttachmentVisible;
    });
  }
}

class _AttachmentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachmentOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.subtitle,
          ),
        ],
      ),
    );
  }
} 