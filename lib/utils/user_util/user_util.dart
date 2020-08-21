import 'package:nongple/models/models.dart';
import 'package:nongple/models/user_model/user_model.dart';

class UserUtil {
  static User _user;
  static void setUser(User user) async {
    _user = user;
  }

  static User getUser() {
    return _user;
  }
}
