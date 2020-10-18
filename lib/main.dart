import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/routes.dart';

void main() {
  runApp(RemindClone());
}

class RemindClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Remind Clone",
      home: Center(
        child: Text("Hello World"),
      ),
      routes: Routes.routes,
    );
  }
}
