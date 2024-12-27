import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:class_frontend/Constants/variable.dart';
import 'package:class_frontend/Models/marks_model.dart';

class MarksRepo {
  Future<String> uploadMarks(MarksData mark, String filePath) async {
    final uri = Uri.parse('$base_url/marks/upload-marks');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('teacherAccessToken');

    try {
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'Bearer $accessToken',
      });

      if (filePath.isNotEmpty) {
        final file = File(filePath);
        if (await file.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
            'file',
            file.path,
            filename: basename(file.path),
          ));
        } else {
          throw Exception('File not found at $filePath');
        }
      }

      request.fields['subjectName'] = mark.subjectName;
      request.fields['board'] = mark.board;
      request.fields['chapterNo'] = mark.chapterNo;
      request.fields['standard'] = mark.standard;
      // request.fields['description'] = mark.description!;

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final responeBody = await response.stream.bytesToString();
        print(responeBody);

        //  final data = jsonDecode(responeBody);

        return 'done uploading';
      } else {
        // Decode response for error message
        final responseBody = await response.stream.bytesToString();
        final errorMessage =
            jsonDecode(responseBody)['message'] ?? 'Unable to upload';
        print(errorMessage);
        throw errorMessage;
      }
    } catch (err) {
      rethrow;
    }
  }
}
