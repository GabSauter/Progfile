import 'package:flutter/material.dart';
import 'package:progfile/app/views/home_view.dart';
import 'package:progfile/app/views/register_view.dart';

import 'app/views/login_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        scaffoldBackgroundColor: const Color(0xFFF8F7F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/register': (context) => RegisterView(),
        '/home': (context) => const HomeView(),
      },
    );
  }
}
