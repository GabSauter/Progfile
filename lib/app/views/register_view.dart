import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/register_controller.dart';
import 'package:progfile/app/views/components/back_button.dart';

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
              child: Column(
                children: [
                  const TitleText(text: 'ProgFile'),
                  const SizedBox(height: 40),
                  const FormText(text: 'Nome:'),
                  const SizedBox(height: 10),
                  FormTextField(
                      textEditingController: registerController.nameController),
                  const SizedBox(height: 10),
                  const FormText(text: 'Email:'),
                  const SizedBox(height: 10),
                  FormTextField(
                      textEditingController:
                          registerController.emailController),
                  const SizedBox(height: 10),
                  const FormText(text: 'Senha:'),
                  const SizedBox(height: 10),
                  FormTextField(
                      textEditingController:
                          registerController.passwordController),
                  const SizedBox(height: 10),
                  const FormText(text: 'Confirmar Senha:'),
                  const SizedBox(height: 10),
                  FormTextField(
                      textEditingController:
                          registerController.confirmPasswordController),
                  const SizedBox(height: 20),
                  MainButton(
                    text: 'Cadastrar',
                    route: '/',
                    onPressedCallback: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
