import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({super.key});

  @override
  State<QRGenerator> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  String data = "This is a simple  QR code";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  // width: 200.0,
                  // height: 300.0,
                  child: QrImageView(
                    data: data,
                    version: QrVersions.auto,
                    backgroundColor: Color.fromARGB(255, 60, 56, 56),
                    size: 100.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
