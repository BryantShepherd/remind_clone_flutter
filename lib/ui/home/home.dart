import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:remind_clone_flutter/data/network/socket_service.dart';
import 'package:remind_clone_flutter/ui/class/class_create.dart';
import 'package:remind_clone_flutter/ui/class/class_join.dart';
import 'package:remind_clone_flutter/ui/home/widgets/home_tab_settings.dart';
import 'package:remind_clone_flutter/ui/user/user_settings.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';
import 'package:remind_clone_flutter/models/classroom.dart';
import 'package:remind_clone_flutter/widgets/search_page.dart';
import 'widgets/home_tab_message.dart';
import 'package:provider/provider.dart';
import 'widgets/home_tab_file.dart';
import 'package:remind_clone_flutter/widgets/submenu_fab.dart';
import '../people/people_list.dart';

enum MenuActions { account, logOut }

class HomeScreen extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "Text $index"); //Truyền list để search vào đây

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Map<String, Widget> tabs = {
    "Messages": MessageTab(),
    "Files": FileTab(),
    "People": PeopleList(),
    "Settings": SettingsTab(),
  };

  Future<bool> _onWillPop() async {
    return await SystemChannels.platform
        .invokeMethod<bool>('SystemNavigator.pop', true);
  }

  TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        final classroomStore = Provider.of<ClassroomStore>(context, listen: false);
        final userStore = Provider.of<UserStore>(context, listen: false);
        await classroomStore.fetchUserClassrooms(userStore.getToken());
        classroomStore
            .setCurrentClassroom(classroomStore.classrooms.first.id);
        final socketService = Injector().get<SocketService>();
        socketService.connectWithToken(
            socketService.socket, userStore.getToken());
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context, listen: false);
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(classroomStore.currentClassroom != null? classroomStore.currentClassroom.name : ""),
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
                showSearch(context: context, delegate: Search(widget.list));
              },
              //TODO: Use variables or constant instead of a 'magic number'
              splashRadius: 20.0,
            ),
            PopupMenuButton<MenuActions>(
              onSelected: (result) async {
                switch (result) {
                  case MenuActions.account:
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserSettings()));
                    }
                    break;
                  case MenuActions.logOut:
                    {
                      await userStore.resetUser();
                      classroomStore.resetClassrooms();
                      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
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
      ),
      onWillPop: _onWillPop,
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
    final classroomStore = Provider.of<ClassroomStore>(context);
    final userStore = Provider.of<UserStore>(context);

    var joinedClassrooms = classroomStore.getJoinedClassrooms();
    var ownedClassrooms = classroomStore.getOwnedClassrooms();

    List<ListTile> joinedClassroomTiles = [
      ListTile(
        title: Text("Joined"),
      ),
      ListTile(
        leading: Icon(
          Icons.add_circle_outline,
          size: 35.0,
          color: Colors.blue,
        ),
        title: Text('Join class'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ClassJoin(),
            ),
          );
        },
      ),
    ];
    for (Classroom classroom in joinedClassrooms) {
      joinedClassroomTiles.add(ListTile(
        leading: Icon(
          Icons.account_circle,
          size: 35.0,
          color: Colors.blue,
        ),
        title: Text(classroom.name),
        onTap: () {
          classroomStore.setCurrentClassroom(classroom.id);
          Navigator.pop(context);
        },
      ));
    }

    List<ListTile> ownedClassroomTiles = [
      ListTile(
        title: Text("Created"),
      ),
      ListTile(
        leading: Icon(
          Icons.add_circle_outline,
          size: 35.0,
          color: Colors.blue,
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
    ];
    for (Classroom classroom in ownedClassrooms) {
      ownedClassroomTiles.add(ListTile(
        leading: Icon(
          Icons.account_circle,
          size: 35.0,
          color: Colors.blue,
        ),
        title: Text(classroom.name),
        onTap: () {
          classroomStore.setCurrentClassroom(classroom.id);
          Navigator.pop(context);
        },
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
          ...ownedClassroomTiles,
          ...joinedClassroomTiles,
        ],
      ),
    );
  }
}
