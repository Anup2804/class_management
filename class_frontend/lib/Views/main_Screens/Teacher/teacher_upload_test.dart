import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Views/common_Widgets/form.dart';
import 'package:flutter/material.dart';

class UploadTest extends StatelessWidget {
  const UploadTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Test',style: mediumHeadline,),
        titleSpacing: 0,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DataForm(),
            ],
          ),
        ),
      ),
    );
  }
}