import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:remind_clone_flutter/data/network/socket_service.dart';
import 'package:remind_clone_flutter/models/classroom/conversation.dart';
import 'package:remind_clone_flutter/models/user/user.dart';
import 'package:remind_clone_flutter/stores/classroom_store.dart';
import 'package:remind_clone_flutter/stores/user_store.dart';

class MessageTab extends StatefulWidget {
  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  Future<List<Conversation>> futureFetchConvos;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final classroomStore = Provider.of<ClassroomStore>(context);
    final userStore = Provider.of<UserStore>(context, listen: false);
    futureFetchConvos = classroomStore.fetchConversations(
        userStore.getToken(), classroomStore.currentClassroom?.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFetchConvos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildConvoList(snapshot.data);
        } else if (snapshot.hasError) {
          // TODO: show error dialog here.
          print("${snapshot.error}");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Messages",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                    "All of your conversations will appear here."),
              ],
            ),
          );

        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildConvoList(List<Conversation> convos) {
    List<_ConversationListTile> children = [];

    for (var conversation in convos) {
      children.add(
        _ConversationListTile(conversation),
      );
    }
    if (children.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Messages",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
                "All of your conversations will appear here."),
          ],
        ),
      );
    }
    return ListView(
      children: children,
    );
  }
}

class _ConversationListTile extends StatelessWidget {
  final Conversation conversation;

  _ConversationListTile(this.conversation);

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
      title: Text(conversation.name),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConversationScreen(conversation),
          ),
        );
      },
    );
  }
}

class ConversationScreen extends StatefulWidget {
  final Conversation conversation;

  ConversationScreen(this.conversation);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final messageInputController = TextEditingController();
  Future<List<Message>> futureFetchMessages;
  final SocketService socketService = Injector().get<SocketService>();

  Widget _buildMessageList(List<Message> messages, User sender) {
    final List<MessageBubble> messageBubbles = [];

    for (var message in messages) {
      messageBubbles.add(
        MessageBubble(
          message: message,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(children: messageBubbles),
          ),
          MessageTextBox(
            messageInputController: messageInputController,
            onSend: () {
              socketService.socket.emit("NEW_MESSAGE", {
                "message": messageInputController.text,
                "messageText": messageInputController.text,
                "createdAt": DateTime.now().toIso8601String(),
                "conversationId": widget.conversation.id,
                "sender": sender.toJson(),
              });

              messageInputController.text = "";
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userStore = Provider.of<UserStore>(context, listen: false);
      Provider.of<ClassroomStore>(
        context,
        listen: false,
      )..fetchMessages(
          userStore.getToken(),
          widget.conversation,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final conversation = widget.conversation;
    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.name),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
            splashRadius: 20.0,
          ),
        ],
      ),
      body: Consumer<ClassroomStore>(
        builder: (context, store, child) {
          final userStore = Provider.of<UserStore>(context, listen: false);
          bool messageFetched = conversation.messages != null;
          return messageFetched
              ? _buildMessageList(conversation.messages, userStore.getUser())
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class MessageTextBox extends StatelessWidget {
  const MessageTextBox({
    Key key,
    @required this.messageInputController,
    this.onSend,
    this.onOpenCamera,
    this.onOpenFileUpload,
  }) : super(key: key);

  final TextEditingController messageInputController;
  final VoidCallback onSend;
  final VoidCallback onOpenCamera;
  final VoidCallback onOpenFileUpload;

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
          children: [
            IconButton(
              icon: Icon(
                Icons.file_upload,
              ),
              onPressed: onOpenFileUpload,
              splashRadius: 17.0,
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
              ),
              onPressed: onOpenCamera,
              splashRadius: 17.0,
            ),
            Expanded(
              child: SizedBox(),
            ),
            TextButton(
              onPressed: onSend,
              child: Text("SEND"),
            ),
          ],
        )
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
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

  MessageBubble({this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(message.sender.avatarUrl),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("  " +
                      message.sender.name), // I know... I am a moron, okay :v
                  Bubble(
                    child: Text(message.message),
                    padding: BubbleEdges.all(12.0),
                    style: isMine ? myMessageStyle : otherMessageStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
