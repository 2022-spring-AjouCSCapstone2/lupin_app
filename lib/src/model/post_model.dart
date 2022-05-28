import 'package:lupin_app/src/model/user_model.dart';

class Post {
  int id;
  String title;
  String content;
  String createdAt;
  User user;

  Post(this.id, this.title, this.content, this.createdAt, this.user);

  @override
  String toString() {
    return 'Post{id: $id, title: $title, content: $content, createdAt: $createdAt, user: $user}';
  }
}
