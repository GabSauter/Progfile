import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers/curriculum_register_controller.dart';
import 'components/image_take.dart';
import 'components/snackbar_helper.dart';

class CurriculumRegisterView extends StatefulWidget {
  const CurriculumRegisterView({super.key});

  @override
  State<CurriculumRegisterView> createState() => _CurriculumRegisterViewState();
}

class _CurriculumRegisterViewState extends State<CurriculumRegisterView> {
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
        title: const Text('Curriculum Registration'),
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller.nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  return _controller.validateName(value);
                },
              ),
              TextFormField(
                controller: _controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  return _controller.validateEmail(value);
                },
              ),
              TextFormField(
                controller: _controller.phoneNumberController,
                decoration:
                    const InputDecoration(labelText: 'Número do celular'),
                validator: (value) {
                  return _controller.validatePhone(value);
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Adicionar Curso'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/certificate');
                },
                child: const Text('Adicionar Certificado'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller.githubRepositoryUrlController,
                decoration: const InputDecoration(
                    labelText: 'Nome de usuário do Github'),
                validator: (value) {
                  return _controller.validateGithubUsername(value);
                },
              ),
              TextFormField(
                controller: _controller.githubRepositoryUrlController,
                decoration: const InputDecoration(
                    labelText: 'Nome do Repositorio do GitHub'),
                validator: (value) {
                  return _controller.validateGithubRepository(value);
                },
              ),
              TextFormField(
                controller: _controller.addressController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  return _controller.validateAddress(value);
                },
              ),
              TextFormField(
                controller: _controller.fieldOfStudyController,
                decoration: const InputDecoration(labelText: 'Área De Atuação'),
                validator: (value) {
                  return _controller.validateFieldOfStudy(value);
                },
              ),
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
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Adicionar Idioma'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Adicionar Competência'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller.aboutYouController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'About You'),
                validator: (value) {
                  return _controller.validateAboutYou(value);
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  createCurriculum();
                },
                child: const Text('Concluir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
