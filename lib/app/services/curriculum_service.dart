import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/curriculum_model.dart';

class CurriculumService {
  final _db = FirebaseFirestore.instance;

  Future<void> createCurriculum(CurriculumModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(curriculum.toMap());
  }

  Future<void> edit(CurriculumModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(curriculum.toMap());
  }

  Future<void> delete() async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    await ref.delete();
  }

  Future<CurriculumModel?> get() async {
    CurriculumModel? myCurriculum;

    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    ref.get().then(
      (DocumentSnapshot doc) {
        myCurriculum = CurriculumModel(
            image: doc.get("image"),
            name: doc.get("name"),
            email: doc.get("email"),
            phoneNumber: doc.get("phoneNumber"),
            githubUsername: doc.get("githubUsername"),
            address: doc.get("address"),
            fieldOfExpertise: doc.get("fieldOfExpertise"),
            aboutYou: doc.get("aboutYou"),
            degree: doc.get("degree"));
      },
    );

    return myCurriculum;
  }
}
