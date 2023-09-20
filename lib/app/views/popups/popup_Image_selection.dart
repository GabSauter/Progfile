import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/curriculum_edit_controller.dart';

class PopupImageSelection {
  CurriculumRegisterController controller;

  PopupImageSelection(this.controller);

  void showImageSourceSelectionDialog(BuildContext context) {
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
                    controller.getImageFromCamera(context);
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    controller.getImageFromGallery(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
