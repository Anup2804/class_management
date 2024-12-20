import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/lecture_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LectureRepo {
  Future<LectureNotice> getLectureDetails() async {
    final url = Uri.parse('$base_url/lecture/get-lecture');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('studentAccessToken');
    if (accessToken == null) throw Exception('No access token found');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        LectureNotice lectureNotice = LectureNotice.fromJson(data);

        return lectureNotice;
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Unable to load the test data';
        print('Error: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (err) {
      rethrow;
    }
  }

  // Future<LectureNotice> uploadLectureData() async {
  //   final uri = Uri.parse('$base_url/');
  // }

}
