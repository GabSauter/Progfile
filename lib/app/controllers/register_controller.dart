import 'package:flutter/material.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool confirmPassword() {
    return passwordController.text == confirmPasswordController.text;
  }
}
