import 'package:class_frontend/widgets/global/home.card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> icon = [
      CustomIcon(
          imgurl: 'assets/icons/lecture.png',
          scale: 7.5,
          title: 'Lecture',
          onTap: () {
            print('lrcture');
          }),
      CustomIcon(
          imgurl: 'assets/icons/test.png',
          scale: 8.5,
          title: 'Test',
          onTap: () {
            print('test');
          }),
      CustomIcon(
          imgurl: 'assets/icons/notes.png',
          scale: 6,
          title: 'Notes',
          onTap: () {
            print('notes');
          }),
      CustomIcon(
          imgurl: 'assets/icons/exam.png',
          scale: 9,
          title: 'Marks',
          onTap: () {
            print('marks');
          }),
      CustomIcon(
          imgurl: 'assets/icons/pay.png',
          scale: 9,
          title: 'Pay Fees',
          onTap: () {
            print('pay');
          }),
      CustomIcon(
          imgurl: 'assets/icons/exam.png',
          scale: 9,
          title: 'Marks',
          onTap: () {}),
    ];

    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: GridView.builder(
          itemCount: icon.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 2.5),
          itemBuilder: (context, index) {
            return HomeContainer(
              url: icon[index].imgurl,
              scale: icon[index].scale,
              head: icon[index].title,
              tap: icon[index].onTap,
            );
          },
        ),
      ),
    );
  }
}

class CustomIcon {
  final String imgurl;
  final double scale;
  final String title;
  final VoidCallback onTap;

  CustomIcon(
      {required this.imgurl,
      required this.scale,
      required this.title,
      required this.onTap});
}
