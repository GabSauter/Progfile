import 'package:flutter/material.dart';
import 'package:progfile/app/models/user_model.dart';
import 'package:progfile/app/services/user_service.dart';

class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }

  Future<String> signIn() async {
    UserModel user = UserModel(
        nameController.text, emailController.text, passwordController.text);
    return await UserService().signIn(user);
  }
}
