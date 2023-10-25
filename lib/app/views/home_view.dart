import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/home_controller.dart';
import 'package:progfile/app/repositories/curriculum_reposiotory.dart';
import 'package:progfile/app/repositories/profile_repository.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:provider/provider.dart';

import 'components/snackbar_helper.dart';
import 'components/title_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = HomeController();

  void onSignOut(BuildContext context) async {
    try {
      await homeController.signOut();
      if (context.mounted) {
        context.read<CurriculumRepository>().reset();
        context.read<ProfileRepository>().reset();
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileRepository profileRepository = context.watch<ProfileRepository>();

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 80, right: 50, left: 50, bottom: 10),
        child: Column(
          children: [
            TitleText(
              text:
                  'Olá, ${profileRepository.myCurriculum().name.split(' ')[0]}!',
            ),
            const SizedBox(height: 80),
            MainButton(
              text: 'Meu Curriculo',
              onPressedCallback: () =>
                  Navigator.pushNamed(context, '/myCurriculum'),
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Procurar Currículo',
              onPressedCallback: () => Navigator.pushNamed(context, '/search'),
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Editar Conta',
              onPressedCallback: () =>
                  Navigator.pushNamed(context, '/editAccount'),
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Logout',
              onPressedCallback: () => onSignOut(context),
            )
          ],
        ),
      ),
    );
  }
}
