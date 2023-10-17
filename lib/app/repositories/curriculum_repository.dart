import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/curriculum_model.dart';

class CurriculumRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<CurriculumModel> _curriculums = [];

  UnmodifiableListView<CurriculumModel> get list =>
      UnmodifiableListView(_curriculums);

  CurriculumRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getCurriculums();
  }

  _getCurriculums() async {
    _curriculums.clear();

    final snapshot = await _db.collection("curriculum").get();

    for (var doc in snapshot.docs) {
      CurriculumModel curriculum = CurriculumModel.fromMap(doc.data());
      _curriculums.add(curriculum);
    }

    notifyListeners();
  }

  Future<void> create(CurriculumModel curriculum) async {
    final doc = await _db.collection("curriculum").add(curriculum.toMap());

    curriculum.id = doc.id;
    _curriculums.add(curriculum);

    notifyListeners();
  }

  Future<void> edit(CurriculumModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(curriculum.id)
        .update(curriculum.toMap());

    final index =
        _curriculums.indexWhere((element) => element.id == curriculum.id);
    _curriculums[index] = curriculum;

    notifyListeners();
  }

  Future<void> delete(String curriculumId) async {
    await _db.collection("curriculum").doc(curriculumId).delete();

    _curriculums.removeWhere((element) => element.id == curriculumId);

    notifyListeners();
  }

  Future<CurriculumModel?> myCurriculum() async {
    final user = FirebaseAuth.instance.currentUser;

    final snapshot = await FirebaseFirestore.instance
        .collection("curriculum")
        .where("userId", isEqualTo: user?.uid)
        .get();

    print(user!.uid);
    if (snapshot.docs.isEmpty) {
      return null;
    }

    return CurriculumModel.fromMap(snapshot.docs.first.data());
  }
}
