import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final String? route;
  final Color? buttonColor;
  final VoidCallback? onPressedCallback;
  final Object? arguments;

  const SecondaryButton({
    super.key,
    required this.text,
    this.route,
    this.buttonColor,
    this.onPressedCallback,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: buttonColor ?? Theme.of(context).primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 129, 110, 255),
                ),
              ),
            ),
            onPressed: () {
              if (onPressedCallback != null) {
                onPressedCallback!();
              } else if (route != null) {
                Navigator.of(context).pushNamed(route!, arguments: arguments);
              }
            },
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )));
  }
}
