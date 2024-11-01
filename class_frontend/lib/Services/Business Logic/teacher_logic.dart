import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/teacher_model.dart';
import 'package:http/http.dart' as http;

class TeacherRepo {
  Future<void> teacherLogin(TeacherDetails teacher) async {
    // This function handles the endpoint for teacher login.

    final url = Uri.parse('$base_url/teacher/login');

    final jsonData = jsonEncode(teacher.toJson());

    print(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonData,
      );

      print(response);

      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        print('Teacher Login successful');
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unable to login';
        print('Unable to login: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw 'Failed to login Teacher';
    }
  }
}
