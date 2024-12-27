import 'package:class_frontend/Views/common_Widgets/download_file.dart';
import 'package:flutter/material.dart';

class StudentMarks extends StatelessWidget {
  const StudentMarks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Marks"),
          elevation: 1,
          titleSpacing: 2,
        ),
        body: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DownloadData(),
                  ));
            },
            child: Text('click to download')));
  }
}


