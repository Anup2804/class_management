import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class MarksData extends StatelessWidget {
  // final String fileUrl;  // URL of the file to be displayed or downloaded
  // final String fileName; // Name of the file to show in the UI

  // MarksData({
  //   required this.fileUrl,
  //   required this.fileName,
  // });

  // Method to handle the file download
  // Future<void> _downloadFile() async {
  //   final Uri _url = Uri.parse(fileUrl);
  //   if (!await launchUrl(_url)) {
  //     throw 'Could not launch $_url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Display and Download'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the file name
              Text(
                'File: ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              
              // Display an icon indicating a file
              Icon(
                Icons.insert_drive_file,
                size: 100,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              
              // Button to download the file
              ElevatedButton.icon(
                onPressed:(){} ,
                icon: Icon(Icons.download),
                label: Text('Download File'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
