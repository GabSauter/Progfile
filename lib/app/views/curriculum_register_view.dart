import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CurriculumRegisterView extends StatefulWidget {
  const CurriculumRegisterView({super.key});

  @override
  _CurriculumRegisterViewState createState() => _CurriculumRegisterViewState();
}

class _CurriculumRegisterViewState extends State<CurriculumRegisterView> {
  File? _image;

  Future<void> _getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
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
                await _showImageSourceSelectionDialog();
              },
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? const Icon(Icons.camera_alt) : null,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Número do celular'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Adicionar Curso'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Adicionar Certificado'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'URL Repositorio GitHub'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Área De Atuação'),
            ),
            DropdownButtonFormField<String>(
              items: ['Estágio', 'Junior', 'Senior']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (selectedGrade) {},
              value: null,
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

  Future<void> _showImageSourceSelectionDialog() async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Selecione o tipo de imagem'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImageFromCamera();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  GestureDetector(
                    child: const Text('Galeria'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImageFromGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permissão requerida'),
            content: const Text(
                'Precisamos de sua permissão para camera e armazenamento.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _requestPermissionsAgain();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _requestPermissionsAgain() async {
    if (!await Permission.camera.isGranted) {
      await Permission.camera.request();
    }

    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
  }
}
