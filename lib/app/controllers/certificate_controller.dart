import 'package:flutter/widgets.dart';

import '../models/certificate_model.dart';

class CertificateController {
  final nameController = TextEditingController();
  final organizationController = TextEditingController();
  DateTime? omissionDate;

  final List<CertificateModel> _certificates = [];

  int getCertificatesCount() {
    return _certificates.length;
  }

  CertificateModel getCertificate(int index) {
    return _certificates[index];
  }

  void addCertificate(CertificateModel certificate) {
    _certificates.add(certificate);
  }

  void editCertificate(CertificateModel certificate, String name,
      String organization, DateTime? omissionDate) {
    certificate.name = name;
    certificate.organization = organization;
    certificate.omissionDate = omissionDate;
  }

  void removeCertificate(int index) {
    _certificates.removeAt(index);
  }
}
