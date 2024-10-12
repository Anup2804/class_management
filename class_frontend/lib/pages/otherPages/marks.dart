import 'package:class_frontend/pages/tabs/marks_data.dart';
import 'package:class_frontend/utils/colors.dart';
import 'package:flutter/material.dart';

class MarksPage extends StatelessWidget {
  const MarksPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marks'),
        titleSpacing: 1,
        backgroundColor:  backGroundColor,
        elevation: 3,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[MarksData()]
      )
    );
  }
}