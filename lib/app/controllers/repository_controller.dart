import 'package:flutter/material.dart';

import '../models/repository_model.dart';
import '../services/repository_service.dart';

class RepositoryController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  Future<List<RepositoryModel>> getRepositories() async {
    return await RepositoryService().getAll();
  }

  void addRepository() async {
    RepositoryModel repository = RepositoryModel(
      name: nameController.text,
      url: urlController.text,
      description: descriptionController.text,
      language: languageController.text,
    );
    await RepositoryService().create(repository);
  }

  void editRepository(RepositoryModel repository) async {
    repository.name = nameController.text;
    repository.url = urlController.text;
    repository.description = descriptionController.text;
    repository.language = languageController.text;

    await RepositoryService().edit(repository.id, repository);
  }

  void removeRepository(String id) async {
    await RepositoryService().delete(id);
  }
}
