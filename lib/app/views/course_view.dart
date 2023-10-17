import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course_model.dart';
import '../repositories/course_repository.dart';
import 'popups/popup_course.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    final courses = context.watch<CourseRepository>();

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
      body: ListView.builder(
                itemCount: courses.list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(courses.list[index].name),
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
                      courses.delete(courses.list[index].id!);
                    },
                    child: ListTile(
                      title: Text(courses.list[index].name),
                      subtitle: Text(courses.list[index].university),
                      trailing: Text(
                        '${courses.list[index].startDate} - ${courses.list[index].finishDate}',
                      ),
                      onTap: () =>
                          _showAddCourseDialog(course: courses.list[index]),
                    ),
                  );
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
        return PopupCourse(course: course);
      },
    );
  }
}
