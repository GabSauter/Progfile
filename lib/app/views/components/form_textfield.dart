import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const FormTextField(
      {Key? key, required this.textEditingController, required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
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
        ),
        //obscureText: isPassword,
      ),
    );
  }
}
