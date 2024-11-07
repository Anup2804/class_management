import 'package:class_frontend/Models/teacher_model.dart';
import 'package:flutter/material.dart';

class TeacherProvider extends ChangeNotifier {
TeacherData? _teacherData;

  // Expose the teacher data
  TeacherData? get teacherData => _teacherData;

  // Method to set teacher data in the provider
  void setTeacher(TeacherData teacherData) {
    _teacherData = teacherData;
    notifyListeners();
  }

  // Clear teacher data (for logout or resetting state)
  void clearTeacherData() {
    _teacherData = null;
    notifyListeners();
  }
}
