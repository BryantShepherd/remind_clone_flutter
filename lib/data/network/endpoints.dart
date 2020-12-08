class Endpoints {
  Endpoints._();

  static const String host = "http://localhost:3000";

  // base url
  static const String baseUrl = "$host/api";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // user routes
  static const String loginAPI = baseUrl + "/user/auth/login";

  static const String getProfile = baseUrl + "/user/profile";

  // classroom routes
  static const String getUserClassroomsAPI = baseUrl + "/classroom/my-class";

  static const String joinClassroomAPI = baseUrl + "/classroom/join";

  static const String createClassroomAPI = baseUrl + "/classroom";

}
