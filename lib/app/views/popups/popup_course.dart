import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
import '../../controllers/course_controller.dart';
import '../components/form_dropdown.dart';
import '../components/form_textfield.dart';
import '../components/main_button.dart';

class PopupCourse extends StatefulWidget {
  final CourseModel? course;
  final Function? onPopupClose;

  const PopupCourse({
    super.key,
    required this.course,
    this.onPopupClose,
  });

  @override
  State<PopupCourse> createState() => _PopupCourseState();
}

class _PopupCourseState extends State<PopupCourse> {
  final _courseController = CourseController();
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.course?.degree ?? 'Selecione';
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    _courseController.nameController =
        TextEditingController(text: widget.course?.name ?? '');
    _courseController.universityController =
        TextEditingController(text: widget.course?.university ?? '');
    _courseController.startDateController =
        TextEditingController(text: widget.course?.startDate ?? '');
    _courseController.finishDateController =
        TextEditingController(text: widget.course?.finishDate ?? '');
    _courseController.degreeController =
        TextEditingController(text: widget.course?.degree ?? '');

    return AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(widget.course != null ? 'Editar Curso' : 'Adicionar Curso'),
      ),
      content: Form(
        key: _courseController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormTextField(
              isDialog: true,
              labelText: 'Nome do Curso',
              textEditingController: _courseController.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do curso';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormTextField(
              isDialog: true,
              labelText: 'Instituição',
              textEditingController: _courseController.universityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome da Instituição';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormDropdown(
              value: selectedValue,
              items: ['Técnico', 'Tecnólogo', 'Graduação', 'Pós-Graduação']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                });
                _courseController.degreeController.text = value.toString();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o grau de formação';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: FormTextField(
                    isDialog: true,
                    labelText: 'Início',
                    textAlign: TextAlign.center,
                    textEditingController:
                        _courseController.startDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o ano de Início';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: FormTextField(
                    isDialog: true,
                    labelText: 'Término',
                    textAlign: TextAlign.center,
                    textEditingController:
                        _courseController.finishDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o ano de Término';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            )
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
                  Navigator.pop(context);
                },
                buttonWidth: 100,
                buttonHeight: 45,
              ),
              MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_courseController.formKey.currentState!.validate()) {
                    if (widget.course != null) {
                      _courseController.editCourse(widget.course!);
                    } else {
                      _courseController.addCourse();
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