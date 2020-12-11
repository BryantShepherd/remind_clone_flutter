import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/ui/login/login.dart';
import 'package:remind_clone_flutter/ui/user/widgets/account.dart';

class UserSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);

    final List<Map<String, dynamic>> _list = [
      {
        "title": "Your Account",
        "icon": Icons.account_circle,
        "function": () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => UserInfo())
          );
        },
      },
      {
        "title": "Notifications",
        "icon": Icons.notifications,
        "function": null,
      },
      {
        "title": "Family members",
        "icon": Icons.add,
        "function": null,
      },
      {
        "title": "Organizations",
        "icon": Icons.home,
        "function": null,
      },
      {
        "title": "App integrations",
        "icon": Icons.flash_on,
        "function": null,
      },
      {
        "title": "Data and privacy",
        "icon": Icons.privacy_tip,
        "function": null,
      },
      {
        "title": "Help",
        "icon": Icons.help,
        "function": null,
      },
      {
        "title": "Log out",
        "icon": Icons.logout,
        "function": () async {
          {
            Navigator.pushNamedAndRemoveUntil(
                context, "/", (route) => false);
            await userStore.resetUser();
            classroomStore.resetClassrooms();
          }
        },
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < _list.length; i++)
            ListTile(
                leading: Icon(_list[i]["icon"], size: 30.0,),
                title: Text(_list[i]["title"]),
                onTap: _list[i]["function"],
            ),
        ],
      ),
    );
  }
}
