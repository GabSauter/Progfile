import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
import '../../controllers/course_controller.dart';
import 'form_dropdown.dart';
import 'form_textfield.dart';
import 'main_button.dart';

class PopupCourse extends StatefulWidget {
  final CourseModel? course;
  const PopupCourse({
    super.key,
    required this.course,
  });

  @override
  State<PopupCourse> createState() => _PopupCourseState();
}

class _PopupCourseState extends State<PopupCourse> {
  final _courseController = CourseController();

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

    String selectedValue = widget.course?.degree ?? 'Tec';

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
              items: const [
                DropdownMenuItem(
                  value: 'Tec',
                  child: Text('Técnico'),
                ),
                DropdownMenuItem(
                  value: 'Tecno',
                  child: Text('Tecnólogo'),
                ),
                DropdownMenuItem(
                  value: 'Grad',
                  child: Text('Graduação'),
                ),
                DropdownMenuItem(
                  value: 'Pos',
                  child: Text('Pós-Graduacao'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                  _courseController.degreeController.text = value.toString();
                });
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
                      setState(() {});
                    } else {
                      _courseController.addCourse();
                      setState(() {});
                    }
                    Navigator.pop(context);
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
