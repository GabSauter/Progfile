import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/home_controller.dart';
import 'package:progfile/app/views/components/main_button.dart';

class HomeView extends StatelessWidget {
  final HomeController homeController = HomeController();

  HomeView({super.key});

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

  void showErrorSnackBar(String errorMessage, BuildContext context) {
    final snackBar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void logout(BuildContext context) {
    homeController.logout(context, showErrorSnackBar);
  }
}
