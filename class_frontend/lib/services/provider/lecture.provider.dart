import 'package:class_frontend/services/business_logic/lecture.logic.dart';
import 'package:class_frontend/services/models/lecture.model.dart';
import 'package:flutter/foundation.dart';

class LectureProvider with ChangeNotifier {
  List<Lecture> _lectures = [];
  bool _isLoading = false;

  List<Lecture> get lectures => _lectures;
  bool get isLoading => _isLoading;

  final LectureRepository _lectureRepository = LectureRepository();

  Future<void> fetchLectures() async {
    _isLoading = true;
    notifyListeners();

    try {
      _lectures = await _lectureRepository.getLecture();
    } catch (error) {
      print('Error fetching lectures: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
