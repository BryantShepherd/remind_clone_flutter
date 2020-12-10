import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remind_clone_flutter/models/classroom.dart';

class ProfileUserInfo extends StatelessWidget {
  final ClassroomMember member;

  ProfileUserInfo({@required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Info"),
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
                        content: Text("Email Copied", textAlign: TextAlign.center,),
                        duration: Duration(seconds: 1,),
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
                "Classes Joined",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w300),
              ),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Class 1'),
              ),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Class 2'),
              ),
            ],
          ),
        ));
  }
}
