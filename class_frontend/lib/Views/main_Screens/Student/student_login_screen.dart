import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:class_frontend/Views/common_Widgets/login_form.dart';
import 'package:flutter/material.dart';

class StudentLogin extends StatelessWidget {
  const StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Center(
          child: CommonCard(
            width: double.infinity,
            height: 250,
            content: LoginForm(targetPath: '/student/home',type: 'student',)
          ),
        ));
  }
}
