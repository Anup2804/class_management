import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/teacher_model.dart';
import 'package:class_frontend/Services/Providers/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherRepo {
  Future<TeacherDetails> teacherLogin(
      BuildContext context, TeacherDetails teacher) async {
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

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true &&
            responseBody.containsKey('data')) {
          final data = responseBody['data'];

          print(responseBody);

          TeacherDetails teacherDetails =
              TeacherDetails.fromJson(data['teacherDetails']);

          TeacherData teacherData = TeacherData.fromJson(data);

          Provider.of<TeacherProvider>(context, listen: false)
              .setTeacher(teacherData);

          print(
              'Teacher data saved in provider: ${teacherData.generateAccessToken.toString()}');

          final prefs = await SharedPreferences.getInstance();

          await prefs.setString(
              'teacherAccessToken', teacherData.generateAccessToken);

          print('Access token saved: ${teacherData.generateAccessToken}');

          return teacherDetails;
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
      throw 'Failed to login Teacher';
      // rethrow;
    }
  }

  Future<void> teacherRegister(TeacherDetails teacher) async {
    final url = Uri.parse('$base_url/teacher/register');

    final jsonData = jsonEncode(teacher.toJson());

    print(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print(response.body);
        print('register done');
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unable to register';
        print('Unable to register: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (err) {
      throw ('failed to register.');
    }
  }
}