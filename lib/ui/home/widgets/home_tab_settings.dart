import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/data/network/api/classroom_api.dart';
import 'package:remind_clone_flutter/data/network/rest_client.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/ui/people/people_user_info.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final classroomStore = Provider.of<ClassroomStore>(context);
    final userStore = Provider.of<UserStore>(context);


    _nameController.text = classroomStore.getCurrentClassroom()?.name;
    _codeController.text = classroomStore.getCurrentClassroom()?.code;
    _schoolController.text = classroomStore.getCurrentClassroom()?.school;

    final _client = RestClient();
    final _classroomApi = ClassroomApi(_client);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Icon(
            Icons.account_circle,
            size: 100,
          ),
        ),
        Text(
          "Class name",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              hintText: 'Class name'),
          onChanged: (text) {},
          controller: _nameController,
          onSubmitted: (string) async {
            var currentClassroom = classroomStore.getCurrentClassroom();
            currentClassroom.name = string;
            await _classroomApi.editClassroom(userStore.getToken(), currentClassroom);
            classroomStore.setCurrentClassroom(currentClassroom.id);
          },
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        Text(
          "Class code",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              hintText: 'Class code'),
          onChanged: (text) {},
          controller: _codeController,
          enabled: false,
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        Text(
          "School name",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
        ),
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              hintText: 'School name'),
          onChanged: (text) {},
          controller: _schoolController,
          onSubmitted: (string) async {
            var currentClassroom = classroomStore.getCurrentClassroom();
            currentClassroom.school = string;
            await _classroomApi.editClassroom(userStore.getToken(), currentClassroom);
            classroomStore.setCurrentClassroom(currentClassroom.id);
          },
        ),
        Padding(padding: const EdgeInsets.all(10.0)),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Required approval to join",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Switch(value: true, onChanged: (bool) => {})
            ],
          ),
          subtitle: Text(
            "Only people you add or approve will be able to join this class",
          ),
          contentPadding: const EdgeInsets.all(0.0),
        ),
        Padding(padding: const EdgeInsets.all(10.0)),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Participant Messaging",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    "Role-based",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  )
                ],
              ),
            ],
          ),
          subtitle: Text(
              "Choose how participants see and message others in the class"),
          contentPadding: const EdgeInsets.all(0.0),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ParticipantMessaging(),
              ),
            );
          },
        ),
        Padding(padding: const EdgeInsets.all(10.0)),
        Text(
          "Class owner",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 20.0,
              ),
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        ClassOwner(),
        Padding(padding: const EdgeInsets.all(5.0)),
        OutlinedButton.icon(
          icon: const Icon(
            Icons.highlight_remove_rounded,
            size: 18,
            color: Colors.red,
          ),
          label: Text("Remove me as class owner",
              style: TextStyle(
                color: Colors.red,
              )),
          onPressed: () {},
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          icon: const Icon(Icons.highlight_remove_rounded, size: 20),
          label: Text("Delete Class"),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ClassOwner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);

    return SizedBox(
      height: 180.0,
      child: FutureBuilder(
        future: classroomStore.fetchClassroomMembers(
            userStore.getToken(), classroomStore.getCurrentClassroom()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              restorationId: 'list_demo_list_view',
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(
                      child: Icon(
                        Icons.add_circle,
                        size: 40.0,
                      ),
                    ),
                  ),
                  title: Text(
                    "Add Owner",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {},
                ),
                for (var member in snapshot.data)
                  if (member.type == "Owner")
                  ListTile(
                    leading: ExcludeSemantics(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(member.avatarUrl),
                      ),
                    ),
                    title: Text("${member.name}"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileUserInfo(member: member),
                        ),
                      );
                    },
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(
              child: Text("Fetch Failed"),
            );;
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ParticipantMessaging extends StatefulWidget {
  @override
  _ParticipantMessagingState createState() => _ParticipantMessagingState();
}

class _ParticipantMessagingState extends State<ParticipantMessaging> {
  String _participantMessaging = "";

  void handleRadioValue(String value) {
    setState(() {
      _participantMessaging = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participant Messaging"),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10.0),
        children: [
          ListTile(
            subtitle: Text(
                "Choose how participants see and message others in the class"),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("On"),
                Radio(
                  onChanged: handleRadioValue,
                  value: "On",
                  groupValue: _participantMessaging,
                ),
              ],
            ),
            subtitle: Text("All participant can message each other."),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Role-based"),
                Radio(
                  onChanged: handleRadioValue,
                  value: "Role-based",
                  groupValue: _participantMessaging,
                ),
              ],
            ),
            subtitle: Text(
                "Students can only message students;\nParents can only message parents."),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Off"),
                Radio(
                  onChanged: handleRadioValue,
                  value: "Off",
                  groupValue: _participantMessaging,
                )
              ],
            ),
            subtitle: Text(
                "Participants can only message class owners and can't see others in the class. Existing conversations won't be affected."),
          ),
        ],
      ),
    );
  }
}
