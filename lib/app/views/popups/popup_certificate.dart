import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';

import '../../controllers/certificate_controller.dart';
import '../../models/certificate_model.dart';

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

  void _onDialogClose() {
    Navigator.of(context).pop();
    if (widget.onPopupClose != null) {
      widget.onPopupClose!();
    }
  }

  @override
  Widget build(BuildContext context) {
    _certificateController.nameController =
        TextEditingController(text: widget.certificate?.name ?? '');
    _certificateController.organizationController =
        TextEditingController(text: widget.certificate?.organization ?? '');
    _certificateController.omissionDate = widget.certificate?.omissionDate;

    return AlertDialog(
      title: Center(
        child: Text(widget.certificate != null
            ? 'Editar Certificado'
            : 'Adicionar Certificado'),
      ),
      content: Form(
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                text: 'Cancelar',
                onPressedCallback: () {
                  Navigator.pop(context);
                },
                buttonWidth: 100,
                buttonHeight: 45,
              ),
              MainButton(
                text: 'Salvar',
                onPressedCallback: () {
                  if (_certificateController.formKey.currentState!.validate()) {
                    if (widget.certificate != null) {
                      _certificateController
                          .editCertificate(widget.certificate!);
                    } else {
                      _certificateController.addCertificate();
                    }
                    _onDialogClose();
                  }
                },
                buttonWidth: 100,
                buttonHeight: 45,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getOmisionDate() {
    DateTime date = _certificateController.omissionDate!;
    return '${date.day}/${date.month}/${date.year}';
  }
}
