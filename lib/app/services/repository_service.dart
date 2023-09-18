import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/repository_model.dart';

class RepositoryService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(RepositoryModel repository) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("repository")
        .doc()
        .set(repository.toMap());
  }

  Future<void> edit(String repositoryId, RepositoryModel repository) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("repository")
        .doc(repositoryId)
        .set(repository.toMap());
  }

  Future<void> delete(String repositoryId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("repository")
        .doc(repositoryId);

    await ref.delete();
  }

  Future<List<RepositoryModel>> getAll() async {
    List<RepositoryModel> repositories = [];

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("repository");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      RepositoryModel repository = RepositoryModel(
        name: doc.get("name"),
        url: doc.get("url"),
        description: doc.get("description"),
        language: doc.get("language"),
      );
      repository.id = doc.id;
      repositories.add(repository);
    }

    return repositories;
  }
}
