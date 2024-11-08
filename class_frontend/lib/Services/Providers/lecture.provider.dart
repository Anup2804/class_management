import 'package:class_frontend/Models/lecture_model.dart';
import 'package:class_frontend/Services/Business%20Logic/lecture.logic.dart';
import 'package:flutter/material.dart';

class LectureProvider extends ChangeNotifier{
  final LectureRepo _lectureRepo = LectureRepo();

  LectureNotice? _lectureNotice;

  LectureNotice? get lectureNotice => _lectureNotice;

  Future<void> fetchLectureNotice() async{
    _lectureNotice = await _lectureRepo.getLectureDetails();
    notifyListeners();
  }
}