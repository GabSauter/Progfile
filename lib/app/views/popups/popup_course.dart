import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/repositories/course_repository.dart';
import 'package:progfile/app/repositories/curriculum_repository.dart';
import 'package:provider/provider.dart';
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
  late CurriculumRepository curriculum;
  late CourseRepository listCourses;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.course?.degree ?? 'Técnico';

    _courseController.degreeController.text = selectedValue;

    _courseController.nameController.text =
        widget.course?.name ?? _courseController.nameController.text;
    _courseController.universityController.text = widget.course?.university ??
        _courseController.universityController.text;
    _courseController.startDateController.text =
        widget.course?.startDate ?? _courseController.startDateController.text;
    _courseController.finishDateController.text = widget.course?.finishDate ??
        _courseController.finishDateController.text;
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    curriculum = context.watch<CurriculumRepository>();
    listCourses = context.watch<CourseRepository>();

    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: Center(
        child: Text(widget.course != null ? 'Editar Curso' : 'Adicionar Curso'),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      content: content(context),
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
                  _courseController.nameController.text = "";
                  _courseController.universityController.text = "";
                  _courseController.startDateController.text = "";
                  _courseController.finishDateController.text = "";
                  _courseController.degreeController.text = "";
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_courseController.formKey.currentState!.validate()) {
                    if (widget.course != null) {
                      listCourses
                          .edit(_courseController.editCourse(widget.course!));
                    } else {
                      listCourses.create(_courseController.generateCourse());
                    }
                    curriculum.getMyCurriculum();
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

  Widget content(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Form(
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
              items: ['Técnico', 'Tecnólogo', 'Graduação', 'Pós-Graduação']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (value) => setState(() {
                selectedValue = value;
                _courseController.degreeController.text = selectedValue;
              }),
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
                    isNumeric: true,
                    length: 4,
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
                    isNumeric: true,
                    length: 4,
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
    );
  }
}
