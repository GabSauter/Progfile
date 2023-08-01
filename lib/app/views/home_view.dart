import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/home_controller.dart';
import 'package:progfile/app/views/components/main_button.dart';

import 'components/snackbar_helper.dart';

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
      body: Column(
        children: [
          MainButton(
            text: 'Logout',
            route: '/',
            onPressedCallback: () => logout(context),
          )
        ],
      ),
    );
  }
}
