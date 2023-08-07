import 'package:flutter/widgets.dart';
import 'package:progfile/app/services/certificate_service.dart';

import '../models/certificate_model.dart';

class CertificateController {
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  DateTime? omissionDate;

  Future<List<CertificateModel>> getCertificates() async {
    return await CertificateService().getCertificates();
  }

  void addCertificate(CertificateModel certificate) async {
    await CertificateService().createCertificate(certificate);
  }

  void editCertificate(CertificateModel certificate, String name,
      String organization, DateTime? omissionDate) async {
    certificate.name = name;
    certificate.organization = organization;
    certificate.omissionDate = omissionDate;

    await CertificateService().editCertificate(certificate.id, certificate);
  }

  void removeCertificate(String id) async {
    await CertificateService().deleteCertificate(id);
  }
}
