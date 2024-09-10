import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeLoginData(Map<String, dynamic> responseData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final studentDetails = responseData['data']['sutdentDetails'];
  await prefs.setString('studentId', studentDetails['_id']);
  await prefs.setString('fullName', studentDetails['fullName']);
  await prefs.setString('adminName', studentDetails['adminName']);
  await prefs.setString('email', studentDetails['email']);
  await prefs.setString('standard', studentDetails['standard']);
  await prefs.setString('schoolName', studentDetails['schoolName']);
  await prefs.setString('board', studentDetails['board']);
  await prefs.setString('phoneNo', studentDetails['phoneNo']);

  await prefs.setString(
      'accessToken', responseData['data']['generateAccessToken']);
  await prefs.setString(
      'refreshToken', responseData['data']['generateRefreshToken']);
}

Future<String?> retrieveLoginData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? studentId = prefs.getString('studentId');
  String? fullName = prefs.getString('fullName');
  String? adminName = prefs.getString('adminName');
  String? standard = prefs.getString('standard');
  String? BoardName = prefs.getString('board');
  String? access = prefs.getString('accessToken');
  String? refresh = prefs.getString('refreshToken');

  print('$studentId');
  print('$fullName');
  print('$adminName');
  print('$BoardName');
  print('$standard');
  print('$access');
  print('$refresh');
  

  return access;
}
