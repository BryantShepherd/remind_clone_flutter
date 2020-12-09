import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

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

class PeopleList extends StatefulWidget {
  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  Future futureFetchMembers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final classroomStore = Provider.of<ClassroomStore>(context, listen: false);
    final userStore = Provider.of<UserStore>(context, listen: false);

    futureFetchMembers = classroomStore.fetchClassroomMembers(
        userStore.getToken(), classroomStore.getCurrentClassroom());
  }

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Widget _buildPeopleList(ClassroomStore store) {
    final members = store.getCurrentClassroom()?.members;
    var child = ListView(
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
        for (var member in members)
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(member.avatarUrl),
            ),
            title: Text(member.name),
          ),
      ],
    );

    String token = Provider.of<UserStore>(context, listen: false).getToken();

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async {
        await store.fetchClassroomMembers(token, store.getCurrentClassroom(),
            forced: true);
        _refreshController.refreshCompleted();
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureFetchMembers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<ClassroomStore>(
              builder: (c, store, ch) => _buildPeopleList(store),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Fetch Failed"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
