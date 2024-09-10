import 'package:class_frontend/services/models/test.model.dart';
import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final Test test;
  const TestCard( {super.key,required this.test});

  @override
  Widget build(BuildContext context) {
    bool isToday = test.date == DateTime.now();


    return Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: isToday ? Colors.green.withOpacity(.25) : Colors.yellow.withOpacity(.25),
            border: Border.all(color: isToday ? Colors.green : Colors.yellow, width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Subject Name :',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(' ${test.subjectName}',
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
                  Text(' ${test.time}',
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
                  Text(' ${test.standard}',
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
                  Text(' ${test.teacherName}',
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
                  Text(' ${test.date}',
                      style: Theme.of(context).textTheme.displayMedium,softWrap: true,overflow: TextOverflow.ellipsis, )
                ],
              )
            ],
          ),
        ));
  }
}
