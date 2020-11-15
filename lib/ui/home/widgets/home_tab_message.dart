import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  MessageBubble(
                    content:
                        "An Ox came down to a reedy pool to drink. As he splashed heavily into the water, he crushed a young Frog into the mud.",
                  ),
                ],
              ),
            ),
            MessageTextBox(messageInputController: messageInputController),
          ],
        ),
      ),
    );
  }
}

class MessageTextBox extends StatelessWidget {
  const MessageTextBox({
    Key key,
    @required this.messageInputController,
  }) : super(key: key);

  final TextEditingController messageInputController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              hintText: "Send Message...",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: () {},
              splashRadius: 15.0,
            ),
            TextButton(
              onPressed: () {},
              child: Text("SEND"),
            ),
          ],
        )
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String senderName;
  final String content;
  final String createdAt;
  final String avatarUrl;
  final bool isMine = false;

  final CircleAvatar userAvatar = CircleAvatar(
    backgroundColor: Colors.black12,
    child: Icon(
      Icons.group,
      color: Colors.black,
    ),
  );

  final myMessageStyle = BubbleStyle(
    nip: BubbleNip.rightBottom,
    alignment: Alignment.bottomRight,
  );

  final otherMessageStyle = BubbleStyle(
    nip: BubbleNip.leftBottom,
    alignment: Alignment.bottomLeft,
  );

  MessageBubble(
      {this.avatarUrl, this.senderName, this.content, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        userAvatar,
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Bubble(
            child: Text(this.content),
            padding: BubbleEdges.all(12.0),
            style: isMine ? myMessageStyle : otherMessageStyle,
          ),
        ),
      ],
    );
  }
}
