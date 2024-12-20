import 'package:class_frontend/Models/marks_model.dart';
import 'package:class_frontend/Services/Business%20Logic/marks_logic.dart';
import 'package:flutter/material.dart';

class MarksProvider extends ChangeNotifier{
  final MarksRepo _marksRepo = MarksRepo();

  

  Future<void> uploadMarks(MarksData marks ,String path) async {
     try{
      await _marksRepo.uploadMarks(marks,path);
    }
    catch(error){
      rethrow;
    }
  }


}