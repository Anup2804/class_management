import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';

class ViewLecture extends StatefulWidget {
  const ViewLecture({super.key});

  @override
  State<ViewLecture> createState() => _ViewLectureState();
}

class _ViewLectureState extends State<ViewLecture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('View Lecture',style: mediumBody,),
        titleSpacing: 0,
        elevation: 1,
      ),
      body: Text('view lecture'),
    );
  }
}