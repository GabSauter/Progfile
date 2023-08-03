import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String _name;
  final String _email;
  final String _password;

  UserModel(this._name, this._email, this._password);

  Future<String> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return "Logado";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return "Registrado";
    } catch (error) {
      return error.toString();
    }
  }

  String get name => _name;
}
