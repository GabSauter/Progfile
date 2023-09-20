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
                    FormPasswordTextField(
                      textEditingController:
                          registerController.passwordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 10),
                    const FormText(text: 'Confirmar Senha:'),
                    const SizedBox(height: 10),
                    FormPasswordTextField(
                      textEditingController:
                          registerController.confirmPasswordController,
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      text: 'Cadastrar',
                      onPressedCallback: () {
                        var isSamePassword = confirmPassword();
                        if (registerController.formKey.currentState!
                                .validate() &&
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

  bool confirmPassword() {
    return (registerController.passwordController.text ==
        registerController.confirmPasswordController.text);
  }
}
