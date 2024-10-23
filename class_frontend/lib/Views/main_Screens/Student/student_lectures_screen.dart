import 'package:class_frontend/Views/common_Widgets/displayCard.dart';
import 'package:flutter/material.dart';

class StudentLecture extends StatelessWidget {
  const StudentLecture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lecture"),
          elevation: 1,
          titleSpacing: 2,
        ),
        body: Column(
          children: [
            Expanded(child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
              return DisplayCard(
              title: 'maths',
              date: '20-12-24',
              time: '4pm',
              description: 'only for 10th',
              byTeacher: 'mona miss',
              colors1: Colors.green[200],
              colors2: Colors.green[100],
            );
            },))
          ],
        ));
  }
}
