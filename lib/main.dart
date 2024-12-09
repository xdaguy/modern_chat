import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modern_chat/modern_chat/screens/home_screen.dart';
import 'package:modern_chat/modern_chat/screens/chat_detail_screen.dart';
import 'package:modern_chat/modern_chat/screens/status_view_screen.dart';
import 'package:modern_chat/modern_chat/theme/app_colors.dart';

void main() {
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
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/status_view': (context) => const StatusViewScreen(),
      },
    );
  }
}
