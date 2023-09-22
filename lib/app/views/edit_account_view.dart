import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_password_textfield.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({super.key});

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const FormText(text: 'Nome Completo'),
            const SizedBox(height: 10),
            FormTextField(
              textEditingController: TextEditingController(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const FormText(text: 'Email'),
            const SizedBox(height: 10),
            FormTextField(
              textEditingController: TextEditingController(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const FormText(text: 'Senha'),
            const SizedBox(height: 10),
            FormPasswordTextField(
              textEditingController: TextEditingController(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const FormText(text: 'Confirmar Senha'),
            const SizedBox(height: 10),
            FormPasswordTextField(
              textEditingController: TextEditingController(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Confirmar',
              buttonColor: Colors.green,
              buttonHeight: 50,
              onPressedCallback: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
