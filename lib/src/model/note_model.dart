import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/course_note_model.dart';

class Note_Course{
  int id;
  String name;
  String courseId;
  String? openingTime;
  String? closingTime;

  Note_Course(this.id, this.name, this.courseId, this.openingTime, this.closingTime);

  @override
  String toString() {
    return 'Note_Course{id: $id, name: $name, courseId: $courseId, openingTime: $openingTime, closingTime: $closingTime}';
  }

  factory Note_Course.fromJson(Map<String, dynamic> json) {
    return Note_Course(
      json['id'],
      json['name'],
      json['courseId'],
      json['openingTime'],
      json['closingTime'],
    );
  }
}

class Note {
  int id;
  String type;
  String? recordKey;
  String? script;
  String? content;
  bool isAnonymous;
  bool? point;
  String createdAt;
  Note_Course course;

  Note(this.id, this.type, this.recordKey, this.script, this.content, this.isAnonymous,
      this.point, this.createdAt, this.course);

  @override
  String toString() {
    return 'Note{id: $id, type: $type, recordKey: $recordKey, script: $script, isAnonymous: $isAnonymous,'
        'point: $point, createdAt: $createdAt, course: $course}';
  }

}