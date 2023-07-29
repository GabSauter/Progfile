import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/login_controller.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = LoginController();

  LoginView({super.key});

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
                  route: '/home',
                  onPressedCallback: () {
                    if (loginController.validateForm(context)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Entrando!"),
                        ),
                      );
                      //Navigator.pushNamed(context, '/home');
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