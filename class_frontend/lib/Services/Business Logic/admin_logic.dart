import 'dart:convert';

import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/admin_model.dart';
import 'package:class_frontend/Services/Providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminRepo {
  Future<AdminDetails> adminLogin(
      BuildContext context, AdminDetails admin) async {
    final url = Uri.parse('$base_url/admins/login');

    final jsonData = jsonEncode(admin.toJson());

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

          AdminDetails adminDetails =
              AdminDetails.fromJson(data['adminDetails']);

          AdminData adminData = AdminData.fromJson(data);

          Provider.of<AdminProvider>(context, listen: false)
              .setAdmin(adminData);

          return adminDetails;
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
    }
  }
}
