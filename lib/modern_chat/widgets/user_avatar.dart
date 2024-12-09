import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: size,
              height: size,
              placeholder: (context, url) => Container(
                color: AppColors.secondaryBackground,
                child: Icon(
                  Icons.person,
                  size: size * 0.6,
                  color: AppColors.textSecondary,
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.person,
                size: size * 0.6,
                color: AppColors.textSecondary,
              ),
            )
          : Icon(
              Icons.person,
              size: size * 0.6,
              color: AppColors.textSecondary,
            ),
    );
  }
} 