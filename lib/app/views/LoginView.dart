import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:progfile/app/views/components/title_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40, right: 50, left: 50, bottom: 5),
        child: Column(
          children: [
            TitleText(text: 'ProgFile'),
            SizedBox(height: 80),
            FormText(text: 'Email:'),
            SizedBox(height: 10),
            FormTextField(),
            SizedBox(height: 10),
            FormText(text: 'Senha:'),
            SizedBox(height: 10),
            FormTextField(),
            SizedBox(height: 20),
            MainButton(text: 'Entrar'),
            SizedBox(height: 10),
            SecondaryButton(text: 'Cadastrar')
          ],
        ),
      ),
    );
  }
}
