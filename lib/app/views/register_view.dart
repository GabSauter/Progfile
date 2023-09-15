import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/register_controller.dart';
import 'package:progfile/app/views/components/back_button.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';

import 'components/form_text.dart';
import 'components/form_textfield.dart';
import 'components/main_button.dart';
import 'components/snackbar_helper.dart';
import 'components/title_text.dart';

class RegisterView extends StatelessWidget {
  final RegisterController registerController = RegisterController();

  RegisterView({super.key});

  void onSignUp(BuildContext context) async {
    try {
      await registerController.signUp();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
          child: BackCustomButton(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const TitleText(text: 'Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, right: 50, left: 50, bottom: 5),
              child: Form(
                key: registerController.formKey,
                child: Column(
                  children: [
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
                      onPressedCallback: () {
                        var isSamePassword =
                            registerController.confirmPassword();
                        if (registerController.validateForm(context) &&
                            isSamePassword) {
                          onSignUp(context);
                        }
                        if (!isSamePassword) {
                          SnackBarHelper.showErrorSnackBar(
                              "Por favor digite a mesma senha", context);
                        }
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
}
