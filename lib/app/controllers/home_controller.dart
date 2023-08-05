import 'package:progfile/app/services/user_service.dart';

class HomeController {
  Future<String> signOut() async {
    return await UserService().signOut();
  }
}
