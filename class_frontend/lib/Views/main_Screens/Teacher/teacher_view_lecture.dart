import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/displayCard.dart';
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
        title: Text(
          'View Lecture',
          style: mediumBody,
        ),
        titleSpacing: 0,
        elevation: 1,
      ),
      body: Container(
        height: 250,
        child: Column(
          children: [
            DisplayCard(
                title: 'maths',
                date: '12 dec',
                time: '4pm',
                description: 'hello',
                chapterNo: '10'),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, '/teacher/takeattendence');
                  }, child: Text('Take attendence')))
          ],
        ),
      ),
    );
  }
}
