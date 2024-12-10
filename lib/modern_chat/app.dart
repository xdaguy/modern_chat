import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_chat/modern_chat/screens/home_screen.dart';
import 'package:modern_chat/modern_chat/screens/splash_screen.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';

class ModernChatApp extends StatelessWidget {
  const ModernChatApp({super.key});

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
    );

    // Force the orientation to portrait only
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Chat UI Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          background: AppColors.background,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      builder: (context, child) {
        // This ensures the navigation bar color is consistent throughout the app
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.background,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
} 