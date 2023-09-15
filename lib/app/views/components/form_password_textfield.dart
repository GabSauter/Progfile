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

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: widget.validator,
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
        ),
        obscureText: _obscureText,
      ),
    );
  }
}
