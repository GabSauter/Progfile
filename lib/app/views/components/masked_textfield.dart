import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class MaskedTextField extends StatefulWidget {
  final MaskedTextController controller;
  final String? Function(dynamic value) validator;

  const MaskedTextField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  State<MaskedTextField> createState() => _MaskedTextFieldState();
}

class _MaskedTextFieldState extends State<MaskedTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        final errorMessage = widget.validator.call(value);
        setState(() {
          errorText = errorMessage;
        });
        return errorMessage;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
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
    );
  }
}
