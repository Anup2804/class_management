import 'package:class_frontend/services/business_logic/test.logic.dart';
import 'package:class_frontend/services/models/test.model.dart';
import 'package:flutter/foundation.dart';

class TestProvider with ChangeNotifier {
  List<Test> _test = [];
  bool _isLoading = false;

  List<Test> get test => _test;
  bool get isLoading => _isLoading;

  final TestRepository _testRepository = TestRepository();

  Future<void> fetchTest() async {
    _isLoading = true;
    notifyListeners();

    try {
      _test = await _testRepository.getTest();
    } catch (error) {
      print('Error fetching Test: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
