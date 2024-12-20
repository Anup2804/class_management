import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/upload_form.dart';
import 'package:flutter/material.dart';

class UploadMarks extends StatelessWidget {
  const UploadMarks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Test',
          style: mediumHeadline,
        ),
        titleSpacing: 0,
        elevation: 1,
      ),
      body: SafeArea(child: SingleChildScrollView(child: UploadForm())),
    );
  }
}
