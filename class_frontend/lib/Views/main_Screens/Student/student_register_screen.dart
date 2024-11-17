import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:class_frontend/Views/common_Widgets/register_form.dart';
import 'package:flutter/material.dart';

class StudentRegister extends StatelessWidget {
  const StudentRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: CommonCard(
            content: RegisterForm(
              type: 'student',
            ),
            width: double.infinity,
            height: 685,
          ),
        ),
      ),
    );
  }
}
