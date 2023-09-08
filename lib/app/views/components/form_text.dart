import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const FormText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? const Color(0xFF482FF7),
          fontSize: fontSize ?? 16,
        ),
      ),
    );
  }
}
