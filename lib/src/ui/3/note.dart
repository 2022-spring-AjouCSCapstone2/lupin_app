
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/ui/4/note_detail.dart';

import '../../uiutil/top_navigator.dart';

class Note extends StatefulWidget {
  final Course course;

  const Note(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  List<DateTime> dates = [];

  List<String> day = [];
  var date = DateTime(2022,3,1);
  int count = 0;

  String engToKor(Day day) {
    switch (day) {
      case Day.mon:
        return '월';
        break;
      case Day.tue:
        return '화';
        break;
      case Day.wed:
        return '수';
        break;
      case Day.thu:
        return '목';
        break;
      case Day.fri:
        return '금';
        break;
      case Day.empty:
        return '';
        break;
    }
  }

  void MakeDates(Course course) async {
    day = [];
    dates = [];
    initializeDateFormatting('ko_KR', null);

    for (var i in course.timeTables) {
      day.add(engToKor(i.day));
    }

    while(DateFormat('yyyyMMdd').format(date) != DateFormat('yyyyMMdd').format(DateTime.now())) {
      for(var i in day){
        if(i == DateFormat('E', 'ko_KR').format(date).toString()){
          dates.add(date);
          count++;
        }
      }
      date = date.add(Duration(days: 1));
    }
  }

  Future<String> MakeList(Course course) async {
    var test = MakeDates(course);
    if(DateFormat('yyyyMMdd').format(date) == DateFormat('yyyyMMdd').format(DateTime.now())){
      dates = dates.reversed.toList();
      return 'success';
    }
    else return 'fail';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MakeList(widget.course),
      builder: (context, snapshot) {
        if (snapshot.data != 'success') {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          );
        }
        //var provider = Provider.of<NoteProvider>(context, listen: false);
        //dates = provider.MakeList(widget.course) as List<DateTime>;
        else {
          return Scaffold(
            body: SafeArea(
              child: ListView(
                // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 20),
                  topNavigator(
                    context,
                    '강의노트',
                    leftWidget: Container(),
                    rightWidget: Container(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '질문도 하고 퀴즈도 풀고~ 아자아자 오늘도 힘내자!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  buildCourseListView(widget.course.courseId),
                ],
              ),
            ),
          );
        }
      },
    );

  }

  ListView buildCourseListView(courseId) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetail(widget.course, dates[index]),
                          ));
                    },
                    title: Row(
                      children: [
                        Text(
                          DateFormat("yyyy/MM/dd").format(dates[index]),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: count);
  }
}

