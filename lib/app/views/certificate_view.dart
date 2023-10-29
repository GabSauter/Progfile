import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progfile/app/repositories/certificate_repository.dart';
import 'package:provider/provider.dart';
import '../models/certificate_model.dart';
import 'popups/popup_certificate.dart';

class CertificateView extends StatelessWidget {
  const CertificateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CertificateRepository? certificateRepository;
    List<CertificateModel> certificates = [];

    if (ModalRoute.of(context)!.settings.arguments != null) {
      certificates =
          ModalRoute.of(context)!.settings.arguments as List<CertificateModel>;
    } else {
      certificateRepository = context.watch<CertificateRepository>();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificados'),
      ),
      body: certificateRepository != null
          ? ListView.builder(
              itemCount: certificateRepository.list.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(certificateRepository!.list[index].name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  onDismissed: (direction) {
                    certificateRepository!
                        .delete(certificateRepository.list[index].id!);
                  },
                  child: ListTile(
                    title: Text(certificateRepository.list[index].name),
                    subtitle:
                        Text(certificateRepository.list[index].organization),
                    trailing: Text(
                      certificateRepository.list[index].omissionDate != null
                          ? DateFormat.yMMMd().format(
                              certificateRepository.list[index].omissionDate!)
                          : 'Sem Data',
                    ),
                    onTap: () => {
                      _showAddCertificateDialog(context,
                          certificate: certificateRepository!.list[index])
                    },
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: certificates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(certificates[index].name),
                  subtitle: Text(certificates[index].organization),
                  trailing: Text(
                    certificates[index].omissionDate != null
                        ? DateFormat.yMMMd()
                            .format(certificates[index].omissionDate!)
                        : 'Sem Data',
                  ),
                );
              },
            ),
      floatingActionButton: certificateRepository != null
          ? FloatingActionButton(
              onPressed: () => _showAddCertificateDialog(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showAddCertificateDialog(BuildContext context,
      {CertificateModel? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupCertificate(certificate: certificate);
      },
    );
  }
}
