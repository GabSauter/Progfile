import 'package:flutter/material.dart';

import '../models/git_project_model.dart';

class GitProjectController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController languageController = TextEditingController();

  GitProjectModel generateGitRepository() {
    return GitProjectModel(
      name: nameController.text,
      url: urlController.text,
      description: descriptionController.text,
      language: languageController.text,
    );
  }

  GitProjectModel editGitRepository(GitProjectModel repository) {
    repository.name = nameController.text;
    repository.url = urlController.text;
    repository.description = descriptionController.text;
    repository.language = languageController.text;

    return repository;
  }
}
