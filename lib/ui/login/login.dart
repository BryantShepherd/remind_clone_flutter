import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/data/network/socket_service.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/routes.dart';
import 'package:socket_io_client/socket_io_client.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    this._emailController.dispose();
    this._passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
              ],
            ),
            SizedBox(height: 120.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                  },
                ),
                ElevatedButton(
                  child: Text('NEXT'),
                  onPressed: () async {
                    try {
                      String email = this._emailController.text;
                      String password = this._passwordController.text;
                      await userStore.login(email, password);
                      await classroomStore
                          .fetchUserClassrooms(userStore.getToken());
                      classroomStore.setCurrentClassroom(
                          classroomStore.classrooms.first.id);
                      final SocketService socketService =
                          Injector().get<SocketService>();
                      socketService.createSocketConnection();
                      Navigator.pushNamed(
                        context,
                        Routes.home,
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
