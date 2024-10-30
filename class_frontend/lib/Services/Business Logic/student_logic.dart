import 'dart:convert';
import 'package:class_frontend/Constants/variable.dart';
import 'package:http/http.dart' as http;
import 'package:class_frontend/Models/Student/student_model.dart';

class StudentRepo {
  Future<void> loginStudent(StudentDetails student) async {
    // This function establish the connection with the endpoint of the student login api.
    final url = Uri.parse('$base_url/student/login');

    final jsonData = jsonEncode(student.toJson());

    print(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        print('Login successful');
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unable to login';
        print('Unable to login: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw 'Failed to login';
    }
  }
}
