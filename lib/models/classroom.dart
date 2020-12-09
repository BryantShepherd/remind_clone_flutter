import 'classroom/conversation.dart';

class Classroom {
  int id;
  String code;
  String name;
  String school;
  String type;
  List<ClassroomFile> files = [];
  List<Conversation> conversations;

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

  Map<String, dynamic> toJsonSnakeCase() {
    return {
      "id": id,
      "name": name,
      "url": url,
      "type": type,
      "size": size,
      "created_at": createdAt,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "name": name,
      "type": type,
      "size": size,
      "createdAt": createdAt,
    };
  }
}
