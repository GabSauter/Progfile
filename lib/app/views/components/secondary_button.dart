import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  const SecondaryButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: const Color(0xFF482FF7),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF482FF7)),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            onPressed: () {},
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
  }
}
