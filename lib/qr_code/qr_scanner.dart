import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/The%20owner/ownerLogin.dart';
import 'package:myapp/qr_code/result_screen.dart';

const bgColor = Colors.white;

class Qr_scanner extends StatefulWidget {
  const Qr_scanner({super.key});

  @override
  State<Qr_scanner> createState() => _Qr_scannerState();
}

class _Qr_scannerState extends State<Qr_scanner> {
  bool isScanCompleted = false;

  void closeScreeen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "QR Scanner",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 6, 251, 165),
      ),
      backgroundColor: bgColor,
      drawer: Drawer(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place the QR code in the area.",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scanning will be started automatically",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: MobileScanner(
                  onDetect: (BarcodeCapture) {
                    if (isScanCompleted) {
                      String code = BarcodeCapture.raw ?? '---';
                      isScanCompleted = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            closeScreen: closeScreeen,
                            code: code,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Developed by sathsara",
                    style: TextStyle(
                        color: Colors.black, fontSize: 14, letterSpacing: 1),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlueAccent)),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ownerLogin()));
                    },
                    child: Text("Back")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
