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
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.language?.degree ?? 'Básico';

    _languageController.degreeController.text = selectedValue;

    _languageController.nameController.text =
        widget.language?.name ?? _languageController.nameController.text;
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: Center(
        child: Text(
            widget.language != null ? 'Editar Idioma' : 'Adicionar Idioma'),
      ),
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
                  _languageController.nameController.text = "";
                  _languageController.degreeController.text = "";
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: MainButton(
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
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget content() {
    return Form(
      key: _languageController.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormTextField(
            isDialog: true,
            labelText: 'Idioma',
            length: 20,
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
            onChanged: (value) => setState(() => {
                  selectedValue = value,
                  _languageController.degreeController.text = selectedValue
                }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o seu grau de idioma';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
