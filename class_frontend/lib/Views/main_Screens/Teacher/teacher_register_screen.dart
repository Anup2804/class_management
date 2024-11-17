import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:class_frontend/Views/common_Widgets/register_form.dart';
import 'package:flutter/material.dart';

class TeacherRegister extends StatelessWidget {
  const TeacherRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: CommonCard(
            content: RegisterForm(
              type: 'teacher',
            ),
            width: double.infinity,
            height: 685,
          ),
        ),
      ),
    );
  }
}