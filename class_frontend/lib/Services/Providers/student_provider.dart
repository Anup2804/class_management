import 'package:class_frontend/Models/student_model.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier {
  StudentData? _studentData;

  StudentData? get studentData => _studentData;

  void setStudent(StudentData students) {
    _studentData = students;
    notifyListeners();
  }

  void clearStudentData() {
    _studentData = null;
    notifyListeners();
  }
}
