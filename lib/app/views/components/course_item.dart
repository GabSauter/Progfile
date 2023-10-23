import 'package:flutter/material.dart';

import '../../models/course_model.dart';

class CourseItem extends StatelessWidget {
  final CourseModel course;

  const CourseItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.name,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
          ),
        ),
        Text(
          '${course.degree} - ${course.university}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          '${course.startDate} - ${course.finishDate}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
