class Classroom {
  int id;
  String code;
  String name;
  String school;
  String type;

  Classroom({this.id, this.code, this.name, this.school, this.type});

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