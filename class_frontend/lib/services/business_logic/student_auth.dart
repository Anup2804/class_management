import 'dart:convert';
import 'package:class_frontend/services/functions/shared.dart';
import 'package:http/http.dart' as http;
import 'package:class_frontend/services/models/auth_model/signup.model.dart';

class StudentRepository {
  final String _baseUrl = 'https://class-management-992j.onrender.com/api/v1';

  Future<void> createStudent(Student user) async {
    final url = Uri.parse('$_baseUrl/student/register');
    final jsonData = jsonEncode(user.toJson());
    print(jsonData);

    try {
      final response = await http.post(
        url,
        // headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonData,
      );

      print('statuscode:${response.statusCode}');
      print('Response Body:${response.body}');

      if (response.statusCode == 200) {
        print('User created successfully');
      } else {
        print('Unable to create user: ${response.statusCode}');
        throw Exception(response);
      }
    } catch (error) {
      print('Error: $error');
      throw 'Failed to create user';
    }
  }

  Future<void> loginStudent(Student user) async {
    final url = Uri.parse('$_baseUrl/student/login');
    final jsonData = jsonEncode(user.toLoginJson());

    print(jsonData);

    try {
      final response = await http.post(
        url,
        body: jsonData,
      );

      print('statuscode: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Login successful');

        final responseBody = json.decode(response.body);
        await storeLoginData(responseBody);
        // await retrieveLoginData();
      } else {
        final responseBody = json.decode(response.body);

        final errorMessage = responseBody['message'] ?? 'Unable to login';
        print('Unable to login: $errorMessage');
        throw '$errorMessage';
      }
    } catch (error) {
      print('Error: $error');
      throw '$error';
    }
  }
}
