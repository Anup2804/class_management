import 'package:class_frontend/Views/common_Widgets/displayCard.dart';
import 'package:flutter/material.dart';

class StudentTest extends StatelessWidget {
  const StudentTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
          elevation: 1,
          titleSpacing: 2,
        ),
        body: Column(
          children: [
            Expanded(child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return DisplayCard(
                    title: 'Maths Test',
                    date: '20-12-24',
                    time: '8pm',
                    description: 'be prepare',
                    byTeacher: 'shivam sir');
              },
            ))
          ],
        ));
  }
}
