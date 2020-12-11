import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';

import '../rest_client.dart';
import 'package:remind_clone_flutter/models/user/user.dart';
import '../endpoints.dart';

class UserApi {
  final RestClient _client;

  UserApi(this._client);

  Future<Map<String, dynamic>> getProfle(String token) async {
    try {
      final res = await _client.getWithBearerToken(Endpoints.getProfile, token);
      final user = User.fromJson(res["data"]);
      return {"user": user};
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final reqBody = {"email": email, "password": password};
      final res = await this._client.post(Endpoints.loginAPI, body: reqBody);
      final newUser = User.fromJson(res["data"]["user"]);
      final newToken = res["data"]["token"] as String;
      return {'user': newUser, "token": newToken};
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Map<String, dynamic>> register(
      String fullname, String email, String password, int roleId) async {
    try {
      final reqBody = <String, dynamic>{
        "name": fullname,
        "email": email,
        "password": password,
        "role_id": roleId
      };

      final res = await this._client.post(Endpoints.registerApi,
          body: jsonEncode(reqBody),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      return res['data'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
