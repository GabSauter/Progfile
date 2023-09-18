import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/repository_controller.dart';
import 'package:progfile/app/models/repository_model.dart';
import '../components/form_textfield.dart';
import '../components/main_button.dart';

class PopupRepository extends StatefulWidget {
  final RepositoryModel? repository;
  final Function? onPopupClose;

  const PopupRepository({
    super.key,
    required this.repository,
    this.onPopupClose,
  });

  @override
  State<PopupRepository> createState() => _PopupRepositoryState();
}

class _PopupRepositoryState extends State<PopupRepository> {
  final _repositoryController = RepositoryController();

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    _repositoryController.nameController = TextEditingController(
        text: widget.repository?.name ??
            _repositoryController.nameController.text);
    _repositoryController.urlController = TextEditingController(
        text:
            widget.repository?.url ?? _repositoryController.urlController.text);
    _repositoryController.languageController = TextEditingController(
        text: widget.repository?.language ??
            _repositoryController.languageController.text);
    _repositoryController.descriptionController = TextEditingController(
        text: widget.repository?.description ??
            _repositoryController.descriptionController.text);

    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(widget.repository != null
            ? 'Editar Repositório'
            : 'Adicionar Repositório'),
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
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: MainButton(
                text: 'Cancelar',
                onPressedCallback: () {
                  _repositoryController.nameController.text = "";
                  _repositoryController.urlController.text = "";
                  _repositoryController.descriptionController.text = "";
                  _repositoryController.languageController.text = "";
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_repositoryController.formKey.currentState!.validate()) {
                    if (widget.repository != null) {
                      _repositoryController.editRepository(widget.repository!);
                    } else {
                      _repositoryController.addRepository();
                    }
                    _onDialogClose();
                  }
                },
              ),
            ),
          ],
        ),
      ],
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
          ],
        ),
      ),
    );
  }
}
