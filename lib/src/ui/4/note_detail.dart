
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/course_note_model.dart';
import 'package:provider/provider.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/provider/note_provider.dart';
import 'package:lupin_app/src/ui/4/post_write.dart';
import 'package:lupin_app/src/ui/4/post_read.dart';

import '../../model/course_post_model.dart';
import '../../provider/app_state_provider.dart';
import '../../uiutil/top_navigator.dart';

class NoteDetail extends StatefulWidget {
  final Course course;
  final DateTime date;

  const NoteDetail(this.course, this.date, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return FutureBuilder(
      future:
      //Provider.of<NoteProvider>(context, listen: false).getNote(widget.course.courseId, '20220528'),
      Provider.of<NoteProvider>(context, listen: false).getNote(widget.course.courseId, DateFormat('yyyyMMdd').format(widget.date)),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
        var provider = Provider.of<NoteProvider>(context, listen: false);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  child: ListView(
                    // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 20),
                      topNavigator(
                        context,
                        '강의자료',
                        leftWidget: Container(),
                        rightWidget: Container(),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          DateFormat('yyyy/MM/dd').format(widget.date),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      Container(
                        child: buildCourseListView(provider),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );

  }

  ListView buildCourseListView(NoteProvider provider) {
    Notes courseNotes = provider.noteCourse!;
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {
                  },
                  title: Row(
                    children: [
                      Text(
                        courseNotes.notes[index].type,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  subtitle: Transform.translate(
                    offset: const Offset(0, 5),
                    child: Text(
                      courseNotes.notes[index].content,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines:1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  isThreeLine: true,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {

          return Container();
        },
        itemCount: courseNotes.notes.length);
  }
}

