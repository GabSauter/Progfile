class CertificateModel {
  late String id;
  String name;
  String organization;
  DateTime? omissionDate;

  CertificateModel(
      {required this.name,
      required this.organization,
      required this.omissionDate});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'organization': organization,
      'date': omissionDate?.toUtc(),
    };
  }
}
