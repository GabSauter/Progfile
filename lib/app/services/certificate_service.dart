import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/certificate_model.dart';

class CertificateService {
  final _db = FirebaseFirestore.instance;

  Future<void> createCertificate(CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc()
        .set(certificate.toMap());
  }

  Future<void> editCertificate(
      String certificateId, CertificateModel certificate) async {
    await _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId)
        .set(certificate.toMap());
  }

  Future<void> deleteCertificate(String certificateId) async {
    DocumentReference certificateRef = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate")
        .doc(certificateId);

    await certificateRef.delete();
  }

  Future<List<CertificateModel>> getCertificates() async {
    List<CertificateModel> certificates = [];

    CollectionReference certificateCollection = _db
        .collection("curriculum")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("certificate");

    QuerySnapshot snapshot = await certificateCollection.get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      CertificateModel certificate = CertificateModel(
        name: doc.get("name"),
        organization: doc.get("organization"),
        omissionDate: (doc.get("date") as Timestamp?)?.toDate(),
      );
      certificates.add(certificate);
    }

    return certificates;
  }
}
