import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/model/course_post_model.dart';
import 'package:lupin_app/src/model/post_detail_model.dart';

class PostProvider extends ChangeNotifier {
  Posts? coursePosts;
  Posts? courseNotices;
  DetailPost? detailPosts;

  PostProvider();

  Future<Posts?> getAllPosts(courseId) async {
    Posts posts = await Apis.instance.getBoard(courseId);
    coursePosts = posts;
    return coursePosts;
  }

  Future<Posts?> getNotice(courseId) async {
    Posts posts = await Apis.instance.getNotice(courseId);
    courseNotices = posts;
    return courseNotices;
  }

  Future<DetailPost?> getPost(postId) async {
    DetailPost post = await Apis.instance.getPost(postId);
    detailPosts = post;
    return detailPosts;
  }

}
