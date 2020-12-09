import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/data/network/api/classroom_api.dart';
import 'package:remind_clone_flutter/data/network/rest_client.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

class ClassCreate extends StatelessWidget {
  final RestorableBool _switch = RestorableBool(false);

  final _client = RestClient();

  final _nameController = TextEditingController();
  final _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final classroomStore = Provider.of<ClassroomStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create a class"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {
              try {
                String name = _nameController.text;
                String school = _schoolController.text;
                if(name.isNotEmpty) {
                  var classroomApi = ClassroomApi(_client);
                  await classroomApi.createClassroom(
                      userStore.getToken(), name, school);
                }
              } catch (e) {
                print(e.toString());
              }
              await classroomStore.fetchUserClassrooms(userStore.getToken());
              classroomStore.setCurrentClassroom(classroomStore.classrooms.first.id);
              Navigator.pop(context);
            },
            child: Text("Create"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          Text(
            "Class name",
            style: Theme.of(context).textTheme.headline6.copyWith(
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
                hintText: 'Enter your class name'),
            onChanged: (text) {},
            controller: _nameController,
          ),
          // SwitchListTile(
          //   title: Text(
          //       "I will only message people 13 and older"
          //   ),
          //   value: true,
          //   onChanged: (bool) {},
          // ),
          Padding(padding: const EdgeInsets.all(5.0)),
          Text(
            "School name",
            style: Theme.of(context).textTheme.headline6.copyWith(
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
                hintText: 'Enter your school name'),
            onChanged: (text) {},
            controller: _schoolController,
          ),
        ],
      ),
    );
  }
}
