import "package:flutter/foundation.dart";
import 'package:remind_clone_flutter/models/classroom/conversation.dart';
import "../models/classroom.dart";
import "package:remind_clone_flutter/data/network/api/classroom_api.dart";
import "package:remind_clone_flutter/data/network/rest_client.dart";

class ClassroomStore with ChangeNotifier {
  List<Classroom> classrooms = [];
  Classroom currentClassroom;

  var _client = RestClient();

  void addClassroom(Classroom newClassroom) {
    this.classrooms.add(newClassroom);
    notifyListeners();
  }

  void setClassrooms(List<Classroom> classrooms) {
    this.classrooms = classrooms;
    notifyListeners();
  }

  Classroom getClassroomById(int id) {
    return this.classrooms.firstWhere((classroom) => classroom.id == id);
  }

  List<Classroom> getJoinedClassrooms() {
    return classrooms.where((classroom) => classroom.type == "Member").toList();
  }

  List<Classroom> getOwnedClassrooms() {
    return classrooms.where((classroom) => classroom.type == "Owner").toList();
  }

  Future<void> fetchUserClassrooms(String token) async {
    var classroomApi = ClassroomApi(_client);

    var classrooms = await classroomApi.getUserClassrooms(token);
    var classroomList = List<Classroom>();
    for (var classroom in classrooms) {
      classroomList.add(Classroom.fromJson(classroom));
    }
    setClassrooms(classroomList);
  }

  void resetClassrooms() {
    classrooms = [];
  }

  Future<List<ClassroomFile>> fetchClassroomFiles(
    String token,
    int classroomId,
  ) async {
    var classroom = getClassroomById(classroomId);

    if (classroom.files.length > 0) {
      // TODO: I can't tell if the files have been fetched before this way.
      return classroom.files;
    }

    var classroomApi = ClassroomApi(_client);
    var classroomFiles = await classroomApi.getClassroomFiles(
      token,
      classroomId.toString(),
    );

    for (var file in classroomFiles) {
      classroom.addFile(ClassroomFile.fromJson(file));
    }

    return classroom.files;
  }

  Future<List<Conversation>> fetchConversations(
    String token,
    int classroomId,
  ) async {
    var classroom = getClassroomById(classroomId);
    if (classroom.conversations != null) {
      return classroom.conversations;
    }

    var classroomApi = ClassroomApi(_client);
    var conversations = await classroomApi.getConversations(
      token,
      classroomId.toString(),
    );

    List<Conversation> newConvos = [];

    for (var convo in conversations) {
      newConvos.add(Conversation.fromJson(convo));
    }

    classroom.setConversations(newConvos);

    return classroom.conversations;
  }

  void setCurrentClassroom(int currentClassroomId) {
    currentClassroom =
        classrooms.firstWhere((element) => element.id == currentClassroomId);
    notifyListeners();
  }

  Classroom getCurrentClassroom() {
    return currentClassroom;
  }
}
