import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class MaskedTextField extends StatelessWidget {
  final MaskedTextController controller;
  final String? Function(dynamic value) validator;

  const MaskedTextField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
      ),
    );
  }
}
