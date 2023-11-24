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
    return SizedBox(
      width: 150.0,
      height: 150.0,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        radius: 70.0,
        child: widget.image != null
            ? ClipOval(
                child: Image(
                  image: FileImage(widget.image!),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              )
            : const Icon(
                Icons.camera_alt,
                size: 32,
              ),
      ),
    );
  }
}
