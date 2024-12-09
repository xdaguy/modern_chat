import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';
import 'package:modern_chat/modern_chat/widgets/user_avatar.dart';

/// A widget that displays a story ring around the user avatar
class StoryRing extends StatelessWidget {
  final String? imageUrl;
  final bool isViewed;
  final bool isOwn;
  final double size;
  final VoidCallback? onTap;

  const StoryRing({
    super.key,
    this.imageUrl,
    this.isViewed = false,
    this.isOwn = false,
    this.size = 56,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isViewed
              ? null
              : const LinearGradient(
                  colors: [
                    Color(0xFF9844FF),
                    Color(0xFF5C43FF),
                    Color(0xFF4DA8FF),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
          color: isViewed ? AppColors.textSecondary : null,
        ),
        child: Stack(
          children: [
            UserAvatar(
              imageUrl: imageUrl,
              size: size - 6,
            ),
            if (isOwn)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.background,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 