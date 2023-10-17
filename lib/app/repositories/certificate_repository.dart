import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/certificate_model.dart';

class CertificateRepository extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  final List<CertificateModel> _certificates = [];

  UnmodifiableListView<CertificateModel> get list =>
      UnmodifiableListView(_certificates);

  CertificateRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getCertificates();
  }

  _getCertificates() async {
    _certificates.clear();

    final snapshot = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .get();

    for (var doc in snapshot.docs) {
      CertificateModel certificate = CertificateModel.fromMap(doc.data());
      certificate.id = doc.id;
      _certificates.add(certificate);
    }

    notifyListeners();
  }

  Future<void> create(CertificateModel certificate) async {
    final doc = await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .add(certificate.toMap());

    certificate.id = doc.id;
    _certificates.add(certificate);

    notifyListeners();
  }

  Future<void> edit(CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificate.id)
        .update(certificate.toMap());

    int indexToEdit =
        _certificates.indexWhere((cert) => cert.id == certificate.id);
    if (indexToEdit != -1) {
      _certificates[indexToEdit] = certificate;
      notifyListeners();
    }
  }

  Future<void> delete(String certificateId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId);

    await ref.delete();

    _certificates.removeWhere((cert) => cert.id == certificateId);
    notifyListeners();
  }
}
