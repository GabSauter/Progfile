import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatefulWidget {
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
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        final errorMessage = widget.validator?.call(value);
        setState(() {
          errorText = errorMessage;
        });
        return errorMessage;
      },
      controller: widget.textEditingController,
      cursorColor: Theme.of(context).primaryColor,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines ?? 1,
      decoration: InputDecoration(
        labelText: widget.labelText,
        counterText: '',
        floatingLabelAlignment: widget.isDialog
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.red, // Cor do erro
          fontSize: 14.0, // Tamanho da fonte do erro
          // Outros estilos de texto do erro, como fontWeight, fontStyle, etc.
        ),
        errorText: errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      keyboardType:
          (widget.isNumeric) ? TextInputType.number : TextInputType.text,
      inputFormatters: [
        if (widget.isNumeric) FilteringTextInputFormatter.digitsOnly,
      ],
      maxLength: (widget.length == 0) ? null : widget.length,
    );
  }
}
