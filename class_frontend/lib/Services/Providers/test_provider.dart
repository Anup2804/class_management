import 'package:class_frontend/Models/test_model.dart';
import 'package:class_frontend/Services/Business%20Logic/test_logic.dart';
import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  final TestRepo _testRepo = TestRepo();
  TestNotice? _testNotice;

  TestNotice? get testNotice => _testNotice;

  Future<void> fetchTestDetails() async {
    try {
      _testNotice = await _testRepo.getTestDetails();
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> postTestDetails(TestData test)async{
    try{
      await _testRepo.postTestDetails(test);
    }
    catch(error){
      rethrow;
    }
    notifyListeners();
  }
}
