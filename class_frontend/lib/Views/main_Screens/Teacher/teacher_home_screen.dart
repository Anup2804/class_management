import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome teacher'),
        elevation: 1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Row(
                children: [
                  Text(
                    'Upload Section',
                    style: mediumBody,
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/teacher/upload/test');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/test.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text(
                    'Upload Test',
                    style: smallBody,
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/student/home/marks');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/exam.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text(
                    'Upload Marks',
                    style: smallBody,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/student/home/note');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/notes.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text('notes', style: smallBody)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Row(
                children: [
                  Text(
                    'View Section',
                    style: mediumBody,
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/teacher/view/lecture');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/lecture.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text(
                    'View Lectures',
                    style: smallBody,
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/student/home/marks');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/exam.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text(
                    'View Marks',
                    style: smallBody,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/student/home/note');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/notes.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text('View notes', style: smallBody)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/student/home/test');
                      },
                      child: CommonCard(
                        content: Image.asset('assets/icons/test.png'),
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text('View Test', style: smallBody)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
