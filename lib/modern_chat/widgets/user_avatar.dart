import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';

/// A widget that displays a user's avatar with online status indicator
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool isOnline;
  final double size;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.isOnline = false,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondaryBackground,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Icon(
              Icons.person,
              size: size * 0.6,
              color: AppColors.textSecondary,
            )
          : null,
    );
  }
} 