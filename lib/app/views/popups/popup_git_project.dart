import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/git_project_controller.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/repositories/git_project_repository.dart';
import 'package:provider/provider.dart';
import '../components/form_textfield.dart';

class PopupGitProject extends StatefulWidget {
  final GitProjectModel? repository;
  final Function? onPopupClose;

  const PopupGitProject({
    super.key,
    required this.repository,
    this.onPopupClose,
  });

  @override
  State<PopupGitProject> createState() => _PopupGitProjectState();
}

class _PopupGitProjectState extends State<PopupGitProject> {
  final _repositoryController = GitProjectController();
  late GitProjectRepository listProjects;

  @override
  void initState() {
    super.initState();

    _repositoryController.nameController.text =
        widget.repository?.name ?? _repositoryController.nameController.text;
    _repositoryController.urlController.text =
        widget.repository?.url ?? _repositoryController.urlController.text;
    _repositoryController.languageController.text =
        widget.repository?.language ??
            _repositoryController.languageController.text;
    _repositoryController.descriptionController.text =
        widget.repository?.description ??
            _repositoryController.descriptionController.text;
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    listProjects = context.watch<GitProjectRepository>();

    return AlertDialog(
      scrollable: true,
      title: const Center(
        child: Text('Editar Repositório'),
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      content: content(),
      actionsPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: 20,
      ),
    );
  }

  Widget content() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Form(
        key: _repositoryController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FormTextField(
              isDialog: true,
              labelText: 'Url do Repositório',
              textEditingController: _repositoryController.urlController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a url';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormTextField(
              isDialog: true,
              labelText: 'Nome do Repositório',
              textEditingController: _repositoryController.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormTextField(
              isDialog: true,
              labelText: 'Linguagens utilizadas',
              textEditingController: _repositoryController.languageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a linguagem';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormTextField(
              isDialog: true,
              labelText: 'Descrição',
              textEditingController:
                  _repositoryController.descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a descrição';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
