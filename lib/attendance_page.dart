import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qr_code_attendence_system/attendance_records.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key key}) : super(key: key);
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  Map leturesheld = {"BCSE 0905":0, "BMEO 0001":0};
  Map attendedletures = {"BCSE 0905":0, "BMEO 0001":0};
  double percentage = 0.93;
  @override
  void initState() {
    super.initState();
    attendance();
  }

  void attendance() {
    setState(() {
      if (AttendanceRecords.totalLectureHeld != null) // Safe to use otherwise error is thrown
        leturesheld= AttendanceRecords.totalLectureHeld;

      if (AttendanceRecords.noofLectureAttended != null)
        attendedletures = AttendanceRecords.noofLectureAttended;

      // percentage = ((attendedletures / leturesheld) * 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attendance Portal'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        'Shashank Agrawal (181500652)',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'B.Tech. - CS',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                height: 10,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Artificial Intelligence For IIOT',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '(BCSE 0905)',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Faculty :- Ram Manohar Nisarg Ns',
                      style: TextStyle(fontSize: 15, color: Colors.purple),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Total Letures Held:- ${leturesheld['BCSE 0905']}',
                      style: TextStyle(fontSize: 15, color: Colors.teal),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Attended Lecture:- ${attendedletures['BCSE 0905']}',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Container(

                      child: LinearPercentIndicator(
                        width: 325,
                        lineHeight: 20,
                        // percent: percentage != null ? percentage / 100 : 0,
                        percent: attendedletures['BCSE 0905']!=0?(attendedletures['BCSE 0905'] / leturesheld['BCSE 0905']):0 ,
                        center: Text(
                          '${(attendedletures['BCSE 0905']!=0?(attendedletures['BCSE 0905'] / leturesheld['BCSE 0905']):0).toStringAsFixed(2)} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey,
                        animation: true,
                        animationDuration: 3000,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Quality Management',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '(BMEO 0001)',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Faculty :- Manoj Kumar Agrawal',
                      style: TextStyle(fontSize: 15, color: Colors.purple),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Total Letures Held:- ${leturesheld['BMEO 0001']}',
                      style: TextStyle(fontSize: 15, color: Colors.teal),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Attended Lecture:- ${attendedletures['BMEO 0001']}',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Container(
                      child: LinearPercentIndicator(
                        width: 325,
                        lineHeight: 20,
                        percent: attendedletures['BMEO 0001']!=0?(attendedletures['BMEO 0001'] / leturesheld['BMEO 0001']):0 ,
                        center: Text(
                            '${(attendedletures['BMEO 0001']!=0?(attendedletures['BMEO 0001'] / leturesheld['BMEO 0001']):0).toStringAsFixed(2)} %',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey,
                        animation: true,
                        animationDuration: 3000,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
