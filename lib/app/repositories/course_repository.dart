import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';

class CourseRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<CourseModel> _courses = [];

  UnmodifiableListView<CourseModel> get list => UnmodifiableListView(_courses);

  getCourses() async {
    _courses.clear();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .get();

    for (var doc in snapshot.docs) {
      CourseModel course = CourseModel.fromMap(doc.data());
      course.id = doc.id;
      _courses.add(course);
    }

    notifyListeners();
  }

  Future<void> create(CourseModel course) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .add(course.toMap());

    course.id = doc.id;
    _courses.add(course);

    notifyListeners();
  }

  Future<void> edit(CourseModel course) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .doc(course.id)
        .update(course.toMap());

    int indexToEdit = _courses.indexWhere((c) => c.id == course.id);

    if (indexToEdit != -1) {
      _courses[indexToEdit] = course;
      notifyListeners();
    }
  }

  Future<void> delete(String courseId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .doc(courseId);

    await ref.delete();

    _courses.removeWhere((c) => c.id == courseId);
    notifyListeners();
  }
}
