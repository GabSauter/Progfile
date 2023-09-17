import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/language_controller.dart';
import 'package:progfile/app/models/language_model.dart';
import '../components/form_dropdown.dart';
import '../components/form_textfield.dart';
import '../components/main_button.dart';

class PopupLanguage extends StatefulWidget {
  final LanguageModel? language;
  final Function? onPopupClose;

  const PopupLanguage({
    super.key,
    required this.language,
    this.onPopupClose,
  });

  @override
  State<PopupLanguage> createState() => _PopupCoursLanguage();
}

class _PopupCoursLanguage extends State<PopupLanguage> {
  final _languageController = LanguageController();
  String selectedValue = 'Básico';

  @override
  void initState() {
    super.initState();
    _languageController.degreeController.text =
        widget.language?.degree ?? 'Básico';
    selectedValue = _languageController.degreeController.text == ''
        ? 'Básico'
        : _languageController.degreeController.text;
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    _languageController.nameController = TextEditingController(
        text: widget.language?.name ?? _languageController.nameController.text);
    _languageController.degreeController = TextEditingController(
        text: widget.language?.degree ??
            _languageController.degreeController.text);

    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(
            widget.language != null ? 'Editar Idioma' : 'Adicionar Idioma'),
      ),
      content: Form(
        key: _languageController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormTextField(
              isDialog: true,
              labelText: 'Idioma',
              textEditingController: _languageController.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o idioma';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormDropdown(
              items: ['Básico', 'Intermediário', 'Avançado', 'Fluente']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) {
                selectedValue = value.toString();
                _languageController.degreeController.text = selectedValue;

                if (widget.language != null) {
                  widget.language?.name =
                      _languageController.nameController.text;
                  widget.language?.degree =
                      _languageController.degreeController.text;
                }

                setState(() {});
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o seu grau de idioma';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                text: 'Cancelar',
                onPressedCallback: () {
                  _languageController.nameController.text = "";
                  _languageController.degreeController.text = "";
                  Navigator.pop(context);
                },
                buttonWidth: 100,
                buttonHeight: 45,
              ),
              MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_languageController.formKey.currentState!.validate()) {
                    if (widget.language != null) {
                      _languageController.editLanguage(widget.language!);
                    } else {
                      _languageController.addLanguage();
                    }
                    _onDialogClose();
                  }
                },
                buttonWidth: 100,
                buttonHeight: 45,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
