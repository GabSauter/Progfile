import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/language_model.dart';

class LanguageService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(LanguageModel language) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .doc()
        .set(language.toMap());
  }

  Future<void> edit(String languageId, LanguageModel language) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .doc(languageId)
        .set(language.toMap());
  }

  Future<void> delete(String languageId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .doc(languageId);

    await ref.delete();
  }

  Future<List<LanguageModel>> getAll() async {
    List<LanguageModel> languages = [];

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      LanguageModel language = LanguageModel(
        name: doc.get("name"),
        degree: doc.get("degree"),
      );
      language.id = doc.id;
      languages.add(language);
    }

    return languages;
  }
}
