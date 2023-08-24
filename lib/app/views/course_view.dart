import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
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
                      subtitle: const Text('Universidade'),
                      trailing: const Text('Periodo de tempo'),
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

        return AlertDialog(
          title: Text(course != null ? 'Editar Curso' : 'Adicionar Curso'),
          content: Form(
            key: _courseController.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome do Curso'),
                  controller: _courseController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome do curso';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Instituição'),
                  controller: _courseController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome da Instituição';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton(
                  value: 'Tec',
                  items: const [
                    DropdownMenuItem(
                      value: 'Tec',
                      child: Text('Tecnico'),
                    ),
                    DropdownMenuItem(
                      value: 'Tecno',
                      child: Text('Tecnologo'),
                    ),
                    DropdownMenuItem(
                      value: 'Grad',
                      child: Text('Graduacao'),
                    ),
                    DropdownMenuItem(
                      value: 'Pos',
                      child: Text('Pos-Graduacao'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ano de Início'),
                  controller: _courseController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome do curso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Ano de Término'),
                  controller: _courseController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome do curso';
                    }
                    return null;
                  },
                ),
                // ],
                // ),
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
                    text: course != null ? 'Salvar Edição' : 'Salvar',
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
