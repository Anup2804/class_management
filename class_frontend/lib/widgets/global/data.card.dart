import 'package:class_frontend/services/models/lecture.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataCard extends StatelessWidget {
  final Lecture lecture;
  const DataCard(this.lecture, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isToday = lecture.date == DateFormat('yyyy-MM-dd').format(DateTime.now());
    print(DateFormat('yyyy-MM-dd').format(DateTime.now()));

    return Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: isToday
                ? Colors.green.withOpacity(.25)
                : Colors.yellow.withOpacity(.25),
            border: Border.all(
                color: isToday ? Colors.green : Colors.yellow, width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Lecture :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(lecture.lectureName,
                      style: Theme.of(context).textTheme.displayMedium)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    'Time :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(' ${lecture.time}',
                      style: Theme.of(context).textTheme.displayMedium)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    'Standard :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(' ${lecture.standard}',
                      style: Theme.of(context).textTheme.displayMedium)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    'ByTeacher :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(' ${lecture.teacherName}',
                      style: Theme.of(context).textTheme.displayMedium)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    'Date :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(
                    ' ${lecture.date}',
                    style: Theme.of(context).textTheme.displayMedium,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
            ],
          ),
        ));
  }
}