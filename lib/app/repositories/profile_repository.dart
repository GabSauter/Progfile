import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/profile_model.dart';

class ProfileRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<ProfileModel> _profiles = [];
  bool _loaded = false;

  ProfileModel _myProfile = ProfileModel(
    id: null,
    name: '',
    email: '',
    phoneNumber: '',
    address: '',
    fieldOfExpertise: '',
    degree: '',
    aboutYou: '',
    githubUsername: '',
  );

  UnmodifiableListView<ProfileModel> get list =>
      UnmodifiableListView(_profiles);

  ProfileModel get myProfile => _myProfile;
  bool get isLoaded => _loaded;

  String getGitUsername(String userId) {
    final index = _profiles.indexWhere((element) => element.id == userId);

    return _profiles[index].githubUsername;
  }

  ProfileRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getProfiles();
    await getMyProfile();
  }

  getMyProfile() async {
    _loaded = false;
    notifyListeners();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (!snapshot.exists) {
      return;
    }

    _myProfile = ProfileModel.fromMap(snapshot.data()!);
    _myProfile.id = snapshot.id;

    _loaded = true;
    notifyListeners();
  }

  getProfiles() async {
    _loaded = false;
    notifyListeners();

    _profiles.clear();

    final snapshot = await _db.collection("curriculum").get();

    for (var doc in snapshot.docs) {
      ProfileModel profile = ProfileModel.fromMap(doc.data());
      profile.id = doc.id;
      _profiles.add(profile);
    }

    _loaded = true;
    notifyListeners();
  }

  create(ProfileModel curriculum) async {
    DocumentReference doc = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await doc.set(curriculum.toMap());

    curriculum.id = doc.id;
    _profiles.add(curriculum);
    getMyProfile();
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

  saveImage(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("Images");
    if (FirebaseAuth.instance.currentUser != null) {
      final userImageRef =
          imagesRef.child(FirebaseAuth.instance.currentUser!.uid);
      await userImageRef.putFile(File(image.path));
      final downloadImageURL = await userImageRef.getDownloadURL();
      return downloadImageURL;
    }
    return null;
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
      aboutYou: '',
      githubUsername: '',
    );

    _loaded = false;
    notifyListeners();
  }
}
