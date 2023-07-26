import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/back_button.dart';

import 'components/form_text.dart';
import 'components/form_textfield.dart';
import 'components/main_button.dart';
import 'components/title_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BackCustomButton(),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 50, left: 50, bottom: 5),
            child: Column(
              children: [
                TitleText(text: 'ProgFile'),
                SizedBox(height: 40),
                FormText(text: 'Nome:'),
                SizedBox(height: 10),
                FormTextField(),
                SizedBox(height: 10),
                FormText(text: 'Email:'),
                SizedBox(height: 10),
                FormTextField(),
                SizedBox(height: 10),
                FormText(text: 'Senha:'),
                SizedBox(height: 10),
                FormTextField(),
                SizedBox(height: 10),
                FormText(text: 'Confirmar Senha:'),
                SizedBox(height: 10),
                FormTextField(),
                SizedBox(height: 20),
                MainButton(text: 'Cadastrar'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
