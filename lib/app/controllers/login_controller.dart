import 'package:flutter/material.dart';
import 'package:progfile/app/models/user_model.dart';
import 'package:progfile/app/services/user_service.dart';

class LoginController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    UserModel user = UserModel(
        nameController.text, emailController.text, passwordController.text);
    await UserService().signIn(user);
  }
}
