import 'package:flutter/widgets.dart';

import '../models/certificate_model.dart';

class CertificateController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  DateTime? omissionDate;

  CertificateModel generateCertificate() {
    CertificateModel certificate = CertificateModel(
      name: nameController.text,
      organization: organizationController.text,
      omissionDate: omissionDate,
    );

    return certificate;
  }

  CertificateModel editCertificate(CertificateModel certificate) {
    certificate.name = nameController.text;
    certificate.organization = organizationController.text;
    certificate.omissionDate = omissionDate;

    return certificate;
  }
}
