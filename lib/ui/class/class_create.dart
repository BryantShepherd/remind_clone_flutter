import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassCreate extends StatelessWidget {
  final RestorableBool _switch = RestorableBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a class"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
