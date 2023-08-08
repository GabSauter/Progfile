import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progfile/app/models/curriculum_model.dart';
import 'package:progfile/app/services/curriculum_service.dart';

class CurriculumRegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final githubRepositoryUrlController = TextEditingController();
  final addressController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final aboutYouController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedDegree;

  final _image = ValueNotifier<File?>(null);

  Future<void> createCurriculum() async {
    var curriculum = CurriculumModel(
      image: _image.value,
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      gitHubRepositoryUrl: githubRepositoryUrlController.text,
      address: addressController.text,
      fieldOfExpertise: fieldOfStudyController.text,
      degree: selectedDegree == null ? '' : selectedDegree.toString(),
      aboutYou: aboutYouController.text,
    );

    await CurriculumService().createCurriculum(curriculum);
  }

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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    } else if (!value.contains("@")) {
      return "O email precisa ter o @";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor.";
    }

    String sanitizedNumber = value.replaceAll(RegExp(r'\D'), '');

    if (sanitizedNumber.length != 10) {
      return 'O número de telefone precisa ter 10 digitos.';
    }

    return null;
  }

  String? validateAboutYou(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
  }

  String? validateFieldOfStudy(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
  }

  String? validateGithubRepository(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }

    return null;
  }

  String? validateGithubUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }

    return null;
  }

  String? validateDropdownValue(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor insira algum valor";
    }
    return null;
  }

  bool validateForm(BuildContext context) {
    return formKey.currentState!.validate();
  }
}
