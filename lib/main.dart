import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/views/certificate_view.dart';
import 'package:progfile/app/views/curriculum_edit_view.dart';
import 'package:progfile/app/views/home_view.dart';
import 'package:progfile/app/views/language_view.dart';
import 'package:progfile/app/views/register_view.dart';
import 'package:progfile/app/views/search_view.dart';
import 'app/views/course_view.dart';
import 'app/views/login_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'app/views/my_curriculum_view.dart';
import 'app/views/repository_view.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: const Color.fromARGB(255, 129, 110, 255),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 129, 110, 255),
          secondary: const Color(0xFF46C3DB),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // } else
          if (snapshot.hasError) {
            return const Center(child: Text("Ops! Deu algo errado."));
          } else if (snapshot.hasData) {
            return HomeView();
          } else {
            return LoginView();
          }
          // } else {
          //   return HomeView();
          // }
        },
      ),
      routes: {
        '/register': (context) => RegisterView(),
        '/home': (context) => HomeView(),
        '/myCurriculum': (context) => const MyCurriculumView(),
        '/curriculumEdit': (context) => const CurriculumEditView(),
        '/certificate': (context) => const CertificateView(),
        '/search': (context) => const SearchView(),
        '/course': (context) => const CourseView(),
        '/language': (context) => const LanguageView(),
        '/repository': (context) => const RepositoryView(),
      },
    );
  }
}
