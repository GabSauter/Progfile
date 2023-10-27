import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/models/competence_model.dart';

class CompetenceRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<CompetenceModel> _competences = [];

  UnmodifiableListView<CompetenceModel> get list =>
      UnmodifiableListView(_competences);

  CompetenceRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getCompetences();
  }

  getCompetences() async {
    _competences.clear();

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      CompetenceModel competence = CompetenceModel(
        id: doc.id,
        name: doc.get("name"),
        degree: doc.get("degree"),
      );
      _competences.add(competence);
    }
    notifyListeners();
  }

  Future<void> create(CompetenceModel competence) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .add(competence.toMap());

    competence.id = doc.id;
    _competences.add(competence);
    notifyListeners();
  }

  Future<void> edit(CompetenceModel competence) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .doc(competence.id)
        .update(competence.toMap());
    _competences[_competences
        .indexWhere((element) => element.id == competence.id)] = competence;
    notifyListeners();
  }

  Future<void> delete(String competenceId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("competence")
        .doc(competenceId);

    await ref.delete();

    _competences.removeWhere((comp) => comp.id == competenceId);
    notifyListeners();
  }
}
