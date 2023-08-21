import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/home_controller.dart';
import 'package:progfile/app/views/components/main_button.dart';

import 'components/snackbar_helper.dart';
import 'components/title_text.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = HomeController();

  HomeView({super.key});

  void onSignOut(BuildContext context) async {
    try {
      await homeController.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, right: 50, left: 50, bottom: 10),
        child: Column(
          children: [
            const TitleText(text: 'Olá'),
            const SizedBox(height: 80),
            MainButton(
              text: 'Criar Currículo',
              onPressedCallback: () =>
                  {Navigator.pushNamed(context, '/curriculumRegister')},
            ),
            const SizedBox(height: 10),
            MainButton(
                text: 'Meu Curriculo',
                onPressedCallback: () =>
                    {Navigator.pushNamed(context, '/myCurriculum')}),
            const SizedBox(height: 10),
            MainButton(
              text: 'Procurar Currículo',
              onPressedCallback: () =>
                  {Navigator.pushNamed(context, '/search')},
            ),
            const SizedBox(height: 10),
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
