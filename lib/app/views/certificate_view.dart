import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/certificate_controller.dart';
import '../models/certificate_model.dart';
import 'popups/popup_certificate.dart';

class CertificateView extends StatefulWidget {
  const CertificateView({super.key});

  @override
  State<CertificateView> createState() => _CertificateView();
}

class _CertificateView extends State<CertificateView> {
  final _certificateController = CertificateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificados'),
      ),
      body: FutureBuilder(
        future: _certificateController.getCertificates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data![index].name),
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
                      _certificateController
                          .removeCertificate(snapshot.data![index].id);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].organization),
                      trailing: Text(
                        snapshot.data![index].omissionDate != null
                            ? DateFormat.yMMMd()
                                .format(snapshot.data![index].omissionDate!)
                            : 'No date',
                      ),
                      onTap: () => _showAddCertificateDialog(
                          certificate: snapshot.data![index]),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(child: Text("Algo deu errado."));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_showAddCertificateDialog()},
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCertificateDialog({CertificateModel? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupCertificate(
            certificate: certificate,
            onPopupClose: () {
              _certificateController.getCertificates();
              setState(() {});
            });
      },
    );
  }
}
