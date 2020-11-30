import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/routes.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

void main() {
  runApp(RemindClone());
}

class RemindClone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: MaterialApp(
        title: "Remind Clone",
        initialRoute: "/login",
        routes: Routes.routes,
      ),
    );
  }
}
