import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/login_controller.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = LoginController();

  LoginView({super.key, required this.loginController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, right: 50, left: 50, bottom: 5),
        child: Column(
          children: [
            TitleText(text: 'ProgFile'),
            SizedBox(height: 80),
            FormText(text: 'Email:'),
            SizedBox(height: 10),
            FormTextField(
                textEditingController: loginController.emailController),
            SizedBox(height: 10),
            FormText(text: 'Senha:'),
            SizedBox(height: 10),
            FormTextField(
                textEditingController: loginController.passwordController),
            SizedBox(height: 20),
            MainButton(
              text: 'Entrar',
              route: '/home',
              onPressedCallback: () {
                print(loginController.passwordController.text);
                validateFields(context);
              },
            ),
            SizedBox(height: 10),
            SecondaryButton(
              text: 'Cadastrar',
              route: '/register',
            )
          ],
        ),
      ),
    );
  }

  validateFields(BuildContext context) {
    if (loginController.validateFields() && loginController.login()) {
      Navigator.pushNamed(context, '/home');
    } else {
      // Show error message
    }
  }
}
