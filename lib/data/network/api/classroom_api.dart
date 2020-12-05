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
}
