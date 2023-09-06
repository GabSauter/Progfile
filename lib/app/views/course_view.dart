import 'package:flutter/material.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/views/components/popup_course.dart';

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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Início'),
                        controller: _courseController.startDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a data inicial';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8), // Espaço entre os campos
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Término'),
                        controller: _courseController.finishDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a data final';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
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
              child: Text(course != null ? 'Salvar Edição' : 'Salvar'),
            ),
          ],
        );
      },
    );
  }
}
