import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

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
    return (passwordController.text == confirmPasswordController.text);
  }

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }

  void signUp(BuildContext context,
      void Function(String, BuildContext) onErrorCallback) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Navigator.pushReplacementNamed(context, '/home');
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
      onErrorCallback(error.toString(), context);
    });
  }
}
