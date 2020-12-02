import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/routes.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStore()),
        ChangeNotifierProvider(create: (context) => ClassroomStore()),
      ],
      child: RemindClone(),
    ),
  );
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
