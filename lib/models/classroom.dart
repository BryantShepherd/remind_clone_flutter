import 'classroom/conversation.dart';
import 'user/user.dart';

class Classroom {
  int id;
  String code;
  String name;
  String school;
  String type;
  List<ClassroomFile> files = [];
  List<Conversation> conversations;
  List<ClassroomMember> members;

  Classroom({this.id, this.code, this.name, this.school, this.type});

  void setFiles(List<ClassroomFile> files) {
    this.files = files;
  }

  void addFile(ClassroomFile file) {
    this.files.add(file);
  }

  void setConversations(List<Conversation> convos) {
    this.conversations = convos;
  }

  void addConversation(Conversation convo) {
    if (this.conversations == null) {
      throw NullThrownError();
    }
    this.conversations.add(convo);
  }

  void setMembers(List<ClassroomMember> members) {
    this.members = members;
  }

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      school: json["school"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "code": this.code,
      "name": this.name,
      "school": this.school,
    };
  }
}

// TODO: Add classroom settings
class ClassroomSettings {
  bool requireApproval;
  String participantMessaging;
}

class ClassroomFile {
  int id;
  String name;
  String url;
  String type;
  int size;
  String createdAt;

  ClassroomFile(
      {this.id, this.name, this.url, this.type, this.size, this.createdAt});

  factory ClassroomFile.fromJson(Map<String, dynamic> json) {
    return ClassroomFile(
      id: json["id"],
      name: json["name"],
      url: json["url"],
      type: json["type"],
      size: json["size"],
      createdAt: json["createdAt"] ?? json["created_at"],
    );
  }
}

// Should have extends User or some common interfaces
class ClassroomMember extends User {
  String type;
  String joinedDate;

  ClassroomMember({
    int id,
    String name,
    String email,
    String avatarUrl,
    this.type,
    this.joinedDate,
  }) : super(id: id, name: name, email: email, avatarUrl: avatarUrl);

  factory ClassroomMember.fromJson(Map<String, dynamic> json) {
    return ClassroomMember(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      avatarUrl: json["avatarUrl"] ?? json["avatar_url"],
      type: json["type"],
      joinedDate: json["joinedDate"] ?? json["joined_date"],
    );
  }
}
