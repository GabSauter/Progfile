import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/register_controller.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';

import 'components/snackbar_helper.dart';

class EditAccountView extends StatelessWidget {
  final RegisterController editAccountController = RegisterController();

  EditAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Conta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: editAccountController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const FormText(text: 'Nome'),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: editAccountController.nameController,
                validator: (value) => validateName(value),
              ),
              const SizedBox(height: 20),
              const FormText(text: 'Email'),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: editAccountController.emailController,
                validator: (value) => validateEmail(value),
              ),
              const SizedBox(height: 20),
              const FormText(text: 'Senha'),
              const SizedBox(height: 10),
              FormPasswordTextField(
                textEditingController: editAccountController.passwordController,
                validator: (value) => validatePassword(value),
              ),
              const SizedBox(height: 20),
              const FormText(text: 'Confirmar Senha'),
              const SizedBox(height: 10),
              FormPasswordTextField(
                textEditingController:
                    editAccountController.confirmPasswordController,
                validator: (value) => validatePassword(value),
              ),
              const SizedBox(height: 20),
              MainButton(
                text: 'Confirmar',
                buttonColor: Colors.green,
                buttonHeight: 50,
                onPressedCallback: () {
                  var isSamePassword = confirmPassword();
                  if (editAccountController.formKey.currentState!.validate() &&
                      isSamePassword) {
                    editAccountController.editAccount();
                    Navigator.pop(context);
                    SnackBarHelper.showSuccessSnackBar(
                        "Conta editada com sucesso", context);
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
    return (editAccountController.passwordController.text ==
        editAccountController.confirmPasswordController.text);
  }
}
