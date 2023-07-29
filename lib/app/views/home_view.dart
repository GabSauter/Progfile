import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/main_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainButton(
            text: 'Logout',
            route: '/',
            onPressedCallback: () => logout(context),
          )
        ],
      ),
    );
  }

  logout(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushNamed(context, '/');
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
    });
  }
}
