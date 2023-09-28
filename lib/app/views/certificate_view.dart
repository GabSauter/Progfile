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
    final certificates = context.watch<CertificateRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificados'),
      ),
      body: ListView.builder(
        itemCount: certificates.list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(certificates.list[index].name),
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
              certificates.delete(certificates.list[index].id);
            },
            child: ListTile(
              title: Text(certificates.list[index].name),
              subtitle: Text(certificates.list[index].organization),
              trailing: Text(
                certificates.list[index].omissionDate != null
                    ? DateFormat.yMMMd()
                        .format(certificates.list[index].omissionDate!)
                    : 'No date',
              ),
              onTap: () => _showAddCertificateDialog(context,
                  certificate: certificates.list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCertificateDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCertificateDialog(BuildContext context,
      {CertificateModel? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupCertificate(certificate: certificate, onPopupClose: () {});
      },
    );
  }
}
