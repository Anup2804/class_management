import 'dart:io';

import 'package:class_frontend/Constants/fonts.dart';
import 'package:class_frontend/Models/marks_model.dart';
import 'package:class_frontend/Services/Providers/marks_provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  String? _selectedFile;
  File? filepath;

  final _key = GlobalKey<FormState>();
  final TextEditingController _subjectName = TextEditingController();
  final TextEditingController _chapterNo = TextEditingController();
  final TextEditingController _standard = TextEditingController();
  final TextEditingController _boards = TextEditingController();

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png']);

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          filepath = File(result.files.single.path!);
          _selectedFile = result.files.single.name;
        });
        print(filepath?.path);
      }
    } else {
      setState(() {
        filepath = null;
      });
    }
  }

  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
      return true;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }



  Future<void> _onsubmitData() async {
    final marksProvider = Provider.of<MarksProvider>(context, listen: false);

    final mark = MarksData(
      subjectName: _subjectName.text,
      board: _boards.text,
      chapterNo: _chapterNo.text,
      standard: _standard.text,
      file: filepath!.path.toString(),
    );

    try {
      await marksProvider.uploadMarks(mark, filepath!.path.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload Marks succesfully')));
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$err')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(7.0),
            child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _subjectName,
                      cursorHeight: 22,
                      style: mediumBody,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'subject name is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            'Subject Name',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _chapterNo,
                      cursorHeight: 22,
                      style: mediumBody,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'chapter no is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            'Chapter No',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _standard,
                      cursorHeight: 22,
                      style: mediumBody,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'standard is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            'Standard',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _boards,
                      cursorHeight: 22,
                      style: mediumBody,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'boards is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            'Boards',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Select a File",
                        hintText: _selectedFile,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed:(){
                            _pickFile();
                            isInternetAvailable();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ))),
        ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                _onsubmitData();
              }
            },
            child: Text('Upload Data'))
      ],
    );
  }
}
