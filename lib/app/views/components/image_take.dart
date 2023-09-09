import 'dart:io';

import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final File? image;

  const ImageDisplay({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      radius: 70.0,
      backgroundImage: widget.image != null ? FileImage(widget.image!) : null,
      child: widget.image == null
          ? const Icon(
              Icons.camera_alt,
              size: 32,
            )
          : null,
    );
  }
}
