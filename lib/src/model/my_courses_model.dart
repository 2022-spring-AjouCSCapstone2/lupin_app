import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/user_model.dart';

class MyCourses {
  List<Course> courses;

  MyCourses(this.courses);

  factory MyCourses.fromJson(List jsonData) {
    List<Course> courses = [];

    for (var i in jsonData) {
      Map<String, dynamic> userMap = i['professor'];
      courses.add(Course(
        i['id'],
        i['name'],
        i['courseId'],
        i['openingTime'],
        i['closingTime'],
        User.fromJson(userMap),
      ));
    }
    return MyCourses(courses);
  }

  @override
  String toString() {
    return 'MyCourses{courses: $courses}';
  }
}
