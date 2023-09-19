import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_dropdown.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/masked_textfield.dart';

import '../controllers/curriculum_edit_controller.dart';
import 'components/image_take.dart';
import 'components/snackbar_helper.dart';

class CurriculumEditView extends StatefulWidget {
  const CurriculumEditView({super.key});

  @override
  State<CurriculumEditView> createState() => _CurriculumEditViewState();
}

class _CurriculumEditViewState extends State<CurriculumEditView> {
  final _controller = CurriculumRegisterController();

  void createCurriculum() async {
    if (_controller.validateForm(context)) {
      try {
        await _controller.createCurriculum();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        SnackBarHelper.showErrorSnackBar(e.toString(), context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Currículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  await _controller.handleImageSelection(context);
                },
                child: ValueListenableBuilder<File?>(
                  valueListenable: _controller.image,
                  builder: (context, value, child) {
                    return ImageDisplay(image: value);
                  },
                ),
              ),
              const SizedBox(height: 25),
              const FormText(
                text: 'Nome:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: _controller.nameController,
                validator: (value) {
                  return _controller.validateName(value);
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Email:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: _controller.emailController,
                validator: (value) {
                  return _controller.validateEmail(value);
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Celular:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              MaskedTextField(
                controller: _controller.phoneNumberController,
                validator: (value) {
                  return _controller.validatePhone(value);
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Sobre Você:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                maxLines: 4,
                length: 200,
                textEditingController: _controller.aboutYouController,
                validator: (value) {
                  return _controller.validateAboutYou(value);
                },
              ),
              const SizedBox(height: 25),
              MainButton(
                onPressedCallback: () {
                  Navigator.pushNamed(context, '/course');
                },
                text: 'Adicionar Curso',
              ),
              const SizedBox(height: 15),
              MainButton(
                onPressedCallback: () {
                  Navigator.pushNamed(context, '/certificate');
                },
                text: 'Adicionar Certificado',
              ),
              const SizedBox(height: 25),
              const FormText(
                text: 'Username Github:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController:
                    _controller.githubRepositoryUrlController,
                validator: (value) {
                  return _controller.validateGithubRepository(value);
                },
              ),
              const SizedBox(height: 10),
              MainButton(
                text: 'Repositórios GitHub',
                onPressedCallback: () {
                  Navigator.pushNamed(context, '/repository');
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Endereço:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: _controller.addressController,
                validator: (value) {
                  return _controller.validateAddress(value);
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Área de Estudo:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormTextField(
                textEditingController: _controller.fieldOfStudyController,
                validator: (value) {
                  return _controller.validateFieldOfStudy(value);
                },
              ),
              const SizedBox(height: 15),
              const FormText(
                text: 'Nível de Desenvolvedor:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              const SizedBox(height: 10),
              FormDropdown(
                value: _controller.selectedDegree ?? 'Estagiário',
                items: ['Estagiário', 'Júnior', 'Sênior', 'Pleno']
                    .map((grade) => DropdownMenuItem<String>(
                          value: grade,
                          child: Text(grade),
                        ))
                    .toList(),
                onChanged: (selectedGrade) {
                  setState(() {
                    _controller.selectedDegree = selectedGrade;
                  });
                },
                validator: (value) {
                  return _controller.validateDropdownValue(value);
                },
                errorText: 'Selecione o nível de desenvolvedor',
              ),
              const SizedBox(height: 25),
              MainButton(
                onPressedCallback: () {
                  Navigator.pushNamed(context, '/language');
                },
                text: 'Adicionar Idioma',
              ),
              const SizedBox(height: 15),
              MainButton(
                onPressedCallback: () {
                  Navigator.pushNamed(context, '/competence');
                },
                text: 'Adicionar Competência',
              ),
              const SizedBox(height: 15),
              MainButton(
                onPressedCallback: () {
                  createCurriculum();
                },
                text: 'Concluir',
                buttonColor: Colors.green[500],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
