import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';

/// This class contains all the text styles used in the Modern Chat UI Kit
/// Centralizing text styles helps maintain consistency throughout the app
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle chatMessage = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
} 