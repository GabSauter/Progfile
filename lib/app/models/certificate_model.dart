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
      'id': id,
      'name': name,
      'organization': organization,
      'date': omissionDate?.toUtc(),
    };
  }
}
