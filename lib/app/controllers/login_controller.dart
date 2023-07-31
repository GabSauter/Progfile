import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
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

  void signIn(
    BuildContext context,
    void Function(String, BuildContext)
        onErrorCallback, // Corrected parameter type here
  ) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Navigator.pushNamed(context, '/home');
    }).catchError((error) {
      print("Error ${error.toString()}");
      onErrorCallback(error.toString(),
          context); // Execute the callback function with the error message
    });
  }
}
