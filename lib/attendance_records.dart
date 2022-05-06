class AttendanceRecords {
  static int totalLectureHeld=0;
  static int noofLectureAttended=0;
  // AttendanceRecords({this.totalLectureHeld,this.noofLectureAttended});
  void markedAttendance(){

    noofLectureAttended+=1;
  }
  void lectureheld(){
    totalLectureHeld+=1;
  }



}
