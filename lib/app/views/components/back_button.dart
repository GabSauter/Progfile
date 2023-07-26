import 'package:flutter/material.dart';

class BackCustomButton extends StatelessWidget {
  const BackCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, right: 0, left: 15, bottom: 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: CircleAvatar(
          backgroundColor: const Color(0xFF482FF7),
          radius: 18,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }
}
