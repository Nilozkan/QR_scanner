import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ResultScreen({super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            closeScreen();
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87,)),
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
      body: Padding(padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          //Show QR code in here
          QrImage(
            data: code,
            size: 150,
            version: QrVersions.auto,
          ),

       const Text(
        "Scanned result",
         style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )
        ),
       const SizedBox(
          height: 10,
        ),
         Text(
        code,
         style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            letterSpacing: 1,
          )
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width-100,
          height: 48,
          child: ElevatedButton(
            onPressed: () {}, child: const Text(
          "Copy",
           style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              letterSpacing: 1,
            )
          ),),
        )
      ]),),
    );
  }
}