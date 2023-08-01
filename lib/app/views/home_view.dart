import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/home_controller.dart';
import 'package:progfile/app/views/components/main_button.dart';

import 'components/snackbar_helper.dart';
import 'components/title_text.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = HomeController();

  HomeView({super.key});

  void showErrorSnackBar(String errorMessage, BuildContext context) {
    SnackBarHelper.showErrorSnackBar(errorMessage, context);
  }

  void logout(BuildContext context) {
    homeController.logout(context, showErrorSnackBar);
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
              route: '/home',
              onPressedCallback: () => {},
            ),
            const SizedBox(height: 10),
            MainButton(
              text: 'Procurar Currículo',
              route: '/home',
              onPressedCallback: () => {},
            ),
            const SizedBox(height: 10),
            MainButton(
              text: 'Logout',
              route: '/',
              onPressedCallback: () => logout(context),
            )
          ],
        ),
      ),
    );
  }
}