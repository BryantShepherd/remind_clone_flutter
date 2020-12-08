import 'package:flutter/material.dart';

class PeopleAddPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text(
                "Add to class",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const Divider(thickness: 1),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 21,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text("Text2"),
          //       );
          //     },
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('Phone number or email'),
          ),
          ListTile(
            leading: Icon(Icons.contact_mail_outlined),
            title: Text('Pick from contacts'),
          ),
        ],
      ),
    );
  }
}

class PopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text(
                "User",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PeopleList extends StatelessWidget {
  void showPeopleAddPrompt(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return PeopleAddPrompt();
      },
    );
  }

  void showPopUp(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return PopUp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          leading: Icon(
            Icons.account_circle,
            size: 35,
            color: Colors.green,
          ),
          title: Text('Add people'),
          onTap: () {
            showPeopleAddPrompt(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.link,
            size: 35,
            color: Colors.orange,
          ),
          title: Text('Share a join link'),
          onTap: () {
            showPopUp(context);
          },
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
        for (int i = 0; i < 10; ++i)
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Name'),
          ),
      ],
    );
  }
}
