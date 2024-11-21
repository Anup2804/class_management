import 'package:class_frontend/Constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  String? _selectedFile;
  final _key = GlobalKey<FormState>();
  final TextEditingController _subjectName = TextEditingController();
  final TextEditingController _chapterNo = TextEditingController();
  final TextEditingController _standard = TextEditingController();
  final TextEditingController _boards = TextEditingController();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
        print(result);
        print('${_selectedFile}');
      });
    } else {
      _selectedFile = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        )
                      ],
                    ))),
            ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('upload done')));
                  }
                },
                child: Text('Upload Data'))
          ],
        ),
      ),
    );
  }
}
