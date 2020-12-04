import 'package:share/share.dart';
import 'package:flutter/material.dart';

class PeopleShareLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = 'https://medium.com/@suryadevsingh24032000';
    String subject = 'follow me';

    return Scaffold(
      appBar: AppBar(
        title: Text("Share link"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Share this link",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
            ),
          ),
          Center(
            child: Text(
              "This link include your class code, so anyone who has it can join your class instantly.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: FlatButton(
              height: 50.0,
              minWidth: 300,
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: () {
                Share.share("link lop hoc");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.share),
                  Text("Share"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          // Center(
          //   child: Text(
          //     "Share with Subject  works only while sharing on email",
          //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
          //   ),
          // ),
          // Center(
          //   child: MaterialButton(
          //     elevation: 5.0,
          //     height: 50.0,
          //     minWidth: 150,
          //     color: Colors.green,
          //     textColor: Colors.white,
          //     child: Icon(Icons.share),
          //     onPressed: () {
          //       Share.share(
          //           'check out my website https://protocoderspoint.com/',
          //           subject: 'Sharing on Email');
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
