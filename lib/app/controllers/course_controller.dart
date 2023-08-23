import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/services/course_service.dart';

class CourseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();

  Future<List<CourseModel>> getCourses() async {
    return await CourseService().getAll();
  }

  void addCourse() async {
    CourseModel course = CourseModel(
      name: nameController.text,
      university: universityController.text,
      degree: degreeController.text,
      startDate: startDateController.text,
      finishDate: finishDateController.text,
    );
    await CourseService().create(course);
  }

  void editCourse(CourseModel course) async {
    course.name = nameController.text;
    course.university = universityController.text;
    course.degree = degreeController.text;
    course.startDate = startDateController.text;
    course.finishDate = finishDateController.text;

    await CourseService().edit(course.id, course);
  }

  void removeCourse(String id) async {
    await CourseService().delete(id);
  }
}
