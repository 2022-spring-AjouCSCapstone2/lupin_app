
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/ui/4/post_write.dart';
import 'package:lupin_app/src/ui/4/post_read.dart';
import 'package:lupin_app/src/ui/4/notice_write.dart';
import 'package:lupin_app/src/ui/4/notice_read.dart';
import 'package:lupin_app/src/model/user_model.dart';
import '../../model/course_post_model.dart';
import '../../provider/app_state_provider.dart';
import '../../uiutil/top_navigator.dart';

class Notice extends StatefulWidget {
  final Course course;

  const Notice(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return FutureBuilder(
      future:
      Provider.of<PostProvider>(context, listen: false).getNotice(widget.course.courseId),
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
        var provider = Provider.of<PostProvider>(context, listen: false);
        var provider2 = Provider.of<UserInfoProvider>(context);
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
                        '공지사항',
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
                if (provider2.currentUser!.userType == UserType.professor)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticeWrite(widget.course),
                            ));
                      },
                      icon: Icon(Icons.mode_edit_outline_outlined),
                      label: Text('글 쓰기'),
                    )
                  ),
                // const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );

  }

  ListView buildCourseListView(PostProvider provider) {
    Posts courseNotices = provider.courseNotices!;
    return ListView.separated(
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
                      NoticeRead(courseNotices.posts[index]),
                    );
                  },
                  title: Row(
                    children: [
                      Text(
                        courseNotices.posts[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  subtitle: Transform.translate(
                    offset: const Offset(0, 5),
                    child: Text(
                      courseNotices.posts[index].content,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines:1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Text(
                    '${courseNotices.posts[index].createdAt.substring(2,10).replaceAll('-', '/')}',
                    style: Theme.of(context).textTheme.bodySmall,
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
        itemCount: courseNotices.posts.length);
  }
}

