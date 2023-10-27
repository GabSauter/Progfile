import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/models/language_model.dart';

class LanguageRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<LanguageModel> _languages = [];

  UnmodifiableListView<LanguageModel> get list =>
      UnmodifiableListView(_languages);

  LanguageRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getLanguages();
    notifyListeners();
  }

  getLanguages() async {
    _languages.clear();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .get();

    for (var doc in snapshot.docs) {
      LanguageModel language = LanguageModel.fromMap(doc.data());
      language.id = doc.id;
      _languages.add(language);
    }
    notifyListeners();
  }

  Future<void> create(LanguageModel language) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .add(language.toMap());

    language.id = doc.id;
    _languages.add(language);
    notifyListeners();
  }

  Future<void> edit(String languageId, LanguageModel language) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .doc(languageId)
        .set(language.toMap());

    int indexToEdit = _languages.indexWhere((lang) => lang.id == languageId);
    if (indexToEdit != -1) {
      _languages[indexToEdit] = language;
      notifyListeners();
    }
  }

  Future<void> delete(String languageId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("language")
        .doc(languageId);

    await ref.delete();

    _languages.removeWhere((lang) => lang.id == languageId);
    notifyListeners();
  }
}
