import 'package:class_frontend/Models/Teacher/teacher_model.dart';
import 'package:class_frontend/Services/Business%20Logic/teacher_logic.dart';
import 'package:flutter/material.dart';

class TeacherProvider extends ChangeNotifier{

// this is the student provider with all different functions.
  final TeacherRepo _teacherRepo;

  TeacherProvider(this._teacherRepo);

  Future<void> teacherLogin (TeacherDetails teacher)async {
    // This function handles the teachers login.
    try {
      await _teacherRepo.teacherLogin(teacher);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  

}