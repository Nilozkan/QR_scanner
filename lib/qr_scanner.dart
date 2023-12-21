import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/result_screen.dart';
const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted =false;

  void closeScreen() {
    isScanCompleted = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
        "QR Scanner",
         style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Plaace the QR code in the area",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                   )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Scanning will be starting automatically",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),),
                ],
              )),
          
              Expanded(child: Container(child: const Text(
                "Developed by Nil Ozkan",
                 style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                   )
                ),)),
              ]
              ),
      ),
    );
  }
}
