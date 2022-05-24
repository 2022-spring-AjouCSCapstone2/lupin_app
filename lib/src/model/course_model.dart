import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/model/user_model.dart';

class Course {
  int id;
  String name;
  String courseId;
  String? openingTime;
  String? closingTime;
  User professor;
  List<TimeTable> timeTables;

  Course(this.id, this.name, this.courseId, this.openingTime, this.closingTime,
      this.professor, this.timeTables);

  @override
  String toString() {
    return 'Course{id: $id, name: $name, courseId: $courseId, openingTime: $openingTime, closingTime: $closingTime, professor: $professor, timeTables: $timeTables}';
  }
}
