import "package:flutter/foundation.dart";
import "../models/user/user.dart";
import "package:remind_clone_flutter/data/network/api/user_api.dart";
import "package:remind_clone_flutter/data/network/rest_client.dart";

class UserStore with ChangeNotifier {
  String token;
  User user;
  final _client = new RestClient();
  UserApi _userApi;

  UserStore() {
    _userApi = UserApi(_client);
  }

  void setUser(User user) {
    this.user = user;
  }

  void setToken(String token) {
    this.token = token;
  }

  User getUser() {
    return this.user;
  }

  String getToken() {
    return this.token;
  }

  Future<void> login(String email, String password) async {
    try {
      var res = await _userApi.login(email, password);
      this.setToken(res["token"] as String);
      this.setUser(res["user"] as User);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  void resetUser() {
    user = null;
    token = null;
  }

  Future<void> register(String fullname, String email, String password, int roleId) async {
    try {
      await _userApi.register(fullname, email, password, roleId);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
