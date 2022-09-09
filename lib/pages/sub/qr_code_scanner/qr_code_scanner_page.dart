import "package:flutter/material.dart";
import "package:qr_code_scanner/qr_code_scanner.dart";
import 'package:restaurant_app/pages/base/app_bar.dart';
import "dart:io";
import "dart:math";

import '../../../constants.dart';
import '../../../key_data_constants.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QrCodeScannerPageState createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  final qrKey = GlobalKey(debugLabel: "QR");
  final String targetUrl = appUrl;
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  //Ensures hot reload works on android
  @override
  void reassemble() async {
    super.reassemble();

    if(Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ReturnBottomNavigation(
          child: Text(
            barcode == null ? "Scan QR Code" : "Invalid QR Code!",
            style: TextStyle(
              color: barcode == null ? Palette.darkOne : Palette.red,
              fontSize: FontSize.smallHeader,
            ),
          ),
        ),
        body: QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            cutOutSize: min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) * 0.8,
            borderRadius: 20,
            borderLength: 40,
            borderWidth: 10,
            borderColor: Palette.accent,
            overlayColor: Palette.darkOne.withOpacity(0.2),
          ),
        ),
        /*
        Stack(
          children: [

            /*
            Container(
              alignment: const Alignment(0.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Palette.darkOne,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                    child: Text(
                      barcode == null ? "Scan QR Code" : "Invalid QR Code!",
                      style: const TextStyle(
                        color: Palette.lightOne,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(-1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () { Navigator.pop(context); },
                  backgroundColor: Palette.accent,
                  child: const Icon(Icons.arrow_back, color: Palette.lightOne),
                ),
              ),
            )

             */
          ]
        ),
        */

      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {this.controller = controller;});
    controller.scannedDataStream.listen((newBarcode){
      //Run when scanned QR code is scanned
      setState(() {this.barcode = newBarcode;});
      String url = (newBarcode.code != null) ? newBarcode.code.toString() : "";
      String shortenedUrl = url.substring(0, min(targetUrl.length, newBarcode.code!.length));
      if(shortenedUrl == targetUrl){
        Map<String, String> urlParameters = getParametersFromUrl(url);
        if(urlParameters.containsKey("tableid") && urlParameters.containsKey("seatid") && urlParameters.containsKey("locationid")){
          Navigator.pop(context, urlParameters);
        }
      }
    });
  }

  Map<String, String> getParametersFromUrl(String url) {
    String urlParametersString = url.substring(url.indexOf("?")+1);
    List<String> urlParametersList = urlParametersString.split("&");
    Map<String, String> urlParameters = {};
    for(var parameterString in urlParametersList){
      List<String> keyValue = parameterString.split("=");
      urlParameters[keyValue[0]] = keyValue[1];
    }
    return urlParameters;
  }
}



