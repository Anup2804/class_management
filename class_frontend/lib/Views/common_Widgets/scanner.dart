import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

String? adminData;

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  void _onScan(BarcodeCapture capture) {
    final barcode = capture.barcodes.first;

    if (barcode.rawValue != null) {
      adminData = barcode.rawValue;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('error in scanning')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        onDetect: _onScan,
      ),
    );
  }
}
