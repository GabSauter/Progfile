import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/profile_model.dart';

class ProfileService {
  final _db = FirebaseFirestore.instance;

  Future<void> createCurriculum(ProfileModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(curriculum.toMap());
  }

  Future<void> edit(ProfileModel curriculum) async {
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

  Future<ProfileModel?> get() async {
    ProfileModel? myCurriculum;

    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    ref.get().then(
      (DocumentSnapshot doc) {
        myCurriculum = ProfileModel(
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
