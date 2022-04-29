import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ntp/ntp.dart';
class QrGenerator extends StatefulWidget {
  const QrGenerator({Key key}) : super(key: key);
  @override
  _QrGeneratorState createState() => _QrGeneratorState();
}
class _QrGeneratorState extends State<QrGenerator> {
  Timer timer;
  DateTime ntpTime = DateTime.now();
  @override
  void initState() {
    super.initState();
    loadNTPTime();
     timer = Timer.periodic(Duration(seconds: 5), (Timer t) => loadNTPTime());
  }
  void loadNTPTime() async {
    DateTime time2= await NTP.now();
    setState(()  {          
    ntpTime = time2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Generator Page'),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.black12,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ntpTime.toLocal().toString(),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                    fontSize: 28, ),
                ),
                SizedBox(height: 30),
                QrImage(
                  data: ntpTime.toLocal().toString(), size: 200,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: Center(
                        child: Text(
                          "Uh oh! Something went wrong...", textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Text('Please Scan Within 5 Sec', maxLines: 3, ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
