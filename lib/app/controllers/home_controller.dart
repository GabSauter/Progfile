import 'package:progfile/app/services/user_service.dart';

class HomeController {
  Future<void> signOut() async {
    await UserService().signOut();
  }
}
