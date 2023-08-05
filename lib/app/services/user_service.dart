import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/user_model.dart';

class UserService {
  final _db = FirebaseAuth.instance;

  Future<String> signIn(UserModel user) async {
    try {
      await _db.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return "Logado";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signUp(UserModel user) async {
    try {
      await _db.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return "Registrado";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signOut() async {
    try {
      await _db.signOut();
      return "Logout";
    } catch (error) {
      return error.toString();
    }
  }
}
