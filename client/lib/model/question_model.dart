import 'dart:convert';

class Question {
  String questionTitle = "";
  //List<Answer> answerList = <Answer>[];
  String answerList = "";
  int questionIndex = 0;

  Question(
      {required this.questionTitle,
      required this.answerList,
      required this.questionIndex});
  factory Question.fromJson(Map<dynamic, dynamic> json) {
    return Question(
        questionTitle: json["questionTitle"],
        answerList: json["answerList"],
        questionIndex: json["questionIndex"]);
  }

  static Map<String, dynamic> toMap(Question question) => {
        'questionTitle': question.questionTitle,
        'answerList': question.answerList,
        'questionIndex': question.questionIndex,
      };

  static String encode(List<Question> questions) => json.encode(
        questions
            .map<Map<String, dynamic>>((question) => Question.toMap(question))
            .toList(),
      );

  static List<Question> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Question>((item) => Question.fromJson(item))
          .toList();
}