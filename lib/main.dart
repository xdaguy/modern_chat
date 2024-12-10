import 'package:flutter/material.dart';
import 'package:modern_chat/modern_chat/app.dart';

void main() async {
  await ModernChatApp.initialize();
  runApp(const ModernChatApp());
}
