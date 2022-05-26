
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lupin_app/src/model/course_model.dart';
import 'package:lupin_app/src/model/user_model.dart';
import 'package:lupin_app/src/provider/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:lupin_app/src/provider/post_provider.dart';
import 'package:lupin_app/src/provider/app_state_provider.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:dio/dio.dart';

import '../../model/course_post_model.dart';
import '../../uiutil/top_navigator.dart';

class Board extends StatefulWidget {
  final Course course;

  const Board(this.course, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
      Provider.of<PostProvider>(context, listen: false).getAllPosts(),
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
        return Scaffold(
          body: SafeArea(
            child: Column(
              // child: ListView(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              children: [
                Container(
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

  ListView buildCourseListView(PostProvider provider) {
    Posts coursePosts = provider.coursePosts!;
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
                        coursePosts.posts[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  subtitle: Transform.translate(
                    offset: const Offset(0, 5),
                    child: Text(
                      coursePosts.posts[index].content,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  trailing: Text(
                    '${coursePosts.posts[index].id}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
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
        itemCount: coursePosts.posts.length);
  }
}

