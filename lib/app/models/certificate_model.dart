import 'package:cloud_firestore/cloud_firestore.dart';

class CertificateModel {
  String? id;
  String name;
  String organization;
  DateTime? omissionDate;

  CertificateModel({
    required this.name,
    required this.organization,
    required this.omissionDate,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'organization': organization,
      'date': omissionDate?.toUtc(),
    };
  }

  factory CertificateModel.fromMap(Map<String, dynamic> map) {
    return CertificateModel(
      id: map['id'],
      name: map['name'],
      organization: map['organization'],
      omissionDate: (map['date'] as Timestamp?)?.toDate(),
    );
  }
}
