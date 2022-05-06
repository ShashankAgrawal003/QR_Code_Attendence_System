
class AttendanceRecords {
  static Map totalLectureHeld={"BCSE 0905":0, "BMEO 0001":0};
  static String subjectCodeFaculty="BCSE 0905";
  static String subjectCodeStudent="BMEO 0001";

  static Map noofLectureAttended={"BCSE 0905":0, "BMEO 0001":0};
  // AttendanceRecords({this.totalLectureHeld,this.noofLectureAttended});

  void markedAttendance(){
    noofLectureAttended[subjectCodeStudent]+=1;
  }

  void lectureheld(){
    totalLectureHeld[subjectCodeFaculty]+=1;
  }

  void getSubjectCodeFaculty(String subcode){
    subjectCodeFaculty=subcode;
  }

  void getSubjectCodeStudent(String subcode){
    subjectCodeStudent=subcode;

  }

}
