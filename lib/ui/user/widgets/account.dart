import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/models/classroom.dart';
import 'package:remind_clone_flutter/models/user/user.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/ui/people/people_user_info.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    final classroomStore = Provider.of<ClassroomStore>(context);

    var member = userStore.getUser();
    var ownedClassrooms = classroomStore.getOwnedClassrooms();
    var joinedClassrooms = classroomStore.getJoinedClassrooms();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Account"),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 2.25),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(member.avatarUrl),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              member.name,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Builder(
              builder: (context) => GestureDetector(
                child: Text(
                  member.email,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: member.email,
                    ),
                  );
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Email Copied",
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(
                        seconds: 1,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Notifications",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Email'),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Classes Owned",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            for (var classroom in ownedClassrooms)
              ListTile(
                leading: Icon(Icons.room),
                title: Text(classroom.name),
              ),
            Text(
              "Classes Joined",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            for (var classroom in joinedClassrooms)
              ListTile(
                leading: Icon(Icons.room),
                title: Text(classroom.name),
              ),
          ],
        ),
      ),
    );
  }
}
