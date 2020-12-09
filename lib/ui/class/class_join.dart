import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/data/network/api/classroom_api.dart';
import 'package:remind_clone_flutter/data/network/rest_client.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

class ClassJoin extends StatelessWidget {

  final _client = RestClient();

  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final classroomStore = Provider.of<ClassroomStore>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Join a class"),
          actions: [
            FlatButton(
              textColor: Colors.white,
              onPressed: () async{
                try {
                  String code = _codeController.text;
                  print(code);
                  if(code.isNotEmpty) {
                    var classroomApi = ClassroomApi(_client);
                    await classroomApi.joinClassroom(
                        userStore.getToken(), code);
                  }
                } catch (e) {
                  print(e.toString());
                }
                await classroomStore.fetchUserClassrooms(userStore.getToken());
                classroomStore.setCurrentClassroom(classroomStore.classrooms.first.id);
                Navigator.pop(context);
              },
              child: Text("Join"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: <Widget>[
            Text(
              "Class code",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6
                  .copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                hintText: "Enter class code",
              ),
              onChanged: (text) {},
              controller: _codeController,
            ),
          ],
        ),
    );
  }
}
