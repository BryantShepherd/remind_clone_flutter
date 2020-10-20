import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/routes.dart';
import 'package:remind_clone_flutter/ui/home/home.dart';

void main() {
  runApp(RemindClone());
}

class RemindClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Remind Clone",
      initialRoute: "/login",
      routes: Routes.routes,
    );
  }
}
