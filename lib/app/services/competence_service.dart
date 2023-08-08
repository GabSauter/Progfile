import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/competence_model.dart';

class CompetenceService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(CompetenceModel competence) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .doc()
        .set(competence.toMap());
  }

  Future<void> edit(String competenceId, CompetenceModel competence) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .doc(competenceId)
        .set(competence.toMap());
  }

  Future<void> delete(String competenceId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .doc(competenceId);

    await ref.delete();
  }

  Future<List<CompetenceModel>> getAll() async {
    List<CompetenceModel> competences = [];

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      CompetenceModel competence = CompetenceModel(
        name: doc.get("name"),
        degree: doc.get("degree"),
      );
      competence.id = doc.id;
      competences.add(competence);
    }

    return competences;
  }
}
