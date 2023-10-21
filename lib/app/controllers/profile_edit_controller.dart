import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progfile/app/models/profile_model.dart';
import 'package:progfile/app/views/popups/popup_image_selection.dart';

class ProfileRegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = MaskedTextController(mask: '(00) 00000-0000');
  final githubUsernameController = TextEditingController();
  final addressController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final aboutYouController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedDegree;

  final _image = ValueNotifier<File?>(null);

  ProfileModel generateProfile() {
    return ProfileModel(
      image: _image.value,
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      githubUsername: githubUsernameController.text,
      address: addressController.text,
      fieldOfExpertise: fieldOfStudyController.text,
      degree: selectedDegree == null ? 'Estagiário' : selectedDegree.toString(),
      aboutYou: aboutYouController.text,
    );
  }

  ProfileModel editProfile(ProfileModel curriculum) {
    curriculum.image = _image.value;
    curriculum.name = nameController.text;
    curriculum.email = emailController.text;
    curriculum.phoneNumber = phoneNumberController.text;
    curriculum.githubUsername = githubUsernameController.text;
    curriculum.address = addressController.text;
    curriculum.fieldOfExpertise = fieldOfStudyController.text;
    curriculum.degree =
        selectedDegree == null ? 'Estagiário' : selectedDegree.toString();
    curriculum.aboutYou = aboutYouController.text;

    return curriculum;
  }

  Future<void> handleImageSelection(BuildContext context) async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      if (context.mounted) {
        PopupImageSelection(this).showImageSourceSelectionDialog(context);
      }
    } else {
      if (context.mounted) {
        _requestPermissionsAgain(context);
      }
    }
  }

  Future<void> getImageFromCamera(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _setImage(File(pickedImage.path));
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
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
