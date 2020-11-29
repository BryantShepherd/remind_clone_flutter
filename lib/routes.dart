import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/ui/home/home.dart';
import 'package:remind_clone_flutter/ui/login/login.dart';

class Routes {
  Routes._();
  static const String home = '/home';
  static const String login = '/login';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    login: (BuildContext context) => LoginScreen(),
  };
}
