import 'package:class_frontend/services/business_logic/student_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:class_frontend/services/models/auth_model/signup.model.dart';

class StudentProvider extends ChangeNotifier {
  final StudentRepository _studentRepository;

  StudentProvider(this._studentRepository);

  Future<void> createStudent(Student user) async {
    try {
      await _studentRepository.createStudent(user);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> loginStudent(Student user) async {
    try {
      await _studentRepository.loginStudent(user);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
