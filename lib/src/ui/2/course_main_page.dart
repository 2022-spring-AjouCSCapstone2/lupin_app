import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/ui/3/room.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';

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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 20,
            ),
            topNavigator(
              context,
              widget.course.name,
              rightWidget: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Room(widget.course),
                        ));
                  },
                  icon: Icon(Icons.airplay)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(150),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 300,
              width: 400,
              child: Column(),
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
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.note),
              title: Text(
                '강의노트',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(
                '게시판',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
