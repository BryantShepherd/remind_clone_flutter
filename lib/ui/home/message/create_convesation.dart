import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

class IndividualConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Individual Message"),
      ),
      body: FutureBuilder(
        future: classroomStore.fetchClassroomMembers(
            userStore.getToken(), classroomStore.getCurrentClassroom()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var member in snapshot.data)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.avatarUrl),
                    ),
                    title: Text(member.name),
                    onTap: () {},
                  )
              ],
            );
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(
              child: Text("Fetch Failed"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class GroupConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Group Conversation"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () async {},
            child: Text("Create"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: FutureBuilder(
        future: classroomStore.fetchClassroomMembers(
            userStore.getToken(), classroomStore.getCurrentClassroom()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var member in snapshot.data)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.avatarUrl),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${member.name}"),
                        Checkbox(value: true, onChanged:(bool) {bool = !bool;})
                      ],
                    ),
                  ),
              ],
            );
          } else if (snapshot.hasError) {
            print("${snapshot.error}");
            return Center(
              child: Text("Fetch Failed"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
