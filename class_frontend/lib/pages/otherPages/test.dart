import 'package:class_frontend/pages/tabs/test_data.dart';
import 'package:class_frontend/utils/colors.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Notice'),
        titleSpacing: 1,
        backgroundColor:  backGroundColor,
        elevation: 3,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[TestData() ]
      )
    );
  }
}