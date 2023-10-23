import 'package:flutter/material.dart';
import 'package:progfile/app/models/user_model.dart';
import 'package:progfile/app/services/user_service.dart';

class RegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    UserModel user = UserModel(
        nameController.text, emailController.text, passwordController.text);
    await UserService().signUp(user);
  }

  Future<void> editAccount() async {
    UserModel user = UserModel(
        nameController.text, emailController.text, passwordController.text);
    await UserService().editAccount(user);
  }
}
