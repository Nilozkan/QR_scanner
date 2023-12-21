import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool scannerStarted = false;
  bool isScanCompleted = false;
  late MobileScannerController _mobileScannerController;
  String willShowText = "Scanning...";
  late BarcodeCapture _barcodeCapture;

  @override
  void initState() {
    super.initState();
    _mobileScannerController = MobileScannerController();
    // _mobileScannerController = MobileScannerController(
    //   autoStart: true,
    //   cameraResolution: const Size(720, 1280),
    //   detectionSpeed: DetectionSpeed.normal,
    //   torchEnabled: false,
    //   detectionTimeoutMs: 1200,
    //   facing: CameraFacing.back,
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _mobileScannerController.dispose();
  }

  void closeScreen() {
    isScanCompleted = false;
  }

  void handleOnDetect(BarcodeCapture capture) {
    if (capture.barcodes.first.type == BarcodeType.url) {
      launchUrl(Uri.parse(capture.barcodes.first.url!.url));
      setState(() {
        willShowText = capture.barcodes.first.url!.url;
      });
    }
  }

  Widget errorBuilder = Container(
    width: double.maxFinite,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.black,
          ),
          Text(
            "Error",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                willShowText = "Scanning...";
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
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
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be starting automatically",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              child: Builder(builder: (context) {
                if (_mobileScannerController.isStarting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MobileScanner(
                  errorBuilder: (context, error, widget) => errorBuilder,
                  fit: BoxFit.cover,
                  onDetect: (capture) => handleOnDetect(capture),
                  onScannerStarted: (scannerArguments) {
                    setState(() {
                      scannerStarted = true;
                    });
                  },
                );
              }),
            ),
            Text(
              willShowText,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Expanded(
              child: SizedBox(
                child: Text(
                  "Developed by Nil Ozkan",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
