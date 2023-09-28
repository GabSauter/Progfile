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

  Future<void> create(CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc()
        .set(certificate.toMap());

    _certificates.add(certificate);

    notifyListeners();
  }

  Future<void> edit(String certificateId, CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId)
        .set(certificate.toMap());

    int indexToEdit =
        _certificates.indexWhere((cert) => cert.id == certificateId);
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

  _getCertificates() async {
    _certificates.clear();

    CollectionReference collection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate");

    QuerySnapshot snapshot = await collection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      CertificateModel certificate = CertificateModel(
        name: doc.get("name"),
        organization: doc.get("organization"),
        omissionDate: (doc.get("date") as Timestamp?)?.toDate(),
      );
      certificate.id = doc.id;
      _certificates.add(certificate);
    }
    notifyListeners();
  }
}
