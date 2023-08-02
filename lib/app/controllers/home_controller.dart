import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController {
  logout(BuildContext context,
      void Function(String, BuildContext) onErrorCallback) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }).onError((error, stackTrace) {
      onErrorCallback(error.toString(), context);
    });
  }
}
