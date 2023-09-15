import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final String labelText;
  final bool isDialog;
  final TextAlign textAlign;
  final int? maxLines;
  final bool isNumeric;
  final int length;

  const FormTextField({
    Key? key,
    required this.textEditingController,
    required this.validator,
    this.labelText = '',
    this.isDialog = false,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.isNumeric = false,
    this.length = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        cursorColor: Theme.of(context).primaryColor,
        textAlign: textAlign,
        maxLines: maxLines ?? 1,
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
        keyboardType: (isNumeric) ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          if (isNumeric) FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: (length == 0) ? null : length,
      ),
    );
  }
}
