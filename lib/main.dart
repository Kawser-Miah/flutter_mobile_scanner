import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'coseries.com',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Coseries'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 350,
          width: 350,
          child: MobileScanner(
              controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  print(barcode.rawValue ?? "No Data found in QR");
                }
                if (image != null) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("QR Code Details: ${barcodes.first.rawValue}" ??
                                "No Data found in QR"),
                            content: Image(image: MemoryImage(image)),
                          ));
                }
              }),
        ),
      ),
    );
  }
}
