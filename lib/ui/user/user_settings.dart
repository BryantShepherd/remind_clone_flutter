import 'package:flutter/material.dart';

class UserSettings extends StatelessWidget {
  final List<Map<String, dynamic>> _list = [
    {
      "title": "Your Account",
      "icon": Icons.account_circle,
      "widget": null,
    },
    {
      "title": "Notifications",
      "icon": Icons.notifications,
      "widget": null,
    },
    {
      "title": "Family members",
      "icon": Icons.add,
      "widget": null,
    },
    {
      "title": "Organizations",
      "icon": Icons.home,
      "widget": null,
    },
    {
      "title": "App integrations",
      "icon": Icons.flash_on,
      "widget": null,
    },
    {
      "title": "Data and privacy",
      "icon": Icons.privacy_tip,
      "widget": null,
    },
    {
      "title": "Help",
      "icon": Icons.help,
      "widget": null,
    },
    {
      "title": "Log out",
      "icon": Icons.logout,
      "widget": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => _list[i]["widget"])
                );
              },
            ),
        ],
      ),
    );
  }
}
