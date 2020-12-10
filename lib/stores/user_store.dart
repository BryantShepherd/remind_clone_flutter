import "package:flutter/foundation.dart";
import 'package:shared_preferences/shared_preferences.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var res = await _userApi.login(email, password);
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

  Future<bool> autoLogin() async {
    UserApi userApi = new UserApi(_client);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    if (token != null && token.isNotEmpty) {
      try {
        var res = await userApi.getProfle(token);
        this.setUser(res["user"] as User);
        return getToken() != null;
      } catch (e) {
        print(e.toString());
        throw e;
      }
    }
    return null;
  }

  Future<void> register(
      String fullname, String email, String password, int roleId) async {
    try {
      await _userApi.register(fullname, email, password, roleId);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
