import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String labelText;
  final bool isDialog;
  final TextAlign textAlign;

  const FormTextField(
      {Key? key,
      required this.textEditingController,
      required this.validator,
      this.labelText = '',
      this.isDialog = false,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        cursorColor: const Color(0xFF482FF7),
        textAlign: textAlign,
        decoration: InputDecoration(
          labelText: labelText,
          counterText: '',
          floatingLabelAlignment: isDialog
              ? FloatingLabelAlignment.center
              : FloatingLabelAlignment.start,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Color(0xFF482FF7)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFF482FF7)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.transparent,
        ),
        keyboardType: (labelText == 'Início' || labelText == 'Término')
            ? TextInputType.number
            : TextInputType.text,
        inputFormatters: [
          if (labelText == 'Início' || labelText == 'Término')
            FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: (labelText == 'Início' || labelText == 'Término') ? 4 : null,
      ),
    );
  }
}
