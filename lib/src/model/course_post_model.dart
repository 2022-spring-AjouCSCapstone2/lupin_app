import 'package:lupin_app/src/model/post_model.dart';
import 'package:lupin_app/src/model/user_model.dart';

class Posts {
  List<Post> posts;

  Posts(this.posts);

  factory Posts.fromJson(List jsonData) {
    List<Post> posts = [];

    for (var i in jsonData) {
      Map<String, dynamic> userMap = i['user'];

      posts.add(Post(i['id'], i['title'], i['content'], i['createdAt'], User.fromJson(userMap)));
    }
    return Posts(posts);
  }

  @override
  String toString() {
    return 'Posts{posts: $posts}';
  }
}