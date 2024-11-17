import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:class_frontend/Views/common_Widgets/login_form.dart';
import 'package:flutter/material.dart';

class TeacherLogin extends StatelessWidget {
  const TeacherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(children: [
      // Positioned.fill(
      //   child: Opacity(
      //     opacity: 0.87,
      //     child: Image.asset(
      //       'assets/images/background_teacher.jpeg',
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      // ),
      Center(
        child: CommonCard(
            width: double.infinity,
            height: 250,
            content: LoginForm(
              targetPath: '/teacher/home',
              type: 'teacher',
              registerPath: '/teacher/register',
            )),
      ),
    ]));
  }
}
