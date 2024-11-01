import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/admin_model.dart';
import 'package:http/http.dart' as http;

class AdminRepo {
  Future<void> adminLogin(AdminDetails admin)async{
    final url = Uri.parse('$base_url/admins/login');

    final jsonData = jsonEncode(admin.toJson());

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