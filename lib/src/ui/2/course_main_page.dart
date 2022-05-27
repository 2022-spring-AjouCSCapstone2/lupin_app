import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/ui/1/after_login_page.dart';
import 'package:lupin_app/src/ui/3/room.dart';
import 'package:lupin_app/src/ui/3/board.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import '../4/post_write.dart';
import '../4/post_read.dart';

class CourseMainPage extends StatefulWidget {
  final Course course;

  CourseMainPage(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Room(widget.course),
                    ));
              },
              icon: Icon(Icons.airplay)),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.course.name,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: buildColumn(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.notifications_on),
              title: Text(
                '공지사항',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Board(widget.course),
                    ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.note),
              title: Text(
                '강의노트',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {

              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                '게시판',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Post(widget.course),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  String buildCourseTimeText(Course course) {
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

    List<TimeTable> timeTable = course.timeTables;

    String text = '';
    if (timeTable.isEmpty) {
      text;
    }

    int count = 0;
    for (var i in timeTable) {
      text +=
          '${engToKor(i.day)}(${timeTable[count].startTime} ~ ${timeTable[count].endTime}) ';
      count++;
    }
    return text;
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '수업 정보',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '담당 교수: ${widget.course.professor.name}',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '이메일: ${widget.course.professor.email}',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        if (buildCourseTimeText(widget.course).isNotEmpty)
          Text(
            '수업 시간 :${buildCourseTimeText(widget.course)}',
            style: TextStyle(fontSize: 15),
          ),
        if (buildCourseTimeText(widget.course).isNotEmpty)
          SizedBox(
            height: 10,
          ),
        if (widget.course.timeTables.isNotEmpty)
          Text(
            '강의실: ${widget.course.timeTables.first.place}',
            style: TextStyle(fontSize: 15),
          ),
        if (widget.course.timeTables.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        Text(
          '내 포인트: 3',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
