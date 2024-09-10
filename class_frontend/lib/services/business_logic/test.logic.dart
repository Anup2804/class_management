import 'dart:convert';

import 'package:class_frontend/services/functions/shared.dart';
import 'package:class_frontend/services/models/test.model.dart';
import 'package:http/http.dart' as http;

class TestRepository {
  final String _baseUrl = 'https://class-management-992j.onrender.com/api/v1';

  Future<List<Test>> getTest() async {
    final url = Uri.parse('$_baseUrl/test/get-testnotice');

    try {
      final String? access = await retrieveLoginData();
      print(access);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $access',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        print(response.body);
        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          print(data);
          return data.map((json) => Test.fromJson(json)).toList();
        } else {
          throw Exception('Data field not found in response');
        }


      } else {
        final responseBody = json.decode(response.body);

        final errorMessage = responseBody['message'] ?? 'Unable to get Test notice';
        throw '$errorMessage';
      }
    } catch (error) {
      throw '$error';
    }
  }
}
