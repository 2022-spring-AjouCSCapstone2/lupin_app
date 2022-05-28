
class Comment {
  Comment(this.id, this.content);

  int id;
  String content;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['id'],
      json['content'],
    );
  }

  @override
  String toString() {
    return 'Comment{id: $id, content: $content}';
  }
}