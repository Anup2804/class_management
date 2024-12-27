import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanCode extends StatefulWidget {
  const ScanCode({super.key});

  @override
  State<ScanCode> createState() => _ScanCodeState();
}

class _ScanCodeState extends State<ScanCode> {
  String? qrCodeResult;
  Result? currentResult;
  final QRCodeDartScanController _controller = QRCodeDartScanController();
  Future<bool> checkPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      await Permission.camera.request();
      status = await Permission.camera.status;
      return status.isGranted;
    }
    return status.isGranted;
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: QRCodeDartScanView(
        controller: _controller,
        scanInvertedQRCode: true,
        typeScan: TypeScan.live,
        intervalScan: Duration(seconds: 3),
        onCapture: (value) {
          qrCodeResult = value.text;
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('isLive: ${_controller.isLiveScan}'),
                Text('Text: ${currentResult?.text ?? 'Not found'}'),
                Text('Format: ${currentResult?.barcodeFormat ?? 'Not found'}'),
                ElevatedButton(
                  onPressed: () async {
                    _controller.changeCamera(
                      _controller.state.value.typeCamera == TypeCamera.front
                          ? TypeCamera.back
                          : TypeCamera.front,
                    );
                  },
                  child: const Text('Change cam'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.isLiveScan) {
                      await _controller.stopScan();
                      currentResult = null;
                    } else {
                      await _controller.startScan();
                    }
                    setState(() {});
                  },
                  child: Text(
                    _controller.isLiveScan ? 'Stop scan' : 'Start scan',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
