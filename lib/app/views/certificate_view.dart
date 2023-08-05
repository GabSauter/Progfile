import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/certificate_controller.dart';
import '../models/certificate_model.dart';

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
      body: ListView.builder(
        itemCount: _certificateController.getCertificatesCount(),
        itemBuilder: (context, index) {
          CertificateModel certificate =
              _certificateController.getCertificate(index);
          return Dismissible(
            key: Key(certificate.name),
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
              _certificateController.removeCertificate(index);
            },
            child: ListTile(
              title: Text(certificate.name),
              subtitle: Text(certificate.organization),
              trailing: Text(
                certificate.omissionDate != null
                    ? DateFormat.yMMMd().format(certificate.omissionDate!)
                    : 'No date',
              ),
              onTap: () => _showAddCertificateDialog(certificate: certificate),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCertificateDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCertificateDialog({CertificateModel? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        String name = certificate?.name ?? '';
        String organization = certificate?.organization ?? '';
        DateTime? omissionDate = certificate?.omissionDate;

        return AlertDialog(
          title: Text(certificate != null
              ? 'Editar Certificado'
              : 'Adicionar Certificado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Nome do Certificado'),
                onChanged: (value) => name = value,
                controller: _certificateController.nameController,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Organização Emissora'),
                onChanged: (value) => organization = value,
                controller: _certificateController.organizationController,
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime currentDate = DateTime.now();
                  DateTime initialDate = omissionDate ?? currentDate;
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: currentDate,
                    initialDatePickerMode: DatePickerMode.year,
                  );

                  if (selectedDate != null) {
                    omissionDate = DateTime(selectedDate.year,
                        selectedDate.month, selectedDate.day);
                  }
                },
                child: const Text('Selecione o Mês e Ano de Emissão'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty &&
                    organization.isNotEmpty &&
                    omissionDate != null) {
                  if (certificate != null) {
                    // Editing an existing certificate
                    _certificateController.editCertificate(
                        certificate, name, organization, omissionDate);
                    setState(() {});
                  } else {
                    // Adding a new certificate
                    _certificateController.addCertificate(CertificateModel(
                      name: name,
                      organization: organization,
                      omissionDate: omissionDate,
                    ));
                    setState(() {});
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(certificate != null ? 'Salvar Edição' : 'Salvar'),
            ),
          ],
        );
      },
    );
  }
}
