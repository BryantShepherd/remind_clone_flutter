import "package:flutter/foundation.dart";
import 'package:remind_clone_flutter/data/network/network_exceptions.dart';
import "../models/classroom.dart";
import "package:remind_clone_flutter/data/network/api/classroom_api.dart";
import "package:remind_clone_flutter/data/network/rest_client.dart";

class ClassroomStore with ChangeNotifier {
  List<Classroom> classrooms = [];

  void addClassroom(Classroom newClassroom) {
    this.classrooms.add(newClassroom);
  }

  void setClassrooms(List<Classroom> classrooms) {
    this.classrooms = classrooms;
  }

  List<Classroom> getJoinedClassrooms() {
    return classrooms.where((classroom) => classroom.type == "Member").toList();
  }

  List<Classroom> getOwnedClassrooms() {
    return classrooms.where((classroom) => classroom.type == "Owner").toList();
  }

  Future<void> fetchUserClassrooms(String token) async {
    var client = RestClient();
    var classroomApi = ClassroomApi(client);

    var classrooms = await classroomApi.getUserClassrooms(token);
    for (var classroom in classrooms) {
      this.addClassroom(Classroom.fromJson(classroom));
    }
  }
}
