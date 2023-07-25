import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  final String text;
  const FormText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF482FF7),
            fontSize: 16),
      ),
    );
  }
}
