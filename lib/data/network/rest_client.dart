import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import './network_exceptions.dart';

class RestClient {
  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String url, {Map<String, String> headers}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw AuthException(
              message: "Authorization Error", statusCode: statusCode);
        }
        throw NetworkException(
            message: "Error fetching data from server", statusCode: statusCode);
      }

      print(res);
      return _decoder.convert(res);
    });
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String url,
      {Map<String, String> headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        if (statusCode == 401) {
          throw AuthException(
              message: "Authorization Error", statusCode: statusCode);
        }
        throw NetworkException(
            message: "Error fetching data from server", statusCode: statusCode);
      }
      print(res);
      return _decoder.convert(res);
    });
  }

  Future<dynamic> getWithBearerToken(String url, String token) {
    return this.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
  }

  Future<dynamic> postWithBearerToken(String url, String token, Map<String, String> body) {
    return post(
      url,
      headers: {"Authorization": "Bearer $token"},
      body: body,
    );
  }
}
