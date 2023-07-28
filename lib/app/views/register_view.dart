import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/register_controller.dart';
import 'package:progfile/app/views/components/back_button.dart';

import 'components/form_text.dart';
import 'components/form_textfield.dart';
import 'components/main_button.dart';
import 'components/title_text.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = RegisterController();
  final _formKey = GlobalKey<FormState>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BackCustomButton(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 50, left: 50, bottom: 5),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const TitleText(text: 'ProgFile'),
                    const SizedBox(height: 40),
                    const FormText(text: 'Nome:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController: registerController.nameController,
                      validator: (value) {
                        return validateName(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Email:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController: registerController.emailController,
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Senha:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController:
                          registerController.passwordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Confirmar Senha:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController:
                          registerController.confirmPasswordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      text: 'Cadastrar',
                      route: '/',
                      onPressedCallback: () {
                        validateFields(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateFields(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (registerController.confirmPassword()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cadastrando!"),
          ),
        );
        //Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            content: Column(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Os campos de senha e confirmar a senha devem ser iguais.",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor:
                Colors.red, // Set the background color of the SnackBar
          ),
        );
      }
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
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
