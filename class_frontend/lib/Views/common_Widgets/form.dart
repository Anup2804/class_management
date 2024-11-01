import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';

class DataForm extends StatelessWidget {
  const DataForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final TextEditingController _subjectName = TextEditingController();
    final TextEditingController _chapterNo = TextEditingController();
    final TextEditingController _standard = TextEditingController();
    final TextEditingController _time = TextEditingController();
    final TextEditingController _board = TextEditingController();
    final TextEditingController _date = TextEditingController();
    final TextEditingController _description = TextEditingController();
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _subjectName,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Subject Name',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _standard,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Standard',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _chapterNo,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Chapter Number',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _board,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'boards',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _time,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Time',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _date,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Date',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _description,
                cursorHeight: 22,
                cursorWidth: 1.5,
                style: smallBody,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    label: Text(
                      'Description',
                      style: mediumBody,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('upload done')));
                    }
                  },
                  child: Text(
                    "upload Test",
                    style: mediumBody,
                  ))
            ],
          ),
        ));
  }
}
