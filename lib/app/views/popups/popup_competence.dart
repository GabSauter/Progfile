import 'package:flutter/material.dart';
import 'package:progfile/app/controllers/competence_controller.dart';
import 'package:progfile/app/models/competence_model.dart';
import '../components/form_dropdown.dart';
import '../components/form_textfield.dart';
import '../components/main_button.dart';

class PopupCompetence extends StatefulWidget {
  final CompetenceModel? competence;
  final Function? onPopupClose;

  const PopupCompetence({
    super.key,
    required this.competence,
    this.onPopupClose,
  });

  @override
  State<PopupCompetence> createState() => _PopupCompetence();
}

class _PopupCompetence extends State<PopupCompetence> {
  final _competenceController = CompetenceController();
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.competence?.degree ?? 'Básico';

    _competenceController.degreeController.text = selectedValue;

    _competenceController.nameController.text =
        widget.competence?.name ?? _competenceController.nameController.text;
    _competenceController.degreeController.text = widget.competence?.degree ??
        _competenceController.degreeController.text;
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
        child: Text(widget.competence != null
            ? 'Editar Competência'
            : 'Adicionar Competência'),
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
                  _competenceController.nameController.text = "";
                  _competenceController.degreeController.text = "";
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_competenceController.formKey.currentState!.validate()) {
                    if (widget.competence != null) {
                      _competenceController.editCompetence(widget.competence!);
                    } else {
                      _competenceController.addCompetence();
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
      key: _competenceController.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormTextField(
            isDialog: true,
            labelText: 'Competência',
            length: 20,
            textEditingController: _competenceController.nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a Competência';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          FormDropdown(
            items: ['Básico', 'Intermediário', 'Avançado']
                .map((grade) => DropdownMenuItem<String>(
                      value: grade,
                      child: Text(grade),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) => setState(() {
              selectedValue = value;
              _competenceController.degreeController.text = selectedValue;
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe o seu grau de competência';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
