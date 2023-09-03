import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';

import '../controllers/course_controller.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  final _courseController = CourseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _courseController.getCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data![index].name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      _courseController.removeCourse(snapshot.data![index].id);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].university),
                      trailing: Text(
                        '${snapshot.data![index].startDate} - ${snapshot.data![index].finishDate}',
                      ),
                      onTap: () =>
                          _showAddCourseDialog(course: snapshot.data![index]),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(child: Text("Algo deu errado."));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCourseDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCourseDialog({CourseModel? course}) {
    showDialog(
      context: context,
      builder: (context) {
        _courseController.nameController =
            TextEditingController(text: course?.name ?? '');
        _courseController.universityController =
            TextEditingController(text: course?.university ?? '');
        _courseController.startDateController =
            TextEditingController(text: course?.startDate ?? '');
        _courseController.finishDateController =
            TextEditingController(text: course?.finishDate ?? '');
        _courseController.degreeController =
            TextEditingController(text: course?.degree ?? '');

        return AlertDialog(
          scrollable: true,
          title: Text(course != null ? 'Editar Curso' : 'Adicionar Curso'),
          content: Form(
            key: _courseController.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
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
                DropdownButton(
                  value: 'Tec',
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
                    _courseController.degreeController.text = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                FormTextField(
                  isDialog: true,
                  labelText: 'Ano de Início',
                  textEditingController: _courseController.startDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o ano de Início';
                    }
                    return null;
                  },
                ),
                FormTextField(
                  isDialog: true,
                  labelText: 'Ano de Término',
                  textEditingController: _courseController.finishDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o ano de Término';
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
                      Navigator.pop(context);
                    },
                    buttonWidth: 100,
                    buttonHeight: 45,
                  ),
                  MainButton(
                    text: 'Salvar',
                    onPressedCallback: () {
                      if (_courseController.formKey.currentState!.validate()) {
                        if (course != null) {
                          _courseController.editCourse(course);
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
      },
    );
  }
}
