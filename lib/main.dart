import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:remind_clone_flutter/data/network/socket_service.dart';
import 'package:remind_clone_flutter/routes.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/utils/app_initializer.dart';

import 'utils/dependency_injection.dart';

Injector injector;
void main() async {
  DependencyInjection().initialise(Injector());
  injector = Injector();
  await AppInitializer().initialise(injector);
  injector.get<SocketService>().createMessageSocketConnection();

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
