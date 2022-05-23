import 'package:lupin_app/src/model/user_model.dart';

class Course {
  int id;
  String name;
  String courseId;
  String? openingTime;
  String? closingTime;
  User professor;

  Course(this.id, this.name, this.courseId, this.openingTime, this.closingTime,
      this.professor);

  @override
  String toString() {
    return 'Course{id: $id, name: $name, classId: $courseId, openingTime: $openingTime, closingTime: $closingTime, professor: $professor}';
  }
}
