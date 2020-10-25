import 'package:flutter/material.dart';

class MessageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _ConversationListTile(),
        _ConversationListTile(),
      ],
    );
  }
}

class _ConversationListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black12,
        child: Icon(
          Icons.group,
          color: Colors.black,
        ),
      ),
      title: Text('Tuan Anh'),
      subtitle: Text(
        'You: Hello! Em an com chua?',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text('12/02/2000'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConversationScreen(),
          ),
        );
      },
    );
  }
}

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final messageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tuan Anh'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
            splashRadius: 20.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  MessageBubble(
                    content:
                        "Iusto voluptatem consequatur delectus fugit non quia delectus atque. Nemo aliquid molestias reiciendis quaerat. Explicabo at quia repudiandae sit et qui. Repellendus dolorum cumque esse vero. Voluptatem eveniet enim libero. In possimus ratione magni provident sit suscipit expedita consectetur.",
                  ),
                ],
              ),
            ),
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[500],
                  icon: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  hintText: "Enter City Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: this.messageInputController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String senderName;
  final String content;
  final String createdAt;
  final String avatarUrl;

  MessageBubble(
      {this.avatarUrl, this.senderName, this.content, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundColor: Colors.black12,
          child: Icon(
            Icons.group,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(this.content),
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }
}
