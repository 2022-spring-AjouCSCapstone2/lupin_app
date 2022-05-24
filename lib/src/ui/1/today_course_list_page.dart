import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/my_courses_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<CourseProvider>(context, listen: false).getTodayCourses(),
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
        var provider = Provider.of<CourseProvider>(context, listen: false);
        return Scaffold(
          body: SafeArea(
            child: Column(
              // child: ListView(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              children: [
                // const SizedBox(height: 20),
                // topNavigator(
                //   context,
                //   '오늘 수업 목록',
                //   leftWidget: Container(),
                //   rightWidget: Container(),
                // ),
                // const SizedBox(height: 20),
                // TextField(
                //   controller: _searchController,
                //   decoration:
                //       const InputDecoration(filled: true, labelText: '검색'),
                // ),
                // const SizedBox(height: 20),
                // buildCourseListView(provider),
                // Text(
                //   "다음 강의",
                //   style: Theme.of(context).textTheme.headline4,
                // ),
                // const SizedBox(height: 15),
                Container(
                  // height: 250,
                  // decoration: BoxDecoration(
                  //   color: Theme.of(context).primaryColor.withAlpha(150),
                  //   borderRadius: const BorderRadius.all(
                  //     Radius.elliptical(13, 13),
                  child: ListView(
                    // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 20),
                      topNavigator(
                        context,
                        '오늘 수업 목록',
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
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      // TextField(
                      //   controller: _searchController,
                      //   decoration: const InputDecoration(filled: true, labelText: '검색'),
                      // ),
                      Container(
                        child: buildCourseListView(provider),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                      ),

                      // Text(
                      //   "다음 강의",
                      //   style: Theme.of(context).textTheme.headline4,
                      // ),
                      // const SizedBox(height: 15),
                      // Container(
                      //   height: 250,
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).primaryColor.withAlpha(150),
                      //     borderRadius: const BorderRadius.all(
                      //       Radius.elliptical(13, 13),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 30),
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

  ListView buildCourseListView(CourseProvider provider) {
    MyCourses todayCourses = provider.todayCourses!;
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(children: [
            Card(
              child: ListTile(
                onTap: () {
                  AppState.pushPage(
                    context,
                    CourseMainPage(todayCourses.courses[index]),
                  );
                },
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                title: Row(
                  children: [
                    Text(
                      todayCourses.courses[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                subtitle: Transform.translate(
                  offset: const Offset(0, 5),
                  child: Text(
                    todayCourses.courses[index].professor.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                trailing: Text(
                  '${todayCourses.courses[index].timeTables.first.startTime} ~ ${todayCourses.courses[index].timeTables.first.endTime}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                isThreeLine: true,
                // return ListTile(
                //   onTap: () {
                //     AppState.pushPage(
                //       context,
                //       CourseMainPage(todayCourses.courses[index]),
                //     );
                //   },
                //   leading: Container(width: 50, color: Colors.grey),
                //   title: Row(
                //     children: [
                //       Text(
                //         todayCourses.courses[index].name,
                //         style: Theme.of(context).textTheme.titleMedium,
              ),
              //   ],
              // ),
              // subtitle: Transform.translate(
              //   offset: const Offset(0, 5),
              //   child: Text(
              //     '손태식 교수님',
              //     style: Theme.of(context).textTheme.bodySmall,
              //   ),
            ),
            // trailing: Text(
            //   '10:30~12:00',
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
            // isThreeLine: true,
          ]);
        },
        separatorBuilder: (context, index) {
          // return const Divider(
          //   height: 0.0001,
          //   color: Colors.grey,
          // );
          return Container();
        },
        itemCount: todayCourses.courses.length);
  }
}
