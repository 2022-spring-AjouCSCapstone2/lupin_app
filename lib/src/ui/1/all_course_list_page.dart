import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/my_courses_model.dart';
import 'package:lupin_app/src/model/timetable_model.dart';
import 'package:lupin_app/src/provider/app_state_provider.dart';
import 'package:lupin_app/src/provider/course_provider.dart';
import 'package:lupin_app/src/ui/2/course_main_page.dart';
import 'package:lupin_app/src/uiutil/top_navigator.dart';
import 'package:provider/provider.dart';

class AllCourseListPage extends StatefulWidget {
  const AllCourseListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllCourseListPageState();
}

class _AllCourseListPageState extends State<AllCourseListPage> {
  // List week = ['월', '화', '수', '목', '금'];
  // List<List<Course>> weekCourses = [[], [], [], [], []];
  // var kColumnLength = 22;
  // double kFirstColumnHeight = 20;
  // double kBoxSize = 52;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CourseProvider>(context, listen: false);
    MyCourses userCourses = provider.userCourses!;

    return ListView(
      children: [
        const SizedBox(height: 20),
        topNavigator(
          context,
          '전체 수업 목록',
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
        Container(
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        onTap: () {
                          AppState.pushPage(
                            context,
                            CourseMainPage(userCourses.courses[index]),
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
                              userCourses.courses[index].name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        subtitle: Transform.translate(
                          offset: const Offset(0, 5),
                          child: Text(
                            userCourses.courses[index].professor.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        trailing:
                            buildCourseTimeText(userCourses, index, context),
                        isThreeLine: true,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                // return const Divider(
                //   height: 0.0001,
                //   color: Colors.grey,
                // );
                return Container();
              },
              itemCount: userCourses.courses.length),
        ),
      ],
    );
  }

  Text buildCourseTimeText(
      MyCourses userCourses, int index, BuildContext context) {
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

    List<TimeTable> timeTable = userCourses.courses[index].timeTables;

    String text = '';
    if (timeTable.isEmpty) {
      return Text(text);
    }

    int count = 0;
    for (var i in timeTable) {
      text +=
          '${engToKor(i.day)} ${userCourses.courses[index].timeTables[count].startTime} ~ ${userCourses.courses[index].timeTables[count].endTime}\n';
      count++;
    }
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
// @override
// Widget build(BuildContext context) {
//   var provider = Provider.of<CourseProvider>(context, listen: false);
//   List<Course> courses = [];
//
//   return SafeArea(
//     child: ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       children: [
//         const SizedBox(height: 20),
//         topNavigator(
//           context,
//           "수업 시간표",
//           leftWidget: Container(),
//           rightWidget: Container(),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           height: kColumnLength / 2 * kBoxSize + kColumnLength,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               buildFirstColumn(),
//               const VerticalDivider(
//                 color: Colors.grey,
//                 width: 0,
//               ),
//               ...buildDayColumn(0),
//               ...buildDayColumn(1),
//               ...buildDayColumn(2),
//               ...buildDayColumn(3),
//               ...buildDayColumn(4, hasDivider: false),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// void calcDayCourse() {
//   var provider = Provider.of<CourseProvider>(context, listen: false);
//
// }
//
// List<Widget> buildDayColumn(int index, {bool hasDivider = true}) {
//   double width = MediaQuery.of(context).size.width;
//   calcDayCourse();
//   return [
//     Expanded(
//       flex: 4,
//       child: Stack(
//         children: [
//           if (index == 1)
//             Positioned(
//               child: Container(
//                 color: Colors.green,
//               ),
//               top: kFirstColumnHeight + kBoxSize / 2,
//               height: kBoxSize + kBoxSize * 0.5,
//               width: width,
//             ),
//           if (index == 0)
//             Positioned(
//               child: Container(
//                 color: Colors.amberAccent,
//               ),
//               top: kFirstColumnHeight + kBoxSize * 7,
//               height: (kBoxSize + kBoxSize * 0.5) * 2,
//               width: width,
//             ),
//           if (index == 3)
//             Positioned(
//               child: Container(
//                 color: Colors.red,
//               ),
//               top: kFirstColumnHeight + kBoxSize * 3,
//               height: kBoxSize + kBoxSize * 0.5,
//               width: width,
//             ),
//           if (index == 2)
//             Positioned(
//               child: Container(
//                 color: Colors.blueAccent,
//               ),
//               top: kFirstColumnHeight + kBoxSize * 6,
//               height: kBoxSize + kBoxSize * 0.5,
//               width: width,
//             ),
//           Column(
//             children: [
//               SizedBox(
//                 height: 20,
//                 child: Text(
//                   '${week[index]}',
//                 ),
//               ),
//               ...List.generate(
//                 kColumnLength,
//                 (index) {
//                   if (index % 2 == 0) {
//                     return const Divider(
//                       color: Colors.grey,
//                       height: 0,
//                     );
//                   }
//                   return SizedBox(
//                     height: kBoxSize,
//                     child: Container(),
//                   );
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//     if (hasDivider == true)
//       const VerticalDivider(
//         color: Colors.grey,
//         width: 0,
//       ),
//   ];
// }
//
// Expanded buildFirstColumn() {
//   return Expanded(
//     child: Column(
//       children: [
//         SizedBox(
//           height: kFirstColumnHeight,
//         ),
//         ...List.generate(
//           kColumnLength,
//           (index) {
//             if (index % 2 == 0) {
//               return const Divider(
//                 color: Colors.grey,
//                 height: 0,
//               );
//             }
//             return SizedBox(
//               height: kBoxSize,
//               child: Center(child: Text('${index ~/ 2 + 9}')),
//             );
//           },
//         ),
//       ],
//     ),
//   );
// }
//
// Column buildCourseRow(int time) {
//   return Column(
//     children: [
//       SizedBox(
//         height: 50,
//         child: Row(
//           children: [
//             SizedBox(
//               width: 20,
//               child: Center(
//                 child: Text(
//                   time.toString(),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ...List.generate(
//                     10,
//                     (index) {
//                       if (index % 2 == 0) {
//                         return const VerticalDivider(
//                             color: Colors.black, width: 0);
//                       }
//                       return Expanded(
//                         child: Container(
//                           child: Text(week[(index + 1) ~/ 2 - 1]),
//                         ),
//                       );
//                     },
//                   ),
//                   Container()
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       const Divider(
//         color: Colors.grey,
//         height: 0,
//       ),
//     ],
//   );
// }
//
// SizedBox buildTitleRow() {
//   return SizedBox(
//     height: 20,
//     child: Row(
//       children: [
//         const SizedBox(
//           width: 20,
//         ),
//         Flexible(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ...List.generate(
//                 10,
//                 (index) {
//                   if (index % 2 == 0) {
//                     return const VerticalDivider(
//                         color: Colors.black, width: 0);
//                   }
//                   return Text(week[(index + 1) ~/ 2 - 1]);
//                 },
//               ),
//               Container()
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
