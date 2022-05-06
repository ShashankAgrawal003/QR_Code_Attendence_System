import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_attendence_system/attendance_records.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ntp/ntp.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key key}) : super(key: key);
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode barcode;
  int threshold = 10; // 10 sec threshold
  DateTime ntpScanTime = DateTime.now();
  bool flag = true;

  String finalText = 'Scan QR Code';

  @override
  void initState() {
    super.initState();

    //loadNTPTime();  // ye pahle commented the
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void loadNTPTime() async {
    DateTime time2 = await NTP.now();
    setState(() {
      // async
      // ntpTime = await NTP.now();
      ntpScanTime = time2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanner Page'),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),

            Positioned(bottom: 10, child: buildResult()), // result method
          ],
        ),
      ),
    );
  }

  Widget buildResult() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Text(
        finalText,
        maxLines: 3,
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQrViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 10,
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 20,
        ),
      );
  void onQrViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (qrbarcode) => setState(() {
        print(qrbarcode.code);
        barcode = qrbarcode;
        fun();
      }),
    );
  }

  void fun() {

    loadNTPTime();
    List barstr=barcode.code.split(',');
    String barfacsub=barstr[1];

    DateTime timeOfGen = DateTime.parse(barstr[0]);


    final difference = ntpScanTime.difference(timeOfGen).inSeconds;
    if ((difference <= threshold) && (barfacsub==AttendanceRecords.subjectCodeStudent)) {
      setState(() {
        finalText =
            'Your Attendence Marked Successfully Time: ' + '$difference';

        if (flag) {
          flag = false;
          var ref = AttendanceRecords();
          ref.markedAttendance();
        }
      });
      Future.delayed(Duration(seconds: 1),(){
        Navigator.popAndPushNamed(context, '/AttendancePage');
      });

    } else {
      setState(() {
        finalText = 'Not A Valid QR Code: ' + '$difference';
      });
    }
  }
}
