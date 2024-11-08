import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/test_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TestRepo {
  Future<TestNotice> getTestDetails() async {
    final url = Uri.parse('${base_url}/test/get-testnotice');
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

        TestNotice testNotice = TestNotice.fromJson(data);

        return testNotice;
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['message'] ?? 'Unable to load the test data';
        print('Error: $errorMessage');
        throw Exception(errorMessage);
      }
    } catch (error) {
      print('Error: $error');
      throw 'Failed to load test';
    }
  }

  Future<String> postTestDetails(TestData testDetail) async {
    final url = Uri.parse("$base_url/test/add-test");

    final jsonData = jsonEncode(testDetail.toJson());

    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('teacherAccessToken');
    if (accessToken == null) throw Exception('No access token found');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        return 'uploaded successfully';
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Unable to upload';
        throw Exception(errorMessage);
      }
    } catch (error) {
      rethrow;
    }
  }
}
