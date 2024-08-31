import 'package:class_frontend/pages/tabs/lecture_data.dart';
import 'package:flutter/material.dart';

class LectureScreen extends StatelessWidget {
  const LectureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Notice'),
        titleSpacing: 1,
      ),
      body: SizedBox(
        child: LectureData(),
      )
      );
    
  }
}
