import 'package:flutter/material.dart';

class FormPasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const FormPasswordTextField(
      {Key? key, required this.textEditingController, required this.validator})
      : super(key: key);

  @override
  State<FormPasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<FormPasswordTextField> {
  bool _obscureText = true;
  String? errorText;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: (value) {
          final errorMessage = widget.validator?.call(value);
          setState(() {
            errorText = errorMessage;
          });
          return errorMessage;
        },
        controller: widget.textEditingController,
        cursorColor: const Color(0xFF482FF7),
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
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggle,
              child: Icon(
                _obscureText
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 24,
                color: const Color(0xFF482FF7),
              ),
            ),
          ),
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
        obscureText: _obscureText,
      ),
    );
  }
}
