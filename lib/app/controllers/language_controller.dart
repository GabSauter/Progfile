import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/language_model.dart';

class LanguageController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  LanguageModel generateLanguage() {
    LanguageModel language = LanguageModel(
      name: nameController.text,
      degree: degreeController.text,
    );

    return language;
  }

  LanguageModel editLanguage(LanguageModel language) {
    language.name = nameController.text;
    language.degree = degreeController.text;

    return language;
  }
}
