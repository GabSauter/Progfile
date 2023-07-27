import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validateFields() {
    return emailController.text.contains('@') &&
        passwordController.text.length >= 8;
  }

  bool login() {
    // acess database and validade email and password
    return true;
  }
}
