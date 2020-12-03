import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/models/classroom.dart';

class FileTab extends StatefulWidget {
  @override
  _FileTabState createState() => _FileTabState();
}

class _FileTabState extends State<FileTab> {
  Future<void> futureFetchFiles;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO: do people put Provider.of in here? :/ No time to ponder that question, though.
    futureFetchFiles =
        Provider.of<ClassroomStore>(context).fetchClassroomFiles("", 1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFetchFiles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<_FileListTile> children = [];

          for (var file in snapshot.data) {
            children.add(
              _FileListTile(
                file: file,
              ),
            );
          }
          return ListView(
            children: children,
          );
        } else if (snapshot.hasError) {
          // TODO: show error dialog here.
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _FileListTile extends StatelessWidget {
  final IconData leadingIconData;
  final ClassroomFile file;

  _FileListTile({
    this.leadingIconData = Icons.insert_drive_file,
    @required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          leadingIconData,
          color: Colors.black,
        ),
      ),
      title: Text(this.file.name),
      subtitle: Text(
        this.file.size.toString(),
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => _FileDetailScreen(this.file),
          ),
        );
      },
    );
  }
}

class _FileDetailScreen extends StatelessWidget {
  final ClassroomFile file;

  _FileDetailScreen(this.file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Column(
            children: [
              Icon(Icons.insert_drive_file, size: 40.0, color: Colors.blueGrey),
              Text(
                this.file.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text("Open")),
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shared on",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    this.file.createdAt,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Shared by",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Principal Harry",
                    style: TextStyle(fontSize: 15.0),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FileDetailScreenRow extends StatelessWidget {
  final String title;
  final String value;

  _FileDetailScreenRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              this.value,
              style: TextStyle(fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}
