import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSent;
  final DateTime timestamp;
  final bool isRead;
  final List<String> reactions;
  final Function(String)? onReactionTap;
  final Function()? onLongPress;
  final Function()? onDoubleTap;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSent,
    required this.timestamp,
    this.isRead = false,
    this.reactions = const [],
    this.onReactionTap,
    this.onLongPress,
    this.onDoubleTap,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _showReactions = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Stack(
        children: [
          GestureDetector(
            onLongPress: () {
              setState(() {
                _showReactions = !_showReactions;
              });
              widget.onLongPress?.call();
            },
            onDoubleTap: widget.onDoubleTap,
            child: Container(
              margin: EdgeInsets.only(
                left: widget.isSent ? 64 : 16,
                right: widget.isSent ? 16 : 64,
                top: 4,
                bottom: widget.reactions.isEmpty ? 4 : 20,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: widget.isSent ? AppColors.sentMessage : AppColors.receivedMessage,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomRight: widget.isSent ? const Radius.circular(4) : null,
                  bottomLeft: !widget.isSent ? const Radius.circular(4) : null,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    widget.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: AppTextStyles.chatMessage.copyWith(
                      color: widget.isSent ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(widget.timestamp),
                        style: AppTextStyles.subtitle.copyWith(
                          fontSize: 12,
                          color: widget.isSent ? Colors.white70 : AppColors.textSecondary,
                        ),
                      ),
                      if (widget.isSent) ...[
                        const SizedBox(width: 4),
                        Icon(
                          widget.isRead ? Icons.done_all : Icons.done,
                          size: 14,
                          color: widget.isRead ? Colors.white : Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.reactions.isNotEmpty)
            Positioned(
              bottom: 0,
              right: widget.isSent ? 24 : null,
              left: widget.isSent ? null : 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.reactions.map((reaction) {
                    return GestureDetector(
                      onTap: () => widget.onReactionTap?.call(reaction),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          reaction,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          if (_showReactions)
            Positioned(
              bottom: 40,
              right: widget.isSent ? 24 : null,
              left: widget.isSent ? null : 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildReactionButton('❤️'),
                    _buildReactionButton('👍'),
                    _buildReactionButton('😂'),
                    _buildReactionButton('😮'),
                    _buildReactionButton('😢'),
                    _buildReactionButton('🙏'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(String emoji) {
    return GestureDetector(
      onTap: () {
        widget.onReactionTap?.call(emoji);
        setState(() {
          _showReactions = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
} 