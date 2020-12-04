import "package:flutter/foundation.dart";
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

  void resetClassrooms(){
    classrooms = [];
  }

  Future<List<ClassroomFile>> fetchClassroomFiles(
      String token, int classroomId) async {
    var classroom = getClassroomById(classroomId);

    if (classroom.files.length > 0) { // TODO: I can't tell if the files have been fetched before this way.
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

  void setCurrentClassroom(int currentClassroomId) {
    currentClassroom = classrooms.firstWhere((element) => element.id == currentClassroomId);
    notifyListeners();
  }

  Classroom getCurrentClassroom() {
    print("object");
    return currentClassroom;
  }
}
