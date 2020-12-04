import 'package:flutter/material.dart';

class ClassJoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Join a class"),
          actions: [
            FlatButton(
              textColor: Colors.white,
              onPressed: () {},
              child: Text("Join"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: <Widget>[
            Text(
              "Class code",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6
                  .copyWith(
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
                hintText: "Enter class code",
              ),
              onChanged: (text) {},
            ),
          ],
        ),
    );
  }
}
