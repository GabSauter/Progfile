import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';

import '../controllers/curriculum_register_controller.dart';
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
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 20),
              FormTextField(
                textEditingController: _controller.nameController,
                labelText: 'Nome',
                validator: (value) {
                  return _controller.validateName(value);
                },
              ),
              const SizedBox(height: 15),
              FormTextField(
                textEditingController: _controller.emailController,
                labelText: 'Email',
                validator: (value) {
                  return _controller.validateEmail(value);
                },
              ),
              const SizedBox(height: 15),
              FormTextField(
                textEditingController: _controller.phoneNumberController,
                labelText: 'Número do celular',
                validator: (value) {
                  return _controller.validatePhone(value);
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              FormTextField(
                textEditingController:
                    _controller.githubRepositoryUrlController,
                labelText: 'Nome do Repositorio do GitHub',
                validator: (value) {
                  return _controller.validateGithubUsername(value);
                },
              ),
              const SizedBox(height: 15),
              FormTextField(
                textEditingController:
                    _controller.githubRepositoryUrlController,
                labelText: 'Nome do Repositorio do GitHub',
                validator: (value) {
                  return _controller.validateGithubRepository(value);
                },
              ),
              const SizedBox(height: 15),
              FormTextField(
                textEditingController: _controller.addressController,
                labelText: 'Endereço',
                validator: (value) {
                  return _controller.validateAddress(value);
                },
              ),
              const SizedBox(height: 15),
              FormTextField(
                textEditingController: _controller.fieldOfStudyController,
                labelText: 'Área de Estudo',
                validator: (value) {
                  return _controller.validateFieldOfStudy(value);
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                items: ['Estágio', 'Junior', 'Senior']
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
                value: _controller.selectedDegree,
                decoration: const InputDecoration(labelText: 'Grau'),
                validator: (value) {
                  return _controller.validateDropdownValue(value);
                },
              ),
              const SizedBox(height: 20),
              MainButton(
                onPressedCallback: () {},
                text: 'Adicionar Idioma',
              ),
              const SizedBox(height: 15),
              MainButton(
                onPressedCallback: () {},
                text: 'Adicionar Competência',
              ),
              const SizedBox(height: 20),
              FormTextField(
                textEditingController: _controller.aboutYouController,
                maxLines: 4,
                labelText: 'About You',
                validator: (value) {
                  return _controller.validateAboutYou(value);
                },
              ),
              const SizedBox(height: 20.0),
              MainButton(
                onPressedCallback: () {
                  createCurriculum();
                },
                text: 'Concluir',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
