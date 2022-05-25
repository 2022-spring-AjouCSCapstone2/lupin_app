import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/model/my_courses_model.dart';

class CourseProvider extends ChangeNotifier {
  MyCourses? userCourses;
  MyCourses? todayCourses;

  CourseProvider();

  Future<MyCourses?> getUserAllCourses() async {
    MyCourses courses = await Apis.instance.getMyAllCourses();
    userCourses = courses;
    return userCourses;
  }

  Future<MyCourses?> getTodayCourses() async {
    MyCourses courses = await Apis.instance.getMyTodayCourses();
    todayCourses = courses;
    return todayCourses;
  }
}
