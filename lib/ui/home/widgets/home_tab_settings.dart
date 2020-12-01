import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Icon(
            Icons.account_circle,
            size: 100,
          ),
        ),
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
              hintText: 'Class name'),
          onChanged: (text) {},
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        Text(
          "Class code",
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
              hintText: 'Class code'),
          onChanged: (text) {},
        ),
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
              hintText: 'School name'),
          onChanged: (text) {},
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        SwitchListTile(
          title: Text("Required approval to join"),
          subtitle: Text(
              "Only people you add or approve will be able to join this class"),
          value: true,
          onChanged: (bool) {},
        ),
        Padding(padding: const EdgeInsets.all(5.0)),
        Text(
          "Class owner",
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 20.0,
              ),
        ),
        ClassOwner(),
        Padding(padding: const EdgeInsets.all(5.0)),
        OutlinedButton.icon(
          icon: const Icon(
            Icons.highlight_remove_rounded,
            size: 18,
            color: Colors.red,
          ),
          label: Text("Remove me as class owner",
              style: TextStyle(
                color: Colors.red,
              )),
          onPressed: () {},
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          icon: const Icon(Icons.highlight_remove_rounded, size: 20),
          label: Text("Delete Class"),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ClassOwner extends StatelessWidget {
  final List<String> nameList = new List<String>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        restorationId: 'list_demo_list_view',
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (int index = 1; index < 5; index++)
            ListTile(
              leading: ExcludeSemantics(
                child: CircleAvatar(child: Text('$index')),
              ),
              title: Text("Haipro"),
            ),
        ],
      ),
    );
  }
}
