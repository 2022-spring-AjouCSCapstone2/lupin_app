import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/provider/app_state_provider.dart';
import 'package:lupin_app/src/provider/course_provider.dart';
import 'package:lupin_app/src/ui/2/course_main_page.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';
import 'package:provider/provider.dart';

class TodayCourseListPage extends StatefulWidget {
  const TodayCourseListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayCourseListPageState();
}

class _TodayCourseListPageState extends State<TodayCourseListPage> {
  List test = [];
  int count = 0;

  var _searchController;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CourseProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            const SizedBox(height: 20),
            topNavigator(
              context,
              '오늘 수업 목록',
              rightWidget: Container(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(filled: true, labelText: '검색'),
            ),
            const SizedBox(height: 20),
            buildCourseListView(provider),
            Text(
              "다음 강의",
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 15),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(150),
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(13, 13),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  ListView buildCourseListView(CourseProvider provider) {
    var courses = provider.userCourses;
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              AppState.pushPage(
                context,
                CourseMainPage(title: courses[index].name),
              );
            },
            leading: Container(width: 50, color: Colors.grey),
            title: Row(
              children: [
                Text(
                  courses[index].name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            subtitle: Transform.translate(
              offset: const Offset(0, 5),
              child: Text(
                '손태식 교수님',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            trailing: Text(
              '10:30~12:00',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            isThreeLine: true,
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0.0001,
            color: Colors.grey,
          );
        },
        itemCount: courses.length);
  }
}
