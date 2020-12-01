import "package:flutter/foundation.dart";
import "../models/user/user.dart";
import "package:remind_clone_flutter/data/network/api/user_api.dart";
import "package:remind_clone_flutter/data/network/rest_client.dart";

class UserStore with ChangeNotifier {
  String token;
  User user;

  void setUser(User user) {
    this.user = user;
  }

  void setToken(String token) {
    this.token = token;
  }

  User getUser() {
    return this.user;
  }

  Future<void> login(String email, String password) async {
    RestClient client = new RestClient();
    UserApi userApi = new UserApi(client);
    try {
      var res = await userApi.login(email, password);
      this.setToken(res["token"] as String);
      this.setUser(res["user"] as User);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
