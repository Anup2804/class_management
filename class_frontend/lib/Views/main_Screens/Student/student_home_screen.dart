import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/card.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome'),
        elevation: 1,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/student/home/lecture');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/lecture.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text('Lecture',style: smallBody,)
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
                  Text('Marks',style: smallBody)
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
                  Text('notes',style: smallBody)
                ],
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '');
                    },
                    child: CommonCard(
                      content: Image.asset('assets/icons/pay.png'),
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Text("pay",style: smallBody)
                ],
              ),
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
                  Text('Test',style: smallBody)
                ],
              ),
              
            ],
          ),
        ],
      )),
    );
  }
}
