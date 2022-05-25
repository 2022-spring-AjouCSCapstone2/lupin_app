import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/model/user_model.dart';

class MyCourses {
  List<Course> courses;

  MyCourses(this.courses);

  factory MyCourses.fromJson(List jsonData) {
    List<Course> courses = [];

    for (var i in jsonData) {
      Map<String, dynamic> userMap = i['professor'];

      List timeTablesList = i['timetables'];

      List<TimeTable> timetables = [];
      for (var i in timeTablesList) {
        timetables.add(TimeTable.fromJson(i));
      }

      courses.add(
        Course(
          i['id'],
          i['name'],
          i['courseId'],
          i['openingTime'],
          i['closingTime'],
          User.fromJson(userMap),
          timetables,
        ),
      );
    }
    return MyCourses(courses);
  }

  @override
  String toString() {
    return 'MyCourses{courses: $courses}';
  }
}
