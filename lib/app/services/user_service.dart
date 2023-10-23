import 'package:firebase_auth/firebase_auth.dart';
import 'package:progfile/app/models/user_model.dart';

class UserService {
  final _db = FirebaseAuth.instance;

  Future<void> signIn(UserModel user) async {
    await _db.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<void> signUp(UserModel user) async {
    await _db.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<void> editAccount(UserModel user) async {
    if (_db.currentUser != null) {
      await _db.currentUser?.updateEmail(user.email);
      await _db.currentUser?.updatePassword(user.password);
    }
  }

  Future<void> signOut() async {
    await _db.signOut();
  }
}
