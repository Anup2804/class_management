import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadData extends StatefulWidget {
  const DownloadData({super.key});

  @override
  State<DownloadData> createState() => _DownloadDataState();
}

class _DownloadDataState extends State<DownloadData> {
  Dio dio = Dio();
  double progress = 0.0;

  Future<bool> checkPermission() async {
    var status = await Permission.storage.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      // await Permission.storage.request();
      status = await Permission.storage.request();
      return status.isGranted;
    }
    return status.isGranted;
  }

  void startdownloading() async {
    const String url =
        "https://images.pexels.com/photos/28186188/pexels-photo-28186188/free-photo-of-a-woman-with-an-umbrella-standing-on-the-street.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

    const fileName = "girl.jpg";

    String path = await _getFlilePath(fileName);

    if (await checkPermission()) {
      try {
        await dio.download(
          url,
          path,
          onReceiveProgress: (count, total) {
            setState(() {
              progress = count / total;
            });
            print(progress);
          },
          deleteOnError: true,
        ).then((_) {
          Navigator.pop(context);
        });
      } catch (e) {
        print("Error during download: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Download failed")),
        );
      }
    }
  }

  Future<String> _getFlilePath(filename) async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    print("${directory?.path}/$filename");
    return "${directory?.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startdownloading();
  }

  @override
  Widget build(BuildContext context) {
    // steps
    // 1. check permission is granted or not.
    // 2. if not request for the permission.
    // 3. download the file from the url.
    // 4. display the status and alert when the file download the done.
    // 5. verify that file is downloaded or not.

    String downloadProgress = (progress * 100).toInt().toString();
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(
            height: 20,
          ),
          Text(
            'downloading:$downloadProgress',
            style: TextStyle(color: Colors.white, fontSize: 17),
          )
        ],
      ),
    );
  }
}
