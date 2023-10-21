import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/profile_model.dart';

class ProfileRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<ProfileModel> _profiles = [];

  UnmodifiableListView<ProfileModel> get list =>
      UnmodifiableListView(_profiles);

  ProfileRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getCurriculums();
  }

  _getCurriculums() async {
    _profiles.clear();

    final snapshot = await _db.collection("curriculum").get();

    for (var doc in snapshot.docs) {
      ProfileModel curriculum = ProfileModel.fromMap(doc.data());
      curriculum.id = doc.id;
      _profiles.add(curriculum);
    }

    notifyListeners();
  }

  Future<void> create(ProfileModel curriculum) async {
    final doc = await _db.collection("curriculum").add(curriculum.toMap());

    curriculum.id = doc.id;
    _profiles.add(curriculum);

    notifyListeners();
  }

  Future<void> edit(ProfileModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(curriculum.toMap(), SetOptions(merge: true));

    final index =
        _profiles.indexWhere((element) => element.id == curriculum.id);
    _profiles[index] = curriculum;

    notifyListeners();
  }

  Future<void> delete(String curriculumId) async {
    await _db.collection("curriculum").doc(curriculumId).delete();

    _profiles.removeWhere((element) => element.id == curriculumId);

    notifyListeners();
  }

  ProfileModel myCurriculum() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      for (var resume in _profiles) {
        if (resume.id == user.uid) {
          return resume;
        }
      }
    }

    return ProfileModel(
        id: null,
        name: '',
        email: '',
        phoneNumber: '',
        address: '',
        fieldOfExpertise: '',
        degree: '',
        aboutYou: '');
  }
}
