import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers/curriculum_register_controller.dart';
import 'components/image_take.dart';

class CurriculumRegisterView extends StatefulWidget {
  const CurriculumRegisterView({super.key});

  @override
  State<CurriculumRegisterView> createState() => _CurriculumRegisterViewState();
}

class _CurriculumRegisterViewState extends State<CurriculumRegisterView> {
  final _controller = CurriculumRegisterController();

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
            ),
            TextFormField(
              controller: _controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _controller.phoneNumberController,
              decoration: const InputDecoration(labelText: 'Número do celular'),
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
                labelText: 'URL Repositorio GitHub',
              ),
            ),
            TextFormField(
              controller: _controller.addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              controller: _controller.fieldOfStudyController,
              decoration: const InputDecoration(labelText: 'Área De Atuação'),
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
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Concluir'),
            ),
          ],
        ),
      ),
    );
  }
}
