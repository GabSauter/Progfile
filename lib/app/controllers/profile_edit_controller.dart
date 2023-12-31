import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progfile/app/models/profile_model.dart';
import 'package:progfile/app/repositories/profile_repository.dart';
import 'package:progfile/app/views/popups/popup_image_selection.dart';

class ProfileRegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = MaskedTextController(mask: '(00) 00000-0000');
  final githubUsernameController = TextEditingController();
  final fieldOfExpertiseController = TextEditingController();
  final aboutYouController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final selectedDegree = TextEditingController();
  final cityController = TextEditingController();
  final ufController = TextEditingController();
  XFile? pickedImage;
  String? downloadImageURL;

  final _image = ValueNotifier<File?>(null);

  Future<ProfileModel> generateProfile() async {
    if (pickedImage != null) {
      ProfileRepository profileRepository = ProfileRepository();
      downloadImageURL = await profileRepository.saveImage(pickedImage!);
    }

    return ProfileModel(
      image: downloadImageURL,
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneNumberController.text,
      githubUsername: githubUsernameController.text,
      address: '${cityController.text} - ${ufController.text}',
      fieldOfExpertise: fieldOfExpertiseController.text,
      degree: selectedDegree.text == '' ? 'Estagiário' : selectedDegree.text,
      aboutYou: aboutYouController.text,
    );
  }

  Future<ProfileModel> editProfile(ProfileModel curriculum) async {
    if (pickedImage != null) {
      ProfileRepository profileRepository = ProfileRepository();
      downloadImageURL = await profileRepository.saveImage(pickedImage!);
    }

    curriculum.image = downloadImageURL;
    curriculum.name = nameController.text;
    curriculum.email = emailController.text;
    curriculum.phoneNumber = phoneNumberController.text;
    curriculum.githubUsername = githubUsernameController.text;
    curriculum.address = '${cityController.text} - ${ufController.text}';
    curriculum.fieldOfExpertise = fieldOfExpertiseController.text;
    curriculum.degree = selectedDegree.text;
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
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _setImage(File(pickedImage!.path));
    }
  }

  Future<void> getImageFromGallery(BuildContext context) async {
    final imagePicker = ImagePicker();
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _setImage(File(pickedImage!.path));
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
