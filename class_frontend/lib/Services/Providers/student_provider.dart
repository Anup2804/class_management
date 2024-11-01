import 'package:class_frontend/Models/student_model.dart';
import 'package:class_frontend/Services/Business%20Logic/student_logic.dart';
import 'package:flutter/material.dart';

class StudentProvider extends ChangeNotifier{

// this is the student provider with all different functions.
  final StudentRepo _studentRepo;

  StudentProvider(this._studentRepo);

  Future<void> studentLogin (StudentDetails student)async {
    // This function handles the student login.
    try {
      await _studentRepo.loginStudent(student);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  

}