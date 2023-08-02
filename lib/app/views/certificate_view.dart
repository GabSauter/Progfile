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
  _CertificateListScreenState createState() => _CertificateListScreenState();
}

class _CertificateListScreenState extends State<CertificateListScreen> {
  final List<Certificate> _certificates = [];

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
            key: Key(_certificates[index].nome),
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
              title: Text(_certificates[index].nome),
              subtitle: Text(_certificates[index].organizacao),
              trailing: Text(
                  DateFormat.yMMMd().format(_certificates[index].dataEmissao)),
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

  void _showAddCertificateDialog({Certificate? certificate}) {
    showDialog(
      context: context,
      builder: (context) {
        String nome = certificate?.nome ?? '';
        String organizacao = certificate?.organizacao ?? '';
        DateTime? dataEmissao = certificate?.dataEmissao;

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
                onChanged: (value) => nome = value,
                controller: TextEditingController(text: nome),
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Organização Emissora'),
                onChanged: (value) => organizacao = value,
                controller: TextEditingController(text: organizacao),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime currentDate = DateTime.now();
                  DateTime initialDate = dataEmissao ?? currentDate;
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(1900),
                    lastDate: currentDate,
                    initialDatePickerMode: DatePickerMode.year,
                  );

                  if (selectedDate != null) {
                    setState(() {
                      dataEmissao = DateTime(selectedDate.year,
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
                if (nome.isNotEmpty &&
                    organizacao.isNotEmpty &&
                    dataEmissao != null) {
                  if (certificate != null) {
                    // Editing an existing certificate
                    setState(() {
                      certificate.nome = nome;
                      certificate.organizacao = organizacao;
                      certificate.dataEmissao = dataEmissao!;
                    });
                  } else {
                    // Adding a new certificate
                    setState(() {
                      _certificates.add(Certificate(
                        nome: nome,
                        organizacao: organizacao,
                        dataEmissao: dataEmissao!,
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
