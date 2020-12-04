import 'package:flutter/material.dart';

class PeopleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        children: [
          Text(
            "WAYS TO ADD PEOPLE",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.account_circle, size: 35, color: Colors.green,),
            title: Text('Add people'),
          ),
          ListTile(
            leading: Icon(Icons.link, size: 35, color: Colors.orange,),
            title: Text('Share a join link'),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "MEMBERS",
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          for(int i = 0; i < 10; ++i)
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Name'),
            ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}
