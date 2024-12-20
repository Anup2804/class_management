import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Models/test_model.dart';
import 'package:class_frontend/Services/Providers/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    Future<void> _uploadTest() async {
      final testProvider = Provider.of<TestProvider>(context, listen: false);

      final TestData tests = TestData(
          subjectName: _subjectName.text,
          standard: _standard.text,
          time: _time.text,
          date: _date.text,
          board: _board.text.toUpperCase(),
          chapterNo: _chapterNo.text,
          description: _description.text
          );

      try {
        await testProvider.postTestDetails(tests);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test Notice uploaded successfully!')),
        );
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' $err')),
        );
      }
    }

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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Subjct name is required';
                  }
                  return null;
                },
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Stadard is required';
                  }
                  return null;
                },
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Chapter No is required';
                  }
                  return null;
                },
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Boards is required';
                  }
                  return null;
                },
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'time is required';
                  }
                  return null;
                },
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Date is required';
                  }
                  return null;
                },
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
                      _uploadTest();
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
