class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:3000/api";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  static const String loginAPI = baseUrl + "/user/auth/login";

  static const String getUserClassroomsAPI = baseUrl + "/classroom/my-class";
}
