import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/login_controller.dart';
import 'package:progfile/app/repositories/curriculum_reposiotory.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';
import 'package:provider/provider.dart';
import 'package:progfile/app/repositories/profile_repository.dart';

import 'components/snackbar_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController loginController = LoginController();

  bool isLoading = false;

  void onSignIn(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      await loginController.signIn();
      if (context.mounted) {
        context
            .read<CurriculumRepository>()
            .getItems(FirebaseAuth.instance.currentUser!.uid);
        context.read<ProfileRepository>().getCurriculums();
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Ocorreu um erro ao fazer login";

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "Email ou senha incorreta.";
          break;
        case 'invalid-email':
          errorMessage = "Email inválido.";
          break;
        case 'wrong-password':
          errorMessage = "Email ou senha incorreta.";
          break;
        case 'network-request-failed':
          errorMessage =
              "Houve um problema de conexão com a Internet. Verifique sua conexão e tente novamente.";
          break;
        default:
          errorMessage =
              "Ocorreu um erro desconhecido. Por favor, tente novamente mais tarde.";
      }
      SnackBarHelper.showErrorSnackBar(errorMessage, context);
    } finally {
      setState(() {
        isLoading = false;
      });
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
                    return validateEmail(value);
                  },
                ),
                const SizedBox(height: 10),
                const FormText(text: 'Senha:'),
                const SizedBox(height: 10),
                FormPasswordTextField(
                  textEditingController: loginController.passwordController,
                  validator: (value) {
                    return validatePassword(value);
                  },
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MainButton(
                        text: 'Entrar',
                        onPressedCallback: () {
                          if (loginController.formKey.currentState!
                              .validate()) {
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
