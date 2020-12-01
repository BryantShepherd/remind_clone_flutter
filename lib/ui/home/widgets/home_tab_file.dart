import 'package:flutter/material.dart';

class FileTab extends StatefulWidget {
  @override
  _FileTabState createState() => _FileTabState();
}

class _FileTabState extends State<FileTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <_FileListTile>[
        _FileListTile(
          fileName: "computer_architecture.pdf",
          fileSize: "30.04 MB",
        ),
      ],
    );
  }
}

class _FileListTile extends StatelessWidget {
  final IconData leadingIconData;
  final String fileName;
  final String fileSize;

  _FileListTile({
    this.leadingIconData = Icons.insert_drive_file,
    @required this.fileName,
    @required this.fileSize,
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
      title: Text(this.fileName),
      subtitle: Text(
        fileSize,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => _FileDetailScreen(),
          ),
        );
      },
    );
  }
}

class _FileDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Column(
            children: [
              Icon(
                Icons.insert_drive_file,
                size: 40.0,
                color: Colors.blueGrey
              ),
              Text(
                "file.pdf",
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
                    "12/10/2020",
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
