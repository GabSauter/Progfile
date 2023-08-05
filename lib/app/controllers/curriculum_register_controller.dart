import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CurriculumRegisterController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController githubRepositoryUrlController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController aboutYouController = TextEditingController();
  String? selectedDegree;

  final _image = ValueNotifier<File?>(null);

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
          title: const Text('Select Image Type'),
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
                  child: const Text('Gallery'),
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

  ValueNotifier<File?> get image => _image;

  void _setImage(File image) {
    _image.value = image;
  }
}
