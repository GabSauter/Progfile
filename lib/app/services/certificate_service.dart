import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/certificate_model.dart';

class CertificateService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc()
        .set(certificate.toMap());
  }

  Future<void> edit(String certificateId, CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId)
        .set(certificate.toMap());
  }

  Future<void> delete(String certificateId) async {
    DocumentReference ref = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId);

    await ref.delete();
  }

  Future<List<CertificateModel>> getAll() async {
    List<CertificateModel> certificates = [];

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
      certificates.add(certificate);
    }

    return certificates;
  }
}
