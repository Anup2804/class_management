import 'package:class_frontend/auth/login.dart';
import 'package:class_frontend/auth/signup.dart';
import 'package:class_frontend/pages/otherPages/home.dart';
import 'package:class_frontend/pages/otherPages/lecture.dart';
import 'package:class_frontend/pages/otherPages/marks.dart';
import 'package:class_frontend/pages/otherPages/test.dart';
import 'package:class_frontend/services/business_logic/student_auth.dart';
import 'package:class_frontend/services/provider/lecture.provider.dart';
import 'package:class_frontend/services/provider/student.provider.dart';
import 'package:class_frontend/services/provider/test.provier.dart';
import 'package:class_frontend/utils/colors.dart';
import 'package:class_frontend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StudentProvider(StudentRepository()),
        ),
        ChangeNotifierProvider(create: (context) => LectureProvider()),
        ChangeNotifierProvider(
          create: (context) => TestProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backGroundColor,
          textTheme: TextTheme(
              bodyMedium: fontMedium,
              bodyLarge: fontLarge,
              bodySmall: fontSmall,
              displayLarge: fontExtraLarge,
              headlineLarge: fontMediumLarge,
              displayMedium: fontRegular),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )),
        ),
        // home: SignUp(),
        routes: {
          '/': (context) => StudentLogin(),
          '/signup': (context) => SignUp(),
          '/home': (context) => HomeScreen(),
          '/lecture': (context) => LectureScreen(),
          '/test': (context) => TestScreen(),
          '/marks': (context) => MarksPage()
        },
      ),
    );
  }
}
