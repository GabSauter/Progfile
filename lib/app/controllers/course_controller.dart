import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progfile/app/models/course_model.dart';

class CourseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController finishDateController = TextEditingController();

  CourseModel generateCourse() {
    CourseModel course = CourseModel(
      name: nameController.text,
      university: universityController.text,
      degree: degreeController.text,
      startDate: startDateController.text,
      finishDate: finishDateController.text,
    );

    return course;
  }

  CourseModel editCourse(CourseModel course) {
    course.name = nameController.text;
    course.university = universityController.text;
    course.degree = degreeController.text;
    course.startDate = startDateController.text;
    course.finishDate = finishDateController.text;

    return course;
  }
}
