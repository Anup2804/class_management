import 'package:class_frontend/widgets/global/data.card.dart';
import 'package:flutter/material.dart';

class LectureData extends StatelessWidget {
  const LectureData({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return DataCard();
      },
      ),
    );
  }
}