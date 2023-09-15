import 'package:flutter/material.dart';

class BackCustomButton extends StatelessWidget {
  const BackCustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).primaryColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}
