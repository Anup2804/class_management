import 'package:flutter/material.dart';

class StudentNotes extends StatelessWidget {
  const StudentNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        elevation: 1,
        titleSpacing: 2,),
      body: Text('')
    );
  }
}