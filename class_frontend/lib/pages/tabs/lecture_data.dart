import 'package:class_frontend/services/provider/lecture.provider.dart';
import 'package:class_frontend/widgets/global/data.card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureData extends StatelessWidget {
  const LectureData({super.key});

  @override
  Widget build(BuildContext context) {
   // Accessing the LectureProvider to fetch lectures
    final lectureProvider = Provider.of<LectureProvider>(context, listen: false);

    // Fetch the lectures when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      lectureProvider.fetchLectures();
    });

    return Consumer<LectureProvider>(
      builder: (context, lectureProvider, child) {
        if (lectureProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (lectureProvider.lectures.isEmpty) {
          return Center(child: Text('No lectures available'));
        }

        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: lectureProvider.lectures.length,
            itemBuilder: (context, index) {
              final lecture = lectureProvider.lectures[index];
              return DataCard( lecture);
            },
          ),
        );
      },
    );
    
  }
}