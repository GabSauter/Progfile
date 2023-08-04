import '../models/user_model.dart';

class HomeController {
  Future<String> signOut() async {
    UserModel userModel = UserModel("", "", "");
    return await userModel.signOut();
  }
}
