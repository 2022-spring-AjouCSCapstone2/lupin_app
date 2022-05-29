import 'package:lupin_app/src/model/note_model.dart';

class Notes {
  List<Note> notes;

  Notes(this.notes);

  factory Notes.fromJson(List jsonData) {
    List<Note> notes = [];

    for (var i in jsonData) {
      Map<String, dynamic> courseMap = i['course'];
      notes.add(Note(i['id'], i['type'], i['recordKey'], i['script'], i['content'], i['summary'],
          i['isAnonymous'], i['point'], i['createdAt'], Note_Course.fromJson(courseMap)));
    }
    return Notes(notes);
  }

  @override
  String toString() {
    return 'Notes{notes: $notes}';
  }
}