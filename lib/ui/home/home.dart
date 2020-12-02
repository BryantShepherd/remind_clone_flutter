import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/ui/class/class_create.dart';
import 'package:remind_clone_flutter/ui/class/class_join.dart';
import 'package:remind_clone_flutter/ui/home/widgets/home_tab_settings.dart';
import 'package:remind_clone_flutter/ui/user/user_settings.dart';
import 'widgets/home_tab_message.dart';

enum MenuActions { account, logOut }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, Widget> tabs = {
    "Messages": MessageTab(),
    "Files": Center(
      child: Text("Files"),
    ),
    "People": Center(
      child: Text("People"),
    ),
    "Settings": SettingsTab(),
  };

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Class"),
        bottom: TabBar(
          controller: this._tabController,
          isScrollable: true,
          tabs: <Tab>[
            for (final tabLabel in this.tabs.keys)
              Tab(
                text: tabLabel,
              )
          ],
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
          PopupMenuButton<MenuActions>(
            onSelected: (result) {
              if (result == MenuActions.logOut) {
                Navigator.pop(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<MenuActions>>[
                const PopupMenuItem(
                  child: Text("Select me!"),
                ),
                const PopupMenuItem(
                  child: Text("Select me!"),
                ),
                const PopupMenuItem(
                  value: MenuActions.logOut,
                  child: Text("Get me out!"),
                ),
              ];
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[for (final tab in this.tabs.values) tab],
      ),
      drawer: buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.create,
        ),
        onPressed: () {
          print(this._tabController.index);
        },
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    iconSize: 80.0,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserSettings(),
                        ),
                      );
                    }),
                Text(
                  "Koro",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Joined(),
          Owned(),
        ],
      ),
    );
  }
}

class Joined extends StatefulWidget {
  @override
  _JoinedState createState() => _JoinedState();
}

class _JoinedState extends State<Joined> {
  final List<Map<String, dynamic>> _joined = [
    {"name": "Web Development"},
    {"name": "Mobile Development"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Joined"),
        ),
        ListTile(
          leading: Icon(
            Icons.add_circle_outline,
            size: 35.0,
          ),
          title: Text('Join class'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ClassCreate(),
              ),
            );
          },
        ),
        for (int i = 0; i < _joined.length; i++)
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 35.0,
            ),
            title: Text(_joined[i]["name"]),
            onTap: () {},
          ),
      ],
    );
  }
}

class Owned extends StatefulWidget {
  @override
  _OwnedState createState() => _OwnedState();
}

class _OwnedState extends State<Owned> {
  final List<Map<String, dynamic>> _owned = [
    {"name": "Web Development"},
    {"name": "Mobile Development"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Owned"),
        ),
        ListTile(
          leading: Icon(
            Icons.add_circle_outline,
            size: 35.0,
          ),
          title: Text('Create class'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ClassCreate(),
              ),
            );
          },
        ),
        for (int i = 0; i < _owned.length; i++)
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 35.0,
            ),
            title: Text(_owned[i]["name"]),
            onTap: () {},
          ),
      ],
    );
  }
}
