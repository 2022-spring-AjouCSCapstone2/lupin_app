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

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(json['no'], json['content']);
  }
}
