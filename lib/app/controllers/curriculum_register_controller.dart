import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CurriculumRegisterController extends ChangeNotifier {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numeroCelularController = TextEditingController();
  final TextEditingController urlRepositorioGitHubController =
      TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController areaAtuacaoController = TextEditingController();
  final TextEditingController aboutYouController = TextEditingController();
  String? selectedGrau;
  File? _image;

  Future<void> handleImageSelection(BuildContext context) async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      if (context.mounted) {
        _showImageSourceSelectionDialog(context);
      }
    } else {
      if (context.mounted) {
        _requestPermissionsAgain(context);
      }
    }
  }

  void _showImageSourceSelectionDialog(BuildContext context) {
    showDialog(
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
                    _getImageFromCamera(context);
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    _getImageFromGallery(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _setImage(File(pickedImage.path));
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _setImage(File(pickedImage.path));
    }
  }

  Future<void> _requestPermissionsAgain(BuildContext context) async {
    if (!await Permission.camera.isGranted) {
      await Permission.camera.request();
    }

    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    if (context.mounted) {
      handleImageSelection(context);
    }
  }

  File? get image => _image;

  void _setImage(File image) {
    _image = image;
    notifyListeners();
  }
}
