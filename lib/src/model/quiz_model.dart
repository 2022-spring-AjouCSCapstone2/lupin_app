class QuizModel {
  int no;
  String content;

  QuizModel(this.no, this.content);

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'content': content,
    };
  }
}
