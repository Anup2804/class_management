import 'package:class_frontend/Constants/colors.dart';
import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Services/Business%20Logic/admin_logic.dart';
import 'package:class_frontend/Services/Business%20Logic/teacher_logic.dart';
import 'package:class_frontend/Services/Providers/admin_provider.dart';
import 'package:class_frontend/Services/Providers/lecture.provider.dart';
import 'package:class_frontend/Services/Providers/student_provider.dart';
import 'package:class_frontend/Services/Business Logic/student_logic.dart';
import 'package:class_frontend/Services/Providers/teacher_provider.dart';
import 'package:class_frontend/Services/Providers/test_provider.dart';
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
import 'package:class_frontend/Views/main_Screens/Teacher/teacher_upload_test.dart';
import 'package:class_frontend/selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (_)=> TeacherRepo()),
    Provider(create:(_)=> StudentRepo()),
    Provider(create:(_) => AdminRepo()),
    ChangeNotifierProvider(create: (_) => StudentProvider()),
    ChangeNotifierProvider(create: (_) => TeacherProvider()),
    ChangeNotifierProvider(create: (_) => AdminProvider()),
    ChangeNotifierProvider(create: (_) => TestProvider()),
    ChangeNotifierProvider(create: (_) => LectureProvider())
  ], child: const MyApp()));
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
      // home: DataForm(),
      routes: {
        "/": (context) => SelectionPage(),
        "/admin/login": (context) => AdminLogin(),
        "/admin/home": (context) => AdminHome(),
        "/teacher/login": (context) => TeacherLogin(),
        "/teacher/home": (context) => TeacherHome(),
        "/teacher/upload/test":(context) => UploadTest(),
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
