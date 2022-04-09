import 'package:flutter/cupertino.dart';

import '../model/course_model.dart';

class CourseProvider extends ChangeNotifier{
  var userCourses = [
    Course('철학이란 무엇인가'),
    Course('객체지향 프로그래밍'),
    Course('형식 논리학'),
    Course('자료구조'),
  ];

  CourseProvider();
}