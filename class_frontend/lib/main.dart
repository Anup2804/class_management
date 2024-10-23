import 'package:class_frontend/Constants/colors.dart';
import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/main_Screens/Admin/admin_home_screen.dart';
import 'package:class_frontend/Views/main_Screens/Admin/admin_login_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_home_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_lectures_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_login_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_marks_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_notes_screen.dart';
import 'package:class_frontend/Views/main_Screens/Student/student_test_screen.dart';
import 'package:class_frontend/Views/main_Screens/Teacher/teacher_home_screen.dart';
import 'package:class_frontend/Views/main_Screens/Teacher/teacher_login_screen.dart';
import 'package:class_frontend/selection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gurukul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyMedium: mediumBody,
            bodyLarge: largeBody,
            bodySmall: smallBody,
            headlineMedium: mediumHeadline,
          ),
          scaffoldBackgroundColor: backgroudColor),
      routes: {
        "/": (context) => SelectionPage(),
        "/admin/login": (context) => AdminLogin(),
        "/admin/home": (context) => AdminHome(),
        "/teacher/login": (context) => TeacherLogin(),
        "/teacher/home": (context) => TeacherHome(),
        "/student/login": (context) => StudentLogin(),
        "/student/home": (context) => StudentHome(),
        "/student/home/lecture": (context) => StudentLecture(),
        "/student/home/note": (context) => StudentNotes(),
        "/student/home/marks": (context) => StudentMarks(),
        "/student/home/test": (context) => StudentTest()
      },
    );
  }
}
