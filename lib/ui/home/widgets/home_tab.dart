// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final Map<String, Widget> tabs = {
    "Messages": null,
    "Files": null,
    "People": null,
    "Settings": null,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: this.tabs.length,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: TabBarView(
          children: [
            for (final tab in this.tabs.entries)
              tab.value ??
                  Center(
                    child: Text(tab.key),
                  ),
          ],
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Classroom Name"),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabs: [
              for (final tabLabel in this.tabs.keys) Tab(text: tabLabel),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            //TODO: Implement search bar
            print("Show search bar");
          },
          //TODO: Use variables or constant instead of a 'magic number'
          splashRadius: 20.0,
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            //TODO: Implement show menu
            print("Show menu");
          },
          splashRadius: 20.0,
        ),
      ],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Mị Nương",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.one_k),
            title: Text('Item 1'),
          ),
          ListTile(
            leading: Icon(Icons.two_k),
            title: Text('item 2'),
          ),
        ],
      ),
    );
  }
}
