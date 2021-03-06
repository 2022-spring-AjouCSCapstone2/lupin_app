import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/ui/3/room.dart';

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
            // topNavigator(
            //   context,
            //   widget.course.name,
            //   textSize: 24,
            //   rightWidget: IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => Room(widget.course),
            //             ));
            //       },
            //       icon: Icon(Icons.airplay)),
            // ),
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
                '????????????',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.note),
              title: Text(
                '????????????',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                '?????????',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
          return '???';
          break;
        case Day.tue:
          return '???';
          break;
        case Day.wed:
          return '???';
          break;
        case Day.thu:
          return '???';
          break;
        case Day.fri:
          return '???';
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
          '?????? ??????',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '?????? ??????: ${widget.course.professor.name}',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '?????????: ${widget.course.professor.email}',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        if (buildCourseTimeText(widget.course).isNotEmpty)
          Text(
            '?????? ?????? :${buildCourseTimeText(widget.course)}',
            style: TextStyle(fontSize: 15),
          ),
        if (buildCourseTimeText(widget.course).isNotEmpty)
          SizedBox(
            height: 10,
          ),
        if (widget.course.timeTables.isNotEmpty)
          Text(
            '?????????: ${widget.course.timeTables.first.place}',
            style: TextStyle(fontSize: 15),
          ),
        if (widget.course.timeTables.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        Text(
          '??? ?????????: 3',
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
