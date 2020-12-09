import "package:flutter/foundation.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "../models/user/user.dart";
import "package:remind_clone_flutter/data/network/api/user_api.dart";
import "package:remind_clone_flutter/data/network/rest_client.dart";

class UserStore with ChangeNotifier {
  String token;
  User user;

  var _client = new RestClient();

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserApi userApi = new UserApi(_client);
    try {
      var res = await userApi.login(email, password);
      this.setToken(res["token"] as String);
      this.setUser(res["user"] as User);
      prefs.setString("token", res["token"] as String);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> resetUser() async {
    user = null;
    token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  Future<User> autoLogin() async {
    UserApi userApi = new UserApi(_client);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    if (token.isNotEmpty) {
      try {
        var res = await userApi.getProfle(token);
        this.setUser(res["user"] as User);
        print(getUser().toJson());
        return getUser();
      } catch (e) {
        print(e.toString());
        throw e;
      }
    }
  }
}
