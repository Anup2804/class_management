import 'package:class_frontend/Services/Providers/test_provider.dart';
import 'package:class_frontend/Views/common_Widgets/displayCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentTest extends StatefulWidget {
  const StudentTest({super.key});

  @override
  State<StudentTest> createState() => _StudentTestState();
}

class _StudentTestState extends State<StudentTest> {
   @override
  void initState() {
    super.initState();
    // Fetch test details on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestProvider>(context, listen: false).fetchTestDetails();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
          elevation: 1,
          titleSpacing: 2,
        ),
        body:Consumer<TestProvider>( 
          builder:(context, testProvider, child) {
          final testData = testProvider.testNotice;

          if (testData == null) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: testData.data.length,
                  itemBuilder: (context, index) {
                    final item = testData.data[index];
                    return DisplayCard(
                      title: item.subjectName,
                      date: item.date,
                      time: item.time,
                      chapterNo: item.chapterNo,
                      description: item.description ?? 'No description',
                      byTeacher: item.byTeacher?.name,
                    );
                  },
                ),
              ),
            ],
          );
        },
        ),
      );
  }
}
