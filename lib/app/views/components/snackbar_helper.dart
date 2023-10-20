import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String errorMessage, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccessSnackBar(String successMessage, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            successMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
