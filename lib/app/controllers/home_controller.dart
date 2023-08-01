import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeController {
  logout(BuildContext context,
      void Function(String, BuildContext) onErrorCallback) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushNamed(context, '/');
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
      onErrorCallback(error.toString(), context);
    });
  }
}
