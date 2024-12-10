import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' show pi;
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/theme/app_text_styles.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachment;
  final VoidCallback? onEmojiTap;
  final Function(bool)? onRecordingStateChanged;
  final bool showEmojiPicker;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachment,
    this.onEmojiTap,
    this.onRecordingStateChanged,
    this.showEmojiPicker = false,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput>
    with TickerProviderStateMixin {
  bool _isComposing = false;
  bool _isRecording = false;
  double _recordingWidth = 0;
  late AnimationController _recordingAnimationController;
  late Animation<double> _recordingAnimation;
  late AnimationController _sendButtonController;
  late Animation<double> _sendButtonAnimation;
  bool _showSendButton = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
    
    _recordingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _recordingAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _recordingAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _sendButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _sendButtonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _sendButtonController,
        curve: Curves.easeOut,
      ),
    );
  }

  void _handleTextChange() {
    final isComposing = widget.controller.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
        if (isComposing && !_showSendButton) {
          _showSendButton = true;
          _sendButtonController.forward();
        } else if (!isComposing && _showSendButton) {
          _showSendButton = false;
          _sendButtonController.reverse();
        }
      });
    }
  }

  void _handleRecordingStart() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isRecording = true;
      _recordingWidth = 0;
    });
    widget.onRecordingStateChanged?.call(true);
    _recordingAnimationController.forward();
  }

  void _handleRecordingEnd() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isRecording = false;
    });
    widget.onRecordingStateChanged?.call(false);
    _recordingAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                widget.showEmojiPicker
                    ? Icons.keyboard
                    : Icons.emoji_emotions_outlined,
                color: AppColors.primary,
              ),
              onPressed: widget.onEmojiTap,
            ),
            IconButton(
              icon: const Icon(
                Icons.attach_file,
                color: AppColors.primary,
              ),
              onPressed: widget.onAttachment,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 48,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _isRecording 
                                ? const SizedBox() 
                                : TextField(
                                    controller: widget.controller,
                                    style: AppTextStyles.bodyText,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: 'Message',
                                      hintStyle: AppTextStyles.subtitle.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                          ),
                          if (_isComposing)
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                // Handle quick camera capture
                              },
                              constraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (_isRecording)
                    AnimatedBuilder(
                      animation: _recordingAnimation,
                      builder: (context, child) {
                        return Container(
                          width: MediaQuery.of(context).size.width *
                              0.6 *
                              _recordingAnimation.value,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Icon(
                                    Icons.mic,
                                    color: AppColors.primary,
                                    size: 24 * _recordingAnimation.value,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    'Recording...',
                                    style: AppTextStyles.subtitle.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(0.3),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onLongPressStart: (_) => _handleRecordingStart(),
              onLongPressEnd: (_) => _handleRecordingEnd(),
              child: AnimatedBuilder(
                animation: _sendButtonAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _sendButtonAnimation.value * -pi / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isComposing ? Icons.send : Icons.mic,
                          size: 20,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        onPressed: _isComposing ? widget.onSend : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    _recordingAnimationController.dispose();
    _sendButtonController.dispose();
    super.dispose();
  }
} 