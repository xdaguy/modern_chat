import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:modern_chat/modern_chat/models/chat_message.dart';
import 'package:modern_chat/modern_chat/models/chat_user.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';
import 'package:modern_chat/modern_chat/widgets/chat_bubble.dart';
import 'package:modern_chat/modern_chat/widgets/message_input.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';
import 'package:modern_chat/modern_chat/screens/profile_screen.dart';
import 'package:modern_chat/modern_chat/screens/shared_content_screen.dart';
import 'package:modern_chat/modern_chat/utils/page_routes.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;

  const ChatDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToBottom = false;
  bool _isAttachmentVisible = false;
  bool _showEmojiPicker = false;
  late List<ChatMessage> _messages;
  late AnimationController _attachmentAnimationController;
  late Animation<double> _attachmentSlideAnimation;
  late Animation<double> _attachmentFadeAnimation;
  late AnimationController _backgroundAnimationController;
  late Animation<double> _patternAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _messages = _getMessagesForUser(widget.user.id);
    
    _attachmentAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _attachmentSlideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _attachmentAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _attachmentFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _attachmentAnimationController,
      curve: Curves.easeOut,
    ));

    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _patternAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_backgroundAnimationController);
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
    _attachmentAnimationController.dispose();
    _backgroundAnimationController.dispose();
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
          _buildChatBackground(),
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _buildMessageList(),
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
                onEmojiTap: _toggleEmojiPicker,
                showEmojiPicker: _showEmojiPicker,
                onRecordingStateChanged: (isRecording) {},
              ),
              if (_showEmojiPicker) _buildEmojiPicker(),
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
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(user: widget.user),
            ),
          );
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Row(
          children: [
            UserAvatar(
              imageUrl: widget.user.avatarUrl,
              size: 40,
              isOnline: widget.user.isOnline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: AppTextStyles.subtitle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.user.isOnline ? 'Online' : 'Offline',
                    style: AppTextStyles.subtitle.copyWith(
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
            switch (value) {
              case 'view_contact':
                Navigator.push(
                  context,
                  FadePageRoute(
                    child: ProfileScreen(user: widget.user),
                  ),
                );
                break;
              case 'media':
                Navigator.push(
                  context,
                  SlidePageRoute(
                    child: SharedContentScreen(user: widget.user),
                    direction: SlideDirection.left,
                  ),
                );
                break;
              case 'search':
                _showSearchBar();
                break;
            }
          },
          itemBuilder: (context) => [
            _buildMenuItem(
              Icons.person,
              'View Contact',
              'view_contact',
            ),
            _buildMenuItem(
              Icons.photo_library,
              'Media, Links, and Docs',
              'media',
            ),
            _buildMenuItem(
              Icons.search,
              'Search',
              'search',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    if (_isSearching && _searchQuery.isNotEmpty) {
      final filteredMessages = _messages.where((message) =>
          message.message.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
      
      if (filteredMessages.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No messages found',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        reverse: true,
        itemCount: filteredMessages.length,
        itemBuilder: (context, index) {
          final message = filteredMessages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ChatBubble(
              message: message.message,
              isSent: message.senderId == 'me',
              timestamp: message.timestamp,
              isRead: message.isRead,
              reactions: const [],
              onReactionTap: (emoji) {},
              onLongPress: () {},
              onDoubleTap: () {},
            ),
          );
        },
      );
    }
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Dismissible(
          key: Key(message.id),
          direction: message.senderId == 'me'
              ? DismissDirection.endToStart
              : DismissDirection.startToEnd,
          background: _buildSwipeBackground(message.senderId == 'me'),
          confirmDismiss: (direction) async {
            return false;
          },
          child: ChatBubble(
            message: message.message,
            isSent: message.senderId == 'me',
            timestamp: message.timestamp,
            isRead: message.isRead,
            reactions: const [],
            onReactionTap: (emoji) {},
            onLongPress: () {},
            onDoubleTap: () {},
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOptions() {
    final attachmentOptions = [
      _AttachmentOption(
        icon: Icons.photo_library,
        label: 'Gallery',
        color: Colors.purple,
        onTap: () {
          // Handle gallery selection
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.camera_alt,
        label: 'Camera',
        color: Colors.red,
        onTap: () {
          // Handle camera
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.insert_drive_file,
        label: 'Document',
        color: Colors.blue,
        onTap: () {
          // Handle document selection
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.location_on,
        label: 'Location',
        color: Colors.green,
        onTap: () {
          // Handle location sharing
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.person,
        label: 'Contact',
        color: Colors.orange,
        onTap: () {
          // Handle contact sharing
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.music_note,
        label: 'Audio',
        color: Colors.pink,
        onTap: () {
          // Handle audio selection
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.sticky_note_2,
        label: 'Note',
        color: Colors.teal,
        onTap: () {
          // Handle note creation
          _toggleAttachmentOptions();
        },
      ),
      _AttachmentOption(
        icon: Icons.poll,
        label: 'Poll',
        color: Colors.deepPurple,
        onTap: () {
          // Handle poll creation
          _toggleAttachmentOptions();
        },
      ),
    ];

    return AnimatedBuilder(
      animation: _attachmentAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 250 * _attachmentSlideAnimation.value),
          child: FadeTransition(
            opacity: _attachmentFadeAnimation,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          'Share Content',
                          style: AppTextStyles.heading2.copyWith(fontSize: 18),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _toggleAttachmentOptions,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: List.generate(attachmentOptions.length, (index) {
                        return AnimatedBuilder(
                          animation: _attachmentAnimationController,
                          builder: (context, child) {
                            final delay = index * 0.1;
                            final slideAnimation = Tween<double>(
                              begin: 1.0,
                              end: 0.0,
                            ).animate(CurvedAnimation(
                              parent: _attachmentAnimationController,
                              curve: Interval(
                                delay,
                                delay + 0.4,
                                curve: Curves.easeOutCubic,
                              ),
                            ));

                            return Transform.translate(
                              offset: Offset(0, 50 * slideAnimation.value),
                              child: Opacity(
                                opacity: 1 - slideAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: attachmentOptions[index],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Recent Files',
                            style: AppTextStyles.subtitle.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Show recent files
                          },
                          child: Text(
                            'See All',
                            style: AppTextStyles.subtitle.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      if (_isAttachmentVisible) {
        _attachmentAnimationController.forward();
      } else {
        _attachmentAnimationController.reverse();
      }
    });
  }

  Widget _buildSwipeBackground(bool isSent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.reply, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'Reply',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildEmojiCategory('Smileys', Icons.emoji_emotions_outlined),
                _buildEmojiCategory('Animals', Icons.pets),
                _buildEmojiCategory('Food', Icons.restaurant),
                _buildEmojiCategory('Activities', Icons.sports_soccer),
                _buildEmojiCategory('Travel', Icons.flight),
                _buildEmojiCategory('Objects', Icons.lightbulb_outline),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 40, // Sample count
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Insert emoji at cursor position
                    final text = _messageController.text;
                    final selection = _messageController.selection;
                    final emoji = '😀'; // Sample emoji
                    final newText = text.replaceRange(
                      selection.start,
                      selection.end,
                      emoji,
                    );
                    _messageController.value = TextEditingValue(
                      text: newText,
                      selection: TextSelection.collapsed(
                        offset: selection.start + emoji.length,
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      '😀',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiCategory(String title, IconData icon) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          // Switch emoji category
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: AppTextStyles.subtitle.copyWith(
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  Widget _buildChatBackground() {
    return Stack(
      children: [
        // Modern mesh gradient base
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF246BFD).withOpacity(0.15),  // Primary blue
                const Color(0xFF6B4DFF).withOpacity(0.1),   // Purple accent
                const Color(0xFF4DA8FF).withOpacity(0.08),  // Light blue
                AppColors.background,
              ],
              stops: const [0.0, 0.3, 0.6, 1.0],
            ),
          ),
        ),
        // Soft color overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color(0xFF4DA8FF).withOpacity(0.1),   // Light blue
                Colors.transparent,
                const Color(0xFF6B4DFF).withOpacity(0.05),  // Purple accent
                const Color(0xFF246BFD).withOpacity(0.08),  // Primary blue
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
            ),
          ),
        ),
        // Animated pattern overlay
        AnimatedBuilder(
          animation: _patternAnimation,
          builder: (context, child) {
            return CustomPaint(
              painter: ChatBackgroundPainter(
                animation: _patternAnimation.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        // Mesh blur overlay for depth
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.5, -0.5),
              radius: 1.5,
              colors: [
                const Color(0xFF4DA8FF).withOpacity(0.05),  // Light blue
                Colors.transparent,
                const Color(0xFF6B4DFF).withOpacity(0.03),  // Purple accent
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        // Additional mesh blur for more depth
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.5, 0.8),
              radius: 1.2,
              colors: [
                const Color(0xFF246BFD).withOpacity(0.08),  // Primary blue
                Colors.transparent,
                const Color(0xFF4DA8FF).withOpacity(0.05),  // Light blue
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        // Top fade for better readability
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background.withOpacity(0.9),
                AppColors.background.withOpacity(0.0),
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        // Bottom fade for better readability
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.background.withOpacity(0.9),
                  AppColors.background.withOpacity(0.0),
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _showSearchBar() {
    setState(() {
      _isSearching = true;
      _searchQuery = '';
    });
  }

  void _hideSearchBar() {
    setState(() {
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  PopupMenuItem<String> _buildMenuItem(IconData icon, String title, String value) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBackgroundPainter extends CustomPainter {
  final double animation;

  ChatBackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final wavePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final circlePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.02)
      ..style = PaintingStyle.fill;

    // Draw animated wave patterns
    final path = Path();
    final waveCount = 5;
    final frequency = 2 * pi / canvasSize.width * 2;
    final baseAmplitude = canvasSize.height / 20;

    for (int i = 0; i < waveCount; i++) {
      final amplitude = baseAmplitude * (1 + i * 0.5);
      final phase = animation + i * pi / waveCount;
      path.moveTo(0, canvasSize.height / 2);

      for (double x = 0; x <= canvasSize.width; x += 5) {
        final y = canvasSize.height / 2 +
            sin(x * frequency + phase) * amplitude +
            cos(x * frequency * 0.5 + phase) * amplitude * 0.5;
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, wavePaint);

    // Draw grid pattern
    final spacing = 30.0;
    final dotSize = 3.0;

    for (double x = 0; x < canvasSize.width; x += spacing) {
      for (double y = 0; y < canvasSize.height; y += spacing) {
        final offset = sin(animation + (x + y) / 100) * 5;
        canvas.drawCircle(
          Offset(x + offset, y + offset),
          dotSize,
          paint,
        );
      }
    }

    // Draw floating circles
    final random = Random(42); // Fixed seed for consistent pattern
    for (int i = 0; i < 30; i++) {
      final baseX = random.nextDouble() * canvasSize.width;
      final baseY = random.nextDouble() * canvasSize.height;
      final radius = random.nextDouble() * 40 + 20;
      
      final x = baseX + sin(animation + i) * 10;
      final y = baseY + cos(animation + i) * 10;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        circlePaint,
      );
    }

    // Draw geometric shapes
    final shapePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < 10; i++) {
      final baseX = random.nextDouble() * canvasSize.width;
      final baseY = random.nextDouble() * canvasSize.height;
      final shapeSize = random.nextDouble() * 60 + 40;
      
      final x = baseX + sin(animation + i * 0.5) * 15;
      final y = baseY + cos(animation + i * 0.5) * 15;
      
      final path = Path();
      if (i % 3 == 0) {
        // Hexagon
        for (int j = 0; j < 6; j++) {
          final angle = j * pi / 3 + animation;
          final point = Offset(
            x + cos(angle) * shapeSize,
            y + sin(angle) * shapeSize,
          );
          j == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
        }
        path.close();
      } else if (i % 3 == 1) {
        // Triangle
        for (int j = 0; j < 3; j++) {
          final angle = j * 2 * pi / 3 + animation;
          final point = Offset(
            x + cos(angle) * shapeSize,
            y + sin(angle) * shapeSize,
          );
          j == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
        }
        path.close();
      } else {
        // Square
        path.addRect(Rect.fromCenter(
          center: Offset(x, y),
          width: shapeSize,
          height: shapeSize,
        ));
      }
      canvas.drawPath(path, shapePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ChatBackgroundPainter oldDelegate) {
    return oldDelegate.animation != animation;
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