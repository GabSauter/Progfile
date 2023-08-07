import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/views/certificate_view.dart';
import 'package:progfile/app/views/curriculum_register_view.dart';
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
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          /*if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else */
          if (snapshot.hasError) {
            return const Center(child: Text("Ops! Deu algo errado."));
          } else if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
        },
      ),
      routes: {
        '/register': (context) => RegisterView(),
        '/home': (context) => HomeView(),
        '/registerCurriculum': (context) => CurriculumRegisterView(),
        '/certificate': (context) => CertificateView(),
      },
    );
  }
}
