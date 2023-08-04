import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/certificate_model.dart';

class CertificateView extends StatelessWidget {
  const CertificateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CertificateListScreen(),
    );
  }
}

class CertificateListScreen extends StatefulWidget {
  const CertificateListScreen({super.key});

  @override
  State<CertificateListScreen> createState() => _CertificateListScreenState();
}

class _CertificateListScreenState extends State<CertificateListScreen> {
  final List<CertificateModel> _certificates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificados'),
      ),
      body: ListView.builder(
        itemCount: _certificates.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_certificates[index].name),
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
              setState(() {
                _certificates.removeAt(index);
              });
            },
            child: ListTile(
              title: Text(_certificates[index].name),
              subtitle: Text(_certificates[index].organization),
              trailing: Text(
                  DateFormat.yMMMd().format(_certificates[index].omissionDate)),
              onTap: () =>
                  _showAddCertificateDialog(certificate: _certificates[index]),
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
                controller: TextEditingController(text: name),
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Organização Emissora'),
                onChanged: (value) => organization = value,
                controller: TextEditingController(text: organization),
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
                    setState(() {
                      omissionDate = DateTime(selectedDate.year,
                          selectedDate.month, selectedDate.day);
                    });
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
                    setState(() {
                      certificate.name = name;
                      certificate.organization = organization;
                      certificate.omissionDate = omissionDate!;
                    });
                  } else {
                    // Adding a new certificate
                    setState(() {
                      _certificates.add(CertificateModel(
                        name: name,
                        organization: organization,
                        omissionDate: omissionDate!,
                      ));
                    });
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
