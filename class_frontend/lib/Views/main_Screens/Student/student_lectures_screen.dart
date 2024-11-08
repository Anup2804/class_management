import 'package:class_frontend/Services/Providers/lecture.provider.dart';
import 'package:class_frontend/Views/common_Widgets/displayCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentLecture extends StatefulWidget {
  const StudentLecture({super.key});

  @override
  State<StudentLecture> createState() => _StudentLectureState();
}

class _StudentLectureState extends State<StudentLecture> {
   @override
  void initState() {
    super.initState();
    // Fetch test details on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LectureProvider>(context, listen: false).fetchLectureNotice();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lecture"),
          elevation: 1,
          titleSpacing: 2,
        ),
        body:
        // Column(
        //   children: [
        //     Expanded(child: ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: 5,
        //       itemBuilder: (context, index) {
        //       return DisplayCard(
        //       title: 'maths',
        //       date: '20-12-24',
        //       time: '4pm',
        //       description: 'only for 10th',
        //       chapterNo: '10',
        //       byTeacher: 'mona miss',
        //       colors1: Colors.green[200],
        //       colors2: Colors.green[100],
        //     );
        //     },))
        //   ],
        // )
        Consumer<LectureProvider>( 
          builder:(context, lecture, child) {
          final lectureData = lecture.lectureNotice;

          if (lectureData == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lectureData.data.length,
                  itemBuilder: (context, index) {
                    final item = lectureData.data[index];
                    return DisplayCard(
                      title: item.lectureName,
                      date: item.date,
                      time: item.time,
                      chapterNo: '0',
                      description: item.description ?? 'No description',
                      byTeacher: item.byTeacher?.name,
                    );
                  },
                ),
              ),
            ],
          );
        },
        ),
        );
  }
}
