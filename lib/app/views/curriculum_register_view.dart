import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CurriculumRegisterView extends StatefulWidget {
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
        title: Text('Curriculum Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () async {
                        await _showImageSourceSelectionDialog();
                      },
                    )
                  : null,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Número do celular'),
            ),
            SizedBox(height: 16.0),
            // Button to add course
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Curso'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Certificado'),
            ),
            SizedBox(height: 16.0),
            // Textfields for GitHub repository URL, Address, Occupation area, and Grade
            TextFormField(
              decoration: InputDecoration(labelText: 'URL Repositorio GitHub'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Área De Atuação'),
            ),
            DropdownButtonFormField<String>(
              items: ['Estágio', 'Junior', 'Senior']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (selectedGrade) {
                // Implement action for grade selection
              },
              value: null,
              decoration: InputDecoration(labelText: 'Grau'),
            ),
            SizedBox(height: 16.0),
            // Button to add idiom
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Idioma'),
            ),
            // Button to add competence
            ElevatedButton(
              onPressed: () {
                // Implement action to add a competence
              },
              child: Text('Adicionar Competência'),
            ),
            SizedBox(height: 16.0),
            // Textfield to add 'About You'
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'About You'),
            ),
            SizedBox(height: 16.0),
            // Button to conclude the registration
            ElevatedButton(
              onPressed: () {
                // Implement action to conclude the registration
              },
              child: Text('Concluir'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showImageSourceSelectionDialog() async {
    // Request camera and storage permissions
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image Source'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      _getImageFromCamera();
                    },
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    child: Text('Gallery'),
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
      // Handle permission denied or restricted
      // You can show an error message or request permissions again.
      // For simplicity, this example will not handle the error case.
    }
  }
}
