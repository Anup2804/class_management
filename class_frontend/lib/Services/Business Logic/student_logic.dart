import 'dart:convert';
import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Services/Providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:class_frontend/Models/student_model.dart';
import 'package:provider/provider.dart';

class StudentRepo {
  Future<StudentDetails> loginStudent(
      BuildContext context, StudentDetails student) async {
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
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true &&
            responseBody.containsKey('data')) {
          final data = responseBody['data'];

          StudentDetails studentDetails =
              StudentDetails.fromJson(data['sutdentDetails']);

          StudentData studentData = StudentData.fromJson(responseBody);

          Provider.of<StudentProvider>(context, listen: false)
              .setStudent(studentData);

          print(
              'Student data saved in provider: ${studentData.accessToken.toString()}');

          return studentDetails;
        } else {
          throw Exception(responseBody['message'] ?? 'Login failed');
        }
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unable to login';
        print('Unable to login: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw 'Failed to login';
      // rethrow;
    }
  }
}
