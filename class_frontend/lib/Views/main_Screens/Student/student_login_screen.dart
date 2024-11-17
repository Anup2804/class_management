import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:class_frontend/Views/common_Widgets/login_form.dart';
import 'package:flutter/material.dart';

class StudentLogin extends StatelessWidget {
  const StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children:[ 

            Positioned.fill(
            child: Opacity(
               opacity: 0.87,
              child: Image.asset(
                'assets/images/background_student.webp',
              
                fit: BoxFit.cover,
              ),
            ),
          ),
            
            Center(
            child: CommonCard(
              width: double.infinity,
              height: 250,
              content: LoginForm(targetPath: '/student/home',type: 'student',registerPath: '/student/register',)
            ),
          ),]
        ),
        );
  }
}
