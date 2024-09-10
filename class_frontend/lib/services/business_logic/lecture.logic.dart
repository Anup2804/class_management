import 'dart:convert';

import 'package:class_frontend/services/functions/shared.dart';
import 'package:class_frontend/services/models/lecture.model.dart';
import 'package:http/http.dart' as http;

class LectureRepository {
  final String _baseUrl = 'https://class-management-992j.onrender.com/api/v1';

  Future<List<Lecture>> getLecture() async {
    final url = Uri.parse('$_baseUrl/lecture/get-lecture');

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
        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((json) => Lecture.fromJson(json)).toList();
        } else {
          throw Exception('Data field not found in response');
        }

      } else {
        final responseBody = json.decode(response.body);

        final errorMessage = responseBody['message'] ?? 'Unable to get lecture';
        throw '$errorMessage';
      }
    } catch (error) {
      throw '$error';
    }
  }
}
