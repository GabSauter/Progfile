import 'package:flutter/material.dart';

import 'app/views/LoginView.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Inter',
          primaryColor: const Color(0xFF482FF7),
          scaffoldBackgroundColor: const Color(0xFFF8F7F5)),
      home: const LoginView(),
    );
  }
}
