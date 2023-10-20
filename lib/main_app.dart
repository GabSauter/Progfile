import 'package:flutter/material.dart';
import 'package:progfile/app/models/curriculum_model.dart';
import 'package:progfile/app/repositories/curriculum_repository.dart';
import 'package:progfile/app/views/certificate_view.dart';
import 'package:progfile/app/views/competence_view.dart';
import 'package:progfile/app/views/curriculum_edit_view.dart';
import 'package:progfile/app/views/edit_account_view.dart';
import 'package:progfile/app/views/home_view.dart';
import 'package:progfile/app/views/language_view.dart';
import 'package:progfile/app/views/register_view.dart';
import 'package:progfile/app/views/search_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app/views/course_view.dart';
import 'app/views/curriculum_view.dart';
import 'app/views/login_view.dart';
import 'app/views/my_curriculum_view.dart';
import 'app/views/git_project_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CurriculumModel myCurriculum =
        context.watch<CurriculumRepository>().myCurriculum();

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
          if (snapshot.hasError) {
            return const Center(child: Text("Ops! Deu algo errado."));
          } else if (snapshot.hasData) {
            return HomeView();
          } else {
            return const LoginView();
          }
        },
      ),
      routes: {
        '/register': (context) => const RegisterView(),
        '/home': (context) => HomeView(),
        '/myCurriculum': (context) =>
            MyCurriculumView(userRepository: myCurriculum),
        '/curriculumEdit': (context) => const CurriculumEditView(),
        '/certificate': (context) => const CertificateView(),
        '/search': (context) => const SearchView(),
        '/curriculum': (context) => CurriculumView(),
        '/course': (context) => const CourseView(),
        '/language': (context) => const LanguageView(),
        '/repository': (context) => const GitProjectView(),
        '/competence': (context) => const CompetenceView(),
        '/editAccount': (context) => EditAccountView(),
      },
    );
  }
}
