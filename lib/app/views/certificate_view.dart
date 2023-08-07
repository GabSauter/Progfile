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
        onPressed: () => _showAddCertificateDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCertificateDialog({CertificateModel? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        _certificateController.nameController =
            TextEditingController(text: certificate?.name ?? '');
        _certificateController.organizationController =
            TextEditingController(text: certificate?.organization ?? '');
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
                controller: _certificateController.nameController,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Organização Emissora'),
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
                if (_certificateController.nameController.text.isNotEmpty &&
                    _certificateController
                        .organizationController.text.isNotEmpty &&
                    omissionDate != null) {
                  if (certificate != null) {
                    _certificateController.editCertificate(
                        certificate,
                        _certificateController.nameController.text,
                        _certificateController.organizationController.text,
                        omissionDate);
                    setState(() {});
                  } else {
                    _certificateController.addCertificate(CertificateModel(
                      name: _certificateController.nameController.text,
                      organization:
                          _certificateController.organizationController.text,
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
