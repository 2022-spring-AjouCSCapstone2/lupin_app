import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/model/course_note_model.dart';

class NoteProvider extends ChangeNotifier {
  Notes? noteCourse;

  NoteProvider();

  Future<Notes?> getNote(courseId, day) async {
    Notes notes = await Apis.instance.getNote(courseId, day);
    noteCourse = notes;
    return noteCourse;
  }

}
