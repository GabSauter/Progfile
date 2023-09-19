import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/services/language_service.dart';

class LanguageController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  Future<List<LanguageModel>> getLanguages() async {
    return await LanguageService().getAll();
  }

  void addLanguage() async {
    LanguageModel language = LanguageModel(
      name: nameController.text,
      degree: degreeController.text,
    );
    await LanguageService().create(language);
  }

  void editLanguage(LanguageModel language) async {
    language.name = nameController.text;
    language.degree = degreeController.text;

    await LanguageService().edit(language.id, language);
  }

  void removeLanguage(String id) async {
    await LanguageService().delete(id);
  }
}
