import 'package:lupin_app/src/model/comment_model.dart';

class DetailPost {
  int id;
  String title;
  String? content;
  String createdAt;
  String username;
  List<Comment>? comments;

  DetailPost({
    required this.id,
    required this.title,
    this.content,
    required this.createdAt,
    required this.username,
    this.comments,
  });

  factory DetailPost.fromJson(Map<String, dynamic> json) {

    List commentList = json['comments'];

    List<Comment> comments = [];
    for (var i in commentList) {
      comments.add(Comment.fromJson(i));
    }

    return DetailPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['createdAt'],
      username: json['username'],
      comments: comments,
    );
  }

  @override
  String toString() {
    return 'DetailPost{DetailPost: $DetailPost';
  }
}