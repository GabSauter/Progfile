import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/course_model.dart';

class CourseService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(CourseModel course) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .doc()
        .set(course.toMap());
  }

  Future<void> edit(String courseId, CourseModel course) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .doc(courseId)
        .set(course.toMap());
  }

  Future<void> delete(String courseId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course")
        .doc(courseId);

    await ref.delete();
  }

  Future<List<CourseModel>> getAll() async {
    List<CourseModel> courses = [];

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("course");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      CourseModel course = CourseModel(
          name: doc.get("name"),
          degree: doc.get("degree"),
          university: doc.get("university"),
          startDate: doc.get("startDate"),
          finishDate: doc.get("finishDate"));
      course.id = doc.id;
      courses.add(course);
    }

    return courses;
  }
}
