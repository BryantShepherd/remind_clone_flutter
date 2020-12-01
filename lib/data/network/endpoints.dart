class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://localhost:3000/api";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // booking endpoints
  static const String loginAPI = baseUrl + "/user/auth/login";
}