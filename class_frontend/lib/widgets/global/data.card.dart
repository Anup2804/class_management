import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.green.withOpacity(.25),
            border: Border.all(color: Colors.green, width: 3),
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
                  Text(' Maths',
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
                  Text(' 7.00pm',
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
                  Text(' 10th',
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
                  Text(' Anup Sir',
                      style: Theme.of(context).textTheme.displayMedium)
                ],
              )
            ],
          ),
        ));
  }
}
