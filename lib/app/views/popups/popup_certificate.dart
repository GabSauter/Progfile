import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:provider/provider.dart';

import '../../controllers/certificate_controller.dart';
import '../../models/certificate_model.dart';
import '../../repositories/certificate_repository.dart';

class PopupCertificate extends StatefulWidget {
  final CertificateModel? certificate;
  final Function? onPopupClose;

  const PopupCertificate({
    super.key,
    required this.certificate,
    this.onPopupClose,
  });

  @override
  State<PopupCertificate> createState() => _PopupCertificateState();
}

class _PopupCertificateState extends State<PopupCertificate> {
  final _certificateController = CertificateController();
  late CertificateRepository listCertificates;

  @override
  void initState() {
    super.initState();

    _certificateController.nameController.text = widget.certificate?.name ?? '';
    _certificateController.organizationController.text =
        widget.certificate?.organization ?? '';
    _certificateController.omissionDate = widget.certificate?.omissionDate;
  }

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    listCertificates = context.watch<CertificateRepository>();

    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.symmetric(vertical: 20),
      title: Center(
        child: Text(widget.certificate != null
            ? 'Editar Certificado'
            : 'Adicionar Certificado'),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      content: content(context),
      actionsPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
        vertical: 20,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: MainButton(
                text: 'Cancelar',
                onPressedCallback: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_certificateController.formKey.currentState!.validate()) {
                    if (widget.certificate != null) {
                      listCertificates.edit(
                          _certificateController
                              .editCertificate(widget.certificate!));
                    } else {
                      listCertificates
                          .create(_certificateController.generateCertificate());
                    }

                    _onDialogClose();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget content(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Form(
        key: _certificateController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormTextField(
              labelText: 'Nome do Certificado',
              textEditingController: _certificateController.nameController,
              isDialog: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe o nome do certificado';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            FormTextField(
              labelText: 'Organização Emissora',
              textEditingController:
                  _certificateController.organizationController,
              isDialog: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a organização emissora';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SecondaryButton(
              onPressedCallback: () async {
                DateTime currentDate = DateTime.now();
                DateTime initialDate =
                    _certificateController.omissionDate ?? currentDate;
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: currentDate,
                  initialDatePickerMode: DatePickerMode.year,
                );

                if (selectedDate != null) {
                  _certificateController.omissionDate = DateTime(
                      selectedDate.year, selectedDate.month, selectedDate.day);
                }
              },
              text: _certificateController.omissionDate != null
                  ? getOmisionDate()
                  : 'Data de Emissão',
            ),
          ],
        ),
      ),
    );
  }

  String getOmisionDate() {
    DateTime date = _certificateController.omissionDate!;
    return '${date.day}/${date.month}/${date.year}';
  }
}
