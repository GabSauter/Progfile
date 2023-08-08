import 'package:flutter/widgets.dart';
import 'package:progfile/app/services/certificate_service.dart';

import '../models/certificate_model.dart';

class CertificateController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  DateTime? omissionDate;

  Future<List<CertificateModel>> getCertificates() async {
    return await CertificateService().getAll();
  }

  void addCertificate() async {
    CertificateModel certificate = CertificateModel(
      name: nameController.text,
      organization: organizationController.text,
      omissionDate: omissionDate,
    );
    await CertificateService().create(certificate);
  }

  void editCertificate(CertificateModel certificate) async {
    certificate.name = nameController.text;
    certificate.organization = organizationController.text;
    certificate.omissionDate = omissionDate;

    await CertificateService().edit(certificate.id, certificate);
  }

  void removeCertificate(String id) async {
    await CertificateService().delete(id);
  }
}
