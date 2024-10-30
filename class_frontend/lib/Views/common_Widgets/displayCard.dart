import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';

class DisplayCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String description;
  final String byTeacher;
  final Color? colors1;
  final Color? colors2;

  const DisplayCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    this.colors1,
    this.colors2, 
    required this.byTeacher,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Increase elevation for a stronger shadow
      shadowColor: Colors.grey.withOpacity(0.5), // Set shadow color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors1 ?? Colors.red[300]!,
              colors2 ?? Colors.red[200]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: largeBody),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: $date', style: smallBody),
                      Text('Time: $time', style: smallBody),
                      Text('ByTeacher: $byTeacher',style: smallBody,)
                    ],
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: mediumBody,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
