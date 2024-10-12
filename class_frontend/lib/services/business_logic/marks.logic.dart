import 'dart:convert';
import 'package:class_frontend/services/models/marks.model.dart';
import 'package:http/http.dart' as http;

class MarksService {
  final String apiUrl = "https://class-management-992j.onrender.com/api/v1/marks/get-marks";

  // Function to fetch marks data
  Future<Marks> fetchMarks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      
      return Marks.fromJson(json.decode(response.body));
    } else {
      
      throw Exception('Failed to load marks');
    }
  }
}
