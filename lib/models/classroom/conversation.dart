import '../user/user.dart';

class Conversation {
  int id;
  String name;
  String type;
  List<User> members;
  List<Message> messages;

  Conversation({this.id, this.name, this.type});

  void setMembers(List<User> members) {
    this.members = members;
  }

  void addMember(User member) {
    if (members == null) {
      throw NullThrownError();
    }
    this.members.add(member);
  }

  void setMessages(List<Message> messages) {
    this.messages = messages;
  }

  void addMessage(Message message) {
    if (messages == null) {
      throw NullThrownError();
    }
    message.setConversation(this);
    this.messages.add(message);
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json["id"],
      name: json["name"] ?? json["conversation_name"],
      type: json["type"],
    );
  }
}

class Message {
  int id;
  User sender;
  String messageText;
  String message;
  String createdAt;
  Conversation conversation;

  Message({
    this.id,
    this.messageText,
    this.sender,
    this.message,
    this.createdAt,
    this.conversation,
  });

  void setConversation(Conversation conversation) {
    this.conversation = conversation;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      sender: User.fromJson(json["sender"]),
      message: json["message"],
      messageText: json["messageText"] ?? json["message_text"],
      createdAt: json["createdAt"] ?? json["created_at"],
    );
  }
}
