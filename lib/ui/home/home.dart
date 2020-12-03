import 'package:flutter/material.dart';
import 'widgets/home_tab_message.dart';
import 'widgets/home_tab_file.dart';
import 'package:remind_clone_flutter/widgets/submenu_fab.dart';

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
    "Settings": Center(
      child: Text("Settings"),
    ),
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
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.two_k),
            title: Text('item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
