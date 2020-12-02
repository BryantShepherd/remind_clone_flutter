import '../rest_client.dart';
import 'package:remind_clone_flutter/models/classroom.dart';
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
}
