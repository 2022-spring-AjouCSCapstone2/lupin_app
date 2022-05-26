import 'package:flutter/cupertino.dart';
import 'package:lupin_app/src/apis.dart';
import 'package:lupin_app/src/model/course_post_model.dart';

class PostProvider extends ChangeNotifier {
  Posts? coursePosts;

  PostProvider();

  Future<Posts?> getAllPosts() async {
    Posts posts = await Apis.instance.getBoard();
    coursePosts = posts;
    return coursePosts;
  }
}
