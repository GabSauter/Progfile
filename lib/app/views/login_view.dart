import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/login_controller.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';

import 'components/snackbar_helper.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = LoginController();

  LoginView({super.key});

  void showErrorSnackBar(String errorMessage, BuildContext context) {
    SnackBarHelper.showErrorSnackBar(errorMessage, context);
  }

  void onSignIn(BuildContext context) async {
    String loginResult = await loginController.signIn();
    if (context.mounted) {
      if (loginResult == "Logado") {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showErrorSnackBar(loginResult, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, right: 50, left: 50, bottom: 5),
          child: Form(
            key: loginController.formKey,
            child: Column(
              children: [
                const TitleText(text: 'ProgFile'),
                const SizedBox(height: 80),
                const FormText(text: 'Email:'),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: loginController.emailController,
                  validator: (value) {
                    return loginController.validateEmail(value);
                  },
                ),
                const SizedBox(height: 10),
                const FormText(text: 'Senha:'),
                const SizedBox(height: 10),
                FormPasswordTextField(
                  textEditingController: loginController.passwordController,
                  validator: (value) {
                    return loginController.validatePassword(value);
                  },
                ),
                const SizedBox(height: 20),
                MainButton(
                  text: 'Entrar',
                  onPressedCallback: () {
                    if (loginController.validateForm(context)) {
                      onSignIn(context);
                    }
                  },
                ),
                const SizedBox(height: 10),
                const SecondaryButton(
                  text: 'Cadastrar',
                  route: '/register',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
