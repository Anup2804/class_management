import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  String? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single.name;
        print(result); // Display the file name
        print('${_selectedFile}');
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedFile ?? "No file selected",
            style: TextStyle(fontSize: 16),
          ),
          // print(_selectedFile);
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _pickFile,
            icon: Icon(Icons.attach_file),
            label: Text('Pick a file'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
