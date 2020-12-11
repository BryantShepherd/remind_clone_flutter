import 'dart:convert';

import 'package:remind_clone_flutter/models/classroom.dart';

import '../rest_client.dart';
import '../endpoints.dart';
import '../network_exceptions.dart';

class ClassroomApi {
  final RestClient _client;

  ClassroomApi(this._client);

  Future<List<dynamic>> getUserClassrooms(String token) async {
    try {
      var res = await this
          ._client
          .getWithBearerToken(Endpoints.getUserClassroomsAPI, token);

      return res["data"] as List<dynamic>;
    } on AuthException catch (e) {
      print(e);
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<dynamic>> getClassroomFiles(
    String token,
    String classroomId,
  ) async {
    try {
      var requestUrl = Endpoints.baseUrl + "/file/$classroomId";
      var res = await this._client.getWithBearerToken(requestUrl, token);

      return res["data"] as List<dynamic>;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<dynamic>> getConversations(
    String token,
    String classroomId,
  ) async {
    try {
      var requestUrl =
          Endpoints.baseUrl + "/user/conversations?classroomId=$classroomId";
      var res = await this._client.getWithBearerToken(requestUrl, token);

      return res["data"] as List<dynamic>;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<dynamic>> getMessages(String token, String conversationId) async {
    try {
      var requestUrl = Endpoints.baseUrl + "/message/$conversationId";
      var res = await this._client.getWithBearerToken(requestUrl, token);

      return res["data"] as List<dynamic>;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> joinClassroom(String token, String code) async {
    try {
      var requestUrl = Endpoints.joinClassroomAPI;
      await _client.postWithBearerToken("$requestUrl/$code", token, null);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> createClassroom(String token, String name, String school) async {
    try {
      final requestBody = {"name": name, "school": school};
      var requestUrl = Endpoints.createClassroomAPI;
      await _client.postWithBearerToken(requestUrl, token, requestBody);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<dynamic>> getClassroomMembers(
    String token,
    String classroomId,
  ) async {
    try {
      var requestUrl = Endpoints.baseUrl + "/classroom/$classroomId/members";
      var res = await _client.getWithBearerToken(requestUrl, token);

      return res['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<Classroom> editClassroom(String token, Classroom classroom) async {
    try {
      var reqUrl = Endpoints.baseUrl + "/classroom/${classroom.id}";
      var res = await _client
          .post(reqUrl, body: jsonEncode((classroom.toJson())), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json; charset=UTF-8",
      });
      var newClassroom = Classroom.fromJson(res["data"]);
      return newClassroom;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
