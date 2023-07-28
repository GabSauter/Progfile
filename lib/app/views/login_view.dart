import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/login_controller.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';

class LoginView extends StatelessWidget {
  final LoginController loginController = LoginController();
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, right: 50, left: 50, bottom: 5),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const TitleText(text: 'ProgFile'),
                const SizedBox(height: 80),
                const FormText(text: 'Email:'),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: loginController.emailController,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
                const SizedBox(height: 10),
                const FormText(text: 'Senha:'),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: loginController.passwordController,
                  validator: (value) {
                    return validatePassword(value);
                  },
                ),
                const SizedBox(height: 20),
                MainButton(
                  text: 'Entrar',
                  route: '/home',
                  onPressedCallback: () {
                    validateFields(context);
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

  validateFields(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Entrando!"),
        ),
      );
      //Navigator.pushNamed(context, '/home');
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    } else if (!value.contains("@")) {
      return "O email precisa ter o @";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor.";
    } else if (value.length < 8) {
      return "A senha precisa ter pelo menos 8 characteres";
    }
    return null;
  }
}
