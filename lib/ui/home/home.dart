import 'package:flutter/material.dart';
import 'package:remind_clone_flutter/ui/class/class_create.dart';
import 'package:remind_clone_flutter/ui/class/class_join.dart';
import 'package:remind_clone_flutter/ui/home/widgets/home_tab_settings.dart';
import 'package:remind_clone_flutter/ui/user/user_settings.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/models/classroom.dart';
import 'widgets/home_tab_message.dart';
import 'widgets/home_tab_file.dart';
import 'package:remind_clone_flutter/widgets/submenu_fab.dart';
import 'package:provider/provider.dart';

enum MenuActions { account, logOut }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, Widget> tabs = {
    "Messages": MessageTab(),
    "Files": FileTab(),
    "People": Center(
      child: Text("People"),
    ),
    "Settings": SettingsTab(),
  };

  TabController _tabController;
  int _selectedTabIndex = 0;

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
          onTap: (tabIndex) {
            setState(() {
              this._selectedTabIndex = tabIndex;
            });
          },
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
              switch(result) {
                case MenuActions.account: {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserSettings())
                  );
                }
                break;
                case MenuActions.logOut: {
                  Navigator.pop(context);
                }
                break;
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<MenuActions>>[
                const PopupMenuItem(
                  value: MenuActions.account,
                  child: Text("Account settings"),
                ),
                const PopupMenuItem(
                  child: Text("Select me!"),
                ),
                const PopupMenuItem(
                  value: MenuActions.logOut,
                  child: Text("Log out!"),
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
      floatingActionButton: this._buildFab(),
    );
  }

  Widget _buildFab() {
    switch (this._selectedTabIndex) {
      case 0:
        return SubmenuFab(
          icons: [Icons.sms, Icons.mail],
          mainIcon: Icons.create,
          pressHandlers: [
            () {
              print("hello");
            },
            () {
              print("hi me");
            },
          ],
        );
        break;
      default:
        return null;
    }
  }

  Drawer buildDrawer(BuildContext context) {
    var classroomStore = Provider.of<ClassroomStore>(context);
    var joinedClassrooms = classroomStore.getJoinedClassrooms();
    var ownedClassrooms = classroomStore.getOwnedClassrooms();

    List<ListTile> joinedClassroomTiles = [];
    for (Classroom classroom in joinedClassrooms) {
      joinedClassroomTiles.add(ListTile(
        title: Text(classroom.name),
        onTap: () {},
      ));
    }

    List<ListTile> ownedClassroomTiles = [];
    for (Classroom classroom in ownedClassrooms) {
      ownedClassroomTiles.add(ListTile(
        title: Text(classroom.name),
        onTap: () {},
      ));
    }

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
                Consumer<UserStore>(
                  builder: (context, store, child) {
                    String userName = store.getUser().name;
                    return Text(
                      userName,
                      style: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ...joinedClassroomTiles,
          ...ownedClassroomTiles,
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
