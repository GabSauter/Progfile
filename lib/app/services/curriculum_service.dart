import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progfile/app/models/curriculum_model.dart';

class CurriculumService {
  final _db = FirebaseFirestore.instance;

  Future<void> createCurriculum(CurriculumModel curriculum) async {
    await _db.collection("curriculum").add(curriculum.toMap());
  }
}
