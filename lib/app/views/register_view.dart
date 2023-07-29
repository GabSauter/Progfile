import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/register_controller.dart';
import 'package:progfile/app/views/components/back_button.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';

import 'components/form_text.dart';
import 'components/form_textfield.dart';
import 'components/main_button.dart';
import 'components/title_text.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = RegisterController();

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
                key: registerController.formKey,
                child: Column(
                  children: [
                    const TitleText(text: 'ProgFile'),
                    const SizedBox(height: 40),
                    const FormText(text: 'Nome:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController: registerController.nameController,
                      validator: (value) {
                        return registerController.validateName(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Email:'),
                    const SizedBox(height: 10),
                    FormTextField(
                      textEditingController: registerController.emailController,
                      validator: (value) {
                        return registerController.validateEmail(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Senha:'),
                    const SizedBox(height: 10),
                    FormPasswordTextField(
                      textEditingController:
                          registerController.passwordController,
                      validator: (value) {
                        return registerController.validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Confirmar Senha:'),
                    const SizedBox(height: 10),
                    FormPasswordTextField(
                      textEditingController:
                          registerController.confirmPasswordController,
                      validator: (value) {
                        return registerController.validatePassword(value);
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
    if (registerController.validateForm(context)) {
      if (registerController.confirmPassword()) {
        registerController.signUp(context);
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
}
