import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/profile_model.dart';

class ProfileRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<ProfileModel> _profiles = [];

  ProfileModel _myProfile = ProfileModel(
      id: null,
      name: '',
      email: '',
      phoneNumber: '',
      address: '',
      fieldOfExpertise: '',
      degree: '',
      aboutYou: '');

  UnmodifiableListView<ProfileModel> get list =>
      UnmodifiableListView(_profiles);

  ProfileModel get myProfile => _myProfile;

  ProfileRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getProfiles();
    await getMyProfile();
  }

  getMyProfile() async {
    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (!snapshot.exists) {
      return;
    }

    _myProfile = ProfileModel.fromMap(snapshot.data()!);
    _myProfile.id = snapshot.id;

    notifyListeners();
  }

  getProfiles() async {
    _profiles.clear();

    final snapshot = await _db.collection("curriculum").get();

    for (var doc in snapshot.docs) {
      ProfileModel profile = ProfileModel.fromMap(doc.data());
      profile.id = doc.id;
      _profiles.add(profile);
    }

    notifyListeners();
  }

  create(ProfileModel curriculum) async {
    final doc = await _db.collection("curriculum").add(curriculum.toMap());

    curriculum.id = doc.id;
    _profiles.add(curriculum);

    notifyListeners();
  }

  edit(ProfileModel curriculum) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(curriculum.toMap(), SetOptions(merge: true));

    final index =
        _profiles.indexWhere((element) => element.id == curriculum.id);
    _profiles[index] = curriculum;

    notifyListeners();
  }

  delete(String curriculumId) async {
    await _db.collection("curriculum").doc(curriculumId).delete();

    _profiles.removeWhere((element) => element.id == curriculumId);

    notifyListeners();
  }

  void reset() {
    _profiles = [];
    _myProfile = ProfileModel(
        id: null,
        name: '',
        email: '',
        phoneNumber: '',
        address: '',
        fieldOfExpertise: '',
        degree: '',
        aboutYou: '');
    notifyListeners();
  }
}
